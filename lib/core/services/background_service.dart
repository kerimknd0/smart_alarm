import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:uuid/uuid.dart';

import '../../features/alarm/data/models/alarm_model.dart';
import '../../features/alarm/domain/entities/alarm.dart';
import '../constants/app_constants.dart';

// ══════════════════════════════════════════════════════════════
// SABİTLER
// ══════════════════════════════════════════════════════════════

const String _bgChannelId = 'smart_alarm_bg_channel';
const String _bgChannelName = 'Uyku Algılama Servisi';
const int _bgNotifId = 9999;
const int _alarmNotifId = 8888;

// SharedPreferences anahtarları
const String _kScreenOffTime = 'bg_screen_off_time';
const String _kLastInteraction = 'bg_last_interaction';
const String _kMonitoring = 'bg_monitoring_active';
const String _kSleepDetected = 'bg_sleep_detected';
const String _kScreenState = 'bg_screen_state';
const String _kAlarmFiring = 'bg_alarm_firing';
const String _kAlarmFiringId = 'bg_alarm_firing_id';
const String _kWasOutsideRange = 'bg_was_outside_range';

// ══════════════════════════════════════════════════════════════
// YAPILANDIRMA
// ══════════════════════════════════════════════════════════════

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  final plugin = FlutterLocalNotificationsPlugin();
  const channel = AndroidNotificationChannel(
    _bgChannelId,
    _bgChannelName,
    description: 'Arka plan servisi',
    importance: Importance.low,
  );
  await plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      autoStartOnBoot: true,
      notificationChannelId: _bgChannelId,
      initialNotificationTitle: AppConstants.appName,
      initialNotificationContent: 'Uyku algılama aktif',
      foregroundServiceNotificationId: _bgNotifId,
      foregroundServiceTypes: [AndroidForegroundType.specialUse],
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

// ══════════════════════════════════════════════════════════════
// UI TARAFINDAN ÇAĞRILAN FONKSİYONLAR
// ══════════════════════════════════════════════════════════════

const _screenChannel = MethodChannel('com.example.smart_alarm/screen_state');

/// Servisi başlat.
Future<void> startBackgroundService() async {
  final service = FlutterBackgroundService();
  if (await service.isRunning()) return;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kMonitoring, true);
  await prefs.setBool(_kSleepDetected, false);
  await prefs.setString(_kScreenState, 'on');
  await prefs.remove(_kScreenOffTime);
  await prefs.remove(_kAlarmFiring);
  await prefs.remove(_kAlarmFiringId);
  await prefs.remove(_kWasOutsideRange);
  await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());

  await service.startService();
  try {
    await _screenChannel.invokeMethod('startScreenService');
  } catch (_) {}
}

/// Servisi durdur.
Future<void> stopBackgroundService() async {
  final service = FlutterBackgroundService();
  if (await service.isRunning()) service.invoke('stop');

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kMonitoring, false);
  await prefs.setBool(_kSleepDetected, false);
  await prefs.remove(_kScreenOffTime);
  await prefs.remove(_kAlarmFiring);
  await prefs.remove(_kAlarmFiringId);

  try {
    await _screenChannel.invokeMethod('stopScreenService');
  } catch (_) {}
}

/// Ekran açıldı (app resumed).
Future<void> notifyScreenOn() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(_kAlarmFiring) ?? false) return; // alarm çalıyorsa dokunma
  await prefs.setString(_kScreenState, 'on');
  await prefs.remove(_kScreenOffTime);
  await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());
}

/// App arka plana gitti.
Future<void> notifyAppBackgrounded() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(_kAlarmFiring) ?? false) return;
  final screenMode =
      prefs.getBool(AppConstants.prefScreenModeDetection) ?? true;
  if (screenMode) {
    await prefs.setString(_kScreenState, 'off');
    await prefs.setString(_kScreenOffTime, DateTime.now().toIso8601String());
  } else {
    await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());
  }
}

/// Kullanıcı etkileşimi.
Future<void> notifyUserInteraction() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(_kAlarmFiring) ?? false) return;
  await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());
}

/// Algılama zamanlayıcılarını sıfırla.
Future<void> resetDetectionTimers() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());
  await prefs.remove(_kScreenOffTime);
  await prefs.setBool(_kSleepDetected, false);
}

/// Çalan alarmı durdur ve algılama sistemini sıfırla.
Future<void> stopFiringAlarm() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_kAlarmFiring);
  await prefs.remove(_kAlarmFiringId);
  final plugin = FlutterLocalNotificationsPlugin();
  await plugin.cancel(id: _alarmNotifId);

  // Algılama sistemini sıfırla — yeni döngü başlasın
  await prefs.setString(_kLastInteraction, DateTime.now().toIso8601String());
  await prefs.remove(_kScreenOffTime);
  await prefs.setBool(_kSleepDetected, false);
}

/// Durum oku (UI polling için).
Future<BackgroundServiceStatus> getBackgroundServiceStatus() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.reload();

  final monitoring = prefs.getBool(_kMonitoring) ?? false;
  final sleepDetected = prefs.getBool(_kSleepDetected) ?? false;
  final screenState = prefs.getString(_kScreenState) ?? 'on';
  final screenMode =
      prefs.getBool(AppConstants.prefScreenModeDetection) ?? true;
  final autoDetection = prefs.getBool(AppConstants.prefAutoDetection) ?? true;
  final alarmFiring = prefs.getBool(_kAlarmFiring) ?? false;

  int remaining = 0;
  bool counting = false;

  if (monitoring && !sleepDetected && autoDetection && !alarmFiring) {
    final wait =
        prefs.getInt(AppConstants.prefWaitSeconds) ??
        AppConstants.defaultWaitSeconds;

    if (screenMode) {
      final offStr = prefs.getString(_kScreenOffTime);
      if (screenState == 'off' && offStr != null) {
        final offTime = DateTime.tryParse(offStr);
        if (offTime != null) {
          final elapsed = DateTime.now().difference(offTime).inSeconds;
          remaining = wait - elapsed;
          if (remaining < 0) remaining = 0;
          counting = true;
        }
      }
    } else {
      final interStr = prefs.getString(_kLastInteraction);
      if (interStr != null) {
        final inter = DateTime.tryParse(interStr);
        if (inter != null) {
          final elapsed = DateTime.now().difference(inter).inSeconds;
          remaining = wait - elapsed;
          if (remaining < 0) remaining = 0;
          counting = remaining > 0;
        }
      }
    }
  }

  return BackgroundServiceStatus(
    isMonitoring: monitoring,
    sleepDetected: sleepDetected,
    isScreenOff: screenState == 'off',
    isCountingDown: counting,
    screenModeDetection: screenMode,
    autoDetection: autoDetection,
    remainingSeconds: remaining,
    alarmFiring: alarmFiring,
    outsideTimeRange: monitoring && autoDetection && !_isInActiveTimeRange(prefs),
  );
}

// ══════════════════════════════════════════════════════════════
// iOS ARKA PLAN
// ══════════════════════════════════════════════════════════════

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

// ══════════════════════════════════════════════════════════════
// ARKA PLAN SERVİS ENTRY POINT (AYRI İZOLAT)
// ══════════════════════════════════════════════════════════════

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  tz_data.initializeTimeZones();

  final prefs = await SharedPreferences.getInstance();

  // -- Bildirim eklentisini hazırla --
  final notif = FlutterLocalNotificationsPlugin();
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);
  await notif.initialize(
    settings: initSettings,
    onDidReceiveNotificationResponse: (r) {
      debugPrint('[BgService] Bildirime tıklandı: ${r.payload}');
    },
  );

  // Alarm kanalı onStart'ta dinamik olarak oluşturulacak (ses seçimine göre)
  // -- Stop mesajı --
  service.on('stop').listen((_) async {
    await prefs.setBool(_kMonitoring, false);
    await prefs.setBool(_kSleepDetected, false);
    await prefs.remove(_kScreenOffTime);
    await prefs.remove(_kLastInteraction);
    await prefs.remove(_kAlarmFiring);
    await prefs.remove(_kAlarmFiringId);
    await prefs.remove(_kWasOutsideRange);
    await service.stopSelf();
  });

  // ══════════════════════════════════════════════════════════
  // ANA DÖNGÜ — her 5 saniyede bir
  // ══════════════════════════════════════════════════════════
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    await prefs.reload();

    // Servis aktif mi?
    if (!(prefs.getBool(_kMonitoring) ?? false)) {
      timer.cancel();
      await service.stopSelf();
      return;
    }

    // ─────────────────────────────────────────────────────
    // 1) ALARM ÇALIYOR MU? (zaten tetiklendi, bir şey yapma)
    // ─────────────────────────────────────────────────────
    if (prefs.getBool(_kAlarmFiring) ?? false) {
      _updateFg(notif, '🔔 ALARM ÇALIYOR!');
      return;
    }

    // ─────────────────────────────────────────────────────
    // 2) ZAMANI GELMİŞ ALARM VAR MI? → HEMEN ÇAL
    //    Manuel ve otomatik tüm alarmları kontrol eder.
    // ─────────────────────────────────────────────────────
    final fired = await _tryFireAlarm(prefs, notif);
    if (fired) return;

    // ─────────────────────────────────────────────────────
    // 3) OTOMATİK ALGILAMA KAPALI MI?
    // ─────────────────────────────────────────────────────
    final auto = prefs.getBool(AppConstants.prefAutoDetection) ?? true;
    if (!auto) {
      _updateFg(notif, 'Otomatik algılama kapalı — manuel alarmlar izleniyor');
      return;
    }

    // ─────────────────────────────────────────────────────
    // 3.5) ÇALIŞMA ARALIĞI KONTROLÜ
    //      Aralık dışındaysa yeni algılama/geri sayım başlamaz.
    //      AMA zaten kurulmuş alarmlar ETKİLENMEZ.
    // ─────────────────────────────────────────────────────
    final outsideRange = !_isInActiveTimeRange(prefs);
    if (outsideRange) {
      // Aralık dışındayız — flag'i işaretle
      await prefs.setBool(_kWasOutsideRange, true);

      // Uyku algılanmışsa (alarm kurulmuş), uyanma kontrolünü YAP
      if (prefs.getBool(_kSleepDetected) ?? false) {
        if (_shouldCheckWakeUp(prefs) && _isUserAwake(prefs)) {
          await _cancelPendingAutoAlarms(prefs);
          await prefs.setBool(_kSleepDetected, false);
          _updateFg(notif, '🔄 Hareket algılandı — alarm iptal edildi');
        } else {
          _updateFg(notif, '😴 Uyku algılandı — alarm kuruldu');
        }
      } else {
        _updateFg(notif, '🕐 Çalışma aralığı dışında — algılama beklemede');
      }
      return;
    }

    // Aralığa yeni girdik mi? Evet ise zamanlayıcıları sıfırla
    if (prefs.getBool(_kWasOutsideRange) ?? false) {
      await prefs.setBool(_kWasOutsideRange, false);
      final now = DateTime.now().toIso8601String();
      // Eski lastInteraction/screenOffTime'dan kalan süre yüzünden
      // anında alarm kurulmasını engelle — zamanlayıcıları şimdi'ye ayarla
      await prefs.setString(_kLastInteraction, now);
      // Ekran kapalıysa screenOffTime'ı da şimdi'ye ayarla (geri sayım sıfırdan başlasın)
      final screenState = prefs.getString(_kScreenState) ?? 'on';
      if (screenState == 'off') {
        await prefs.setString(_kScreenOffTime, now);
      } else {
        await prefs.remove(_kScreenOffTime);
      }
      debugPrint('[BgService] ⏰ Çalışma aralığına girildi — zamanlayıcılar sıfırlandı');
      // Bu tick'te devam etme — sonraki tick'te reload ile temiz değerler okunacak
      _updateFg(notif, '⏰ Çalışma aralığına girildi — geri sayım başlıyor');
      return;
    }

    // ─────────────────────────────────────────────────────
    // 4) UYKU ALGILANDI MI? (alarm kuruldu, bekleniyor)
    // ─────────────────────────────────────────────────────
    if (prefs.getBool(_kSleepDetected) ?? false) {
      // Kullanıcı uyandı mı kontrol et — AMA alarm 2 dk içindeyse YAPMA
      if (_shouldCheckWakeUp(prefs) && _isUserAwake(prefs)) {
        await _cancelPendingAutoAlarms(prefs);
        await prefs.setBool(_kSleepDetected, false);
        _updateFg(notif, '🔄 Hareket algılandı — alarm iptal edildi');
      } else {
        _updateFg(notif, '😴 Uyku algılandı — alarm kuruldu');
      }
      return;
    }

    // ─────────────────────────────────────────────────────
    // 5) GERİ SAYIM — uyku algılaması için bekleme
    // ─────────────────────────────────────────────────────
    final screenMode =
        prefs.getBool(AppConstants.prefScreenModeDetection) ?? true;
    final waitSec =
        prefs.getInt(AppConstants.prefWaitSeconds) ??
        AppConstants.defaultWaitSeconds;

    final inactiveSeconds = _getInactiveSeconds(prefs, screenMode);

    if (inactiveSeconds == null) {
      if (screenMode) {
        _updateFg(notif, '📱 Ekran açık — bekleniyor...');
      } else {
        _updateFg(notif, '📱 İzleniyor...');
      }
      return;
    }

    final remaining = waitSec - inactiveSeconds;

    if (remaining <= 0) {
      // -- UYKU ALGILANDI! Alarm oluştur --
      final sleepStart = DateTime.now().subtract(
        Duration(seconds: inactiveSeconds),
      );
      await _createAutoAlarm(prefs, sleepStart);
      _updateFg(notif, '😴 Uyku algılandı — alarm kuruldu');
    } else {
      final m = remaining ~/ 60;
      final s = remaining % 60;
      final icon = screenMode ? '🌙' : '⏳';
      final label = screenMode ? 'Ekran kapalı' : 'Hareketsizlik';
      final t = m > 0 ? '$m dk $s sn' : '$s sn';
      _updateFg(notif, '$icon $label — $t sonra alarm');
    }
  });
}

// ══════════════════════════════════════════════════════════════
// ALARM ÇALMA
// ══════════════════════════════════════════════════════════════

/// Zamanı gelmiş aktif alarm varsa çalar, true döndürür.
Future<bool> _tryFireAlarm(
  SharedPreferences prefs,
  FlutterLocalNotificationsPlugin notif,
) async {
  final raw = prefs.getString(AppConstants.prefAlarms);
  if (raw == null || raw.isEmpty) return false;

  List<dynamic> list;
  try {
    list = json.decode(raw) as List<dynamic>;
  } catch (_) {
    return false;
  }

  final now = DateTime.now();

  for (final item in list) {
    if (item is! Map<String, dynamic>) continue;
    if (!(item['isActive'] as bool? ?? true)) continue;

    final atStr = item['scheduledAt'] as String?;
    if (atStr == null) continue;
    final at = DateTime.tryParse(atStr);
    if (at == null) continue;

    final id = item['id'] as String?;
    if (id == null) continue;

    // Alarm zamanı geldi mi? (0 <= gecikme < 5 dk)
    final delay = now.difference(at).inSeconds;
    if (delay < 0 || delay >= 300) continue;

    // Zaten bu alarm çalıyor mu?
    if (prefs.getString(_kAlarmFiringId) == id) continue;

    debugPrint('[BgService] 🔔 ALARM! id=$id, at=$at, gecikme=${delay}s');

    // İşaretle
    await prefs.setBool(_kAlarmFiring, true);
    await prefs.setString(_kAlarmFiringId, id);

    // Sesli fullscreen bildirim — Android bildirim sistemi sesi çalar
    await _showAlarmNotif(notif, prefs, id, item);
    _updateFg(notif, '🔔 ALARM ÇALIYOR!');
    return true;
  }
  return false;
}

/// Sesli alarm bildirimi — Android bildirim sistemi sesi çalar + fullScreenIntent.
Future<void> _showAlarmNotif(
  FlutterLocalNotificationsPlugin notif,
  SharedPreferences prefs,
  String alarmId,
  Map<String, dynamic> alarmJson,
) async {
  String body = 'Alarm zamanı geldi!';
  if (alarmJson['type'] == 'automatic') {
    final ss = DateTime.tryParse(alarmJson['sleepStart'] as String? ?? '');
    final sa = DateTime.tryParse(alarmJson['scheduledAt'] as String? ?? '');
    if (ss != null && sa != null) {
      final d = sa.difference(ss);
      body =
          'Kalkma zamanı! ${d.inHours}s ${d.inMinutes.remainder(60)}dk uyudunuz.';
    }
  }

  // Kullanıcının seçtiği alarm sesini oku
  final soundUri =
      prefs.getString(AppConstants.prefAlarmSound) ?? 'default';

  // Dinamik kanal ID — ses değiştiğinde yeni kanal oluşsun
  // (Android kanal sesi değiştirilemez, yeni kanal gerekli)
  final channelSuffix = soundUri.hashCode.abs().toString();
  final alarmChannelId = 'smart_alarm_sound_$channelSuffix';

  // Ses ayarı
  UriAndroidNotificationSound? notifSound;
  if (soundUri != 'default' && soundUri.isNotEmpty) {
    notifSound = UriAndroidNotificationSound(soundUri);
  }

  // Kanal oluştur (ses + alarm kategorisi)
  final alarmChannel = AndroidNotificationChannel(
    alarmChannelId,
    'Alarm Sesi',
    description: 'Alarm çaldığında ses çalar',
    importance: Importance.max,
    playSound: true,
    sound: notifSound,
    audioAttributesUsage: AudioAttributesUsage.alarm,
    enableVibration: true,
  );
  await notif
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(alarmChannel);

  final android = AndroidNotificationDetails(
    alarmChannelId,
    'Alarm Sesi',
    channelDescription: 'Alarm çaldığında ses çalar',
    importance: Importance.max,
    priority: Priority.max,
    fullScreenIntent: true,
    category: AndroidNotificationCategory.alarm,
    visibility: NotificationVisibility.public,
    autoCancel: false,
    ongoing: true,
    playSound: true,
    sound: notifSound,
    audioAttributesUsage: AudioAttributesUsage.alarm,
    enableVibration: true,
    additionalFlags: Int32List.fromList([4]), // FLAG_INSISTENT = 4
  );

  await notif.show(
    id: _alarmNotifId,
    title: '⏰ Alarm!',
    body: body,
    notificationDetails: NotificationDetails(android: android),
    payload: alarmId,
  );
}

// ══════════════════════════════════════════════════════════════
// UYKU ALGILAMA
// ══════════════════════════════════════════════════════════════

/// Şu anki saat çalışma aralığı içinde mi?
/// Gece geçişi destekler: ör. 22:00 → 06:00
bool _isInActiveTimeRange(SharedPreferences prefs) {
  final startH = prefs.getInt(AppConstants.prefAutoAlarmStartHour) ??
      AppConstants.defaultAutoAlarmStartHour;
  final startM = prefs.getInt(AppConstants.prefAutoAlarmStartMinute) ??
      AppConstants.defaultAutoAlarmStartMinute;
  final endH = prefs.getInt(AppConstants.prefAutoAlarmEndHour) ??
      AppConstants.defaultAutoAlarmEndHour;
  final endM = prefs.getInt(AppConstants.prefAutoAlarmEndMinute) ??
      AppConstants.defaultAutoAlarmEndMinute;

  final now = DateTime.now();
  final nowMinutes = now.hour * 60 + now.minute;
  final startMinutes = startH * 60 + startM;
  final endMinutes = endH * 60 + endM;

  if (startMinutes <= endMinutes) {
    // Aynı gün içi: ör. 08:00 → 18:00
    return nowMinutes >= startMinutes && nowMinutes < endMinutes;
  } else {
    // Gece geçişi: ör. 22:00 → 06:00
    return nowMinutes >= startMinutes || nowMinutes < endMinutes;
  }
}

/// Hareketsizlik süresini saniye olarak hesaplar. null = henüz bekleme yok.
int? _getInactiveSeconds(SharedPreferences prefs, bool screenMode) {
  if (screenMode) {
    final state = prefs.getString(_kScreenState) ?? 'on';
    if (state != 'off') return null;
    final offStr = prefs.getString(_kScreenOffTime);
    if (offStr == null) return null;
    final offTime = DateTime.tryParse(offStr);
    if (offTime == null) return null;
    return DateTime.now().difference(offTime).inSeconds;
  } else {
    final interStr = prefs.getString(_kLastInteraction);
    if (interStr == null) return null;
    final inter = DateTime.tryParse(interStr);
    if (inter == null) return null;
    return DateTime.now().difference(inter).inSeconds;
  }
}

/// Alarm 2 dk içinde mi? İçindeyse uyanma kontrolü yapma.
bool _shouldCheckWakeUp(SharedPreferences prefs) {
  final raw = prefs.getString(AppConstants.prefAlarms);
  if (raw == null || raw.isEmpty) return true;

  List<dynamic> list;
  try {
    list = json.decode(raw) as List<dynamic>;
  } catch (_) {
    return true;
  }

  final now = DateTime.now();
  for (final item in list) {
    if (item is! Map<String, dynamic>) continue;
    if (!(item['isActive'] as bool? ?? true)) continue;
    if (item['type'] != 'automatic') continue;

    final atStr = item['scheduledAt'] as String?;
    if (atStr == null) continue;
    final at = DateTime.tryParse(atStr);
    if (at == null) continue;

    final diff = at.difference(now).inSeconds;
    if (diff > -10 && diff < 120) return false; // 2 dk içinde, kontrol etme!
  }
  return true;
}

/// Kullanıcı uyanmış mı? (uyku algılandıktan sonra hareket kontrolü)
bool _isUserAwake(SharedPreferences prefs) {
  final screenMode =
      prefs.getBool(AppConstants.prefScreenModeDetection) ?? true;
  if (screenMode) {
    return (prefs.getString(_kScreenState) ?? 'on') == 'on';
  } else {
    final interStr = prefs.getString(_kLastInteraction);
    if (interStr == null) return false;
    final inter = DateTime.tryParse(interStr);
    if (inter == null) return false;
    return DateTime.now().difference(inter).inSeconds < 60;
  }
}

/// Otomatik alarm oluştur ve SharedPreferences'a kaydet.
Future<void> _createAutoAlarm(
  SharedPreferences prefs,
  DateTime sleepStart,
) async {
  await prefs.setBool(_kSleepDetected, true);

  final sleepMin =
      prefs.getInt(AppConstants.prefSleepMinutes) ??
      AppConstants.defaultSleepMinutes;
  final snoozeMin =
      prefs.getInt(AppConstants.prefSnoozeMinutes) ??
      AppConstants.defaultSnoozeDurationMinutes;

  var alarmTime = sleepStart.add(Duration(minutes: sleepMin));
  final now = DateTime.now();

  // Alarm zamanı geçmişte ise şu andan 10 sn sonraya ayarla
  if (alarmTime.isBefore(now)) {
    alarmTime = now.add(const Duration(seconds: 10));
  }

  final alarm = Alarm(
    id: const Uuid().v4(),
    scheduledAt: alarmTime,
    sleepStart: sleepStart,
    type: AlarmType.automatic,
    isActive: true,
    snoozeDurationMinutes: snoozeMin,
  );

  // SharedPreferences'a kaydet
  final raw = prefs.getString(AppConstants.prefAlarms);
  List<dynamic> list = [];
  if (raw != null && raw.isNotEmpty) {
    try {
      list = json.decode(raw) as List<dynamic>;
    } catch (_) {}
  }
  list.add(AlarmModel.fromEntity(alarm).toJson());
  await prefs.setString(AppConstants.prefAlarms, json.encode(list));

  debugPrint('[BgService] ✅ Alarm kaydedildi: ${alarm.id} → $alarmTime');
}

/// Zamanı gelmemiş otomatik alarmları siler.
Future<void> _cancelPendingAutoAlarms(SharedPreferences prefs) async {
  final raw = prefs.getString(AppConstants.prefAlarms);
  if (raw == null || raw.isEmpty) return;

  List<dynamic> list;
  try {
    list = json.decode(raw) as List<dynamic>;
  } catch (_) {
    return;
  }

  final now = DateTime.now();
  final kept = <dynamic>[];
  int removed = 0;

  for (final item in list) {
    if (item is Map<String, dynamic> && item['type'] == 'automatic') {
      final atStr = item['scheduledAt'] as String?;
      final at = atStr != null ? DateTime.tryParse(atStr) : null;
      // Zamanı gelmiş olanları tut, gelmemişleri sil
      if (at != null && at.isAfter(now)) {
        removed++;
        continue;
      }
    }
    kept.add(item);
  }

  if (removed > 0) {
    await prefs.setString(AppConstants.prefAlarms, json.encode(kept));
    debugPrint('[BgService] 🗑️ $removed bekleyen alarm iptal edildi');
  }
}

// ══════════════════════════════════════════════════════════════
// FOREGROUND BİLDİRİM
// ══════════════════════════════════════════════════════════════

void _updateFg(FlutterLocalNotificationsPlugin notif, String text) {
  notif.show(
    id: _bgNotifId,
    title: AppConstants.appName,
    body: text,
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        _bgChannelId,
        _bgChannelName,
        icon: '@mipmap/ic_launcher',
        ongoing: true,
        playSound: false,
        enableVibration: false,
        importance: Importance.low,
        priority: Priority.low,
      ),
    ),
  );
}

// ══════════════════════════════════════════════════════════════
// DURUM MODELİ
// ══════════════════════════════════════════════════════════════

class BackgroundServiceStatus {
  final bool isMonitoring;
  final bool sleepDetected;
  final bool isScreenOff;
  final bool isCountingDown;
  final bool screenModeDetection;
  final bool autoDetection;
  final int remainingSeconds;
  final bool alarmFiring;
  final bool outsideTimeRange;

  const BackgroundServiceStatus({
    required this.isMonitoring,
    required this.sleepDetected,
    required this.isScreenOff,
    required this.isCountingDown,
    required this.screenModeDetection,
    required this.autoDetection,
    required this.remainingSeconds,
    this.alarmFiring = false,
    this.outsideTimeRange = false,
  });
}
