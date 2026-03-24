import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../features/alarm/domain/entities/alarm.dart';
import '../../features/alarm/domain/repositories/alarm_repository.dart';
import '../../features/settings/data/repositories/settings_repository.dart';
import 'alarm_service.dart';

/// Kullanıcı hareketsizliğini algılayıp otomatik alarm kuran servis.
///
/// Çalışma mantığı:
/// 1. Kullanıcı etkileşimleri (dokunma, app lifecycle) izlenir
/// 2. Her etkileşimde hareketsizlik sayacı sıfırlanır
/// 3. Bekleme süresi dolduğunda "uyku başladı" kararı verilir
/// 4. Ayarlardaki uyku süresi kadar sonraya otomatik alarm kurulur
class UsageDetectionService with WidgetsBindingObserver {
  final SettingsRepository _settingsRepository;
  final AlarmRepository _alarmRepository;
  final AlarmService _alarmService;

  Timer? _inactivityTimer;
  DateTime? _lastInteractionTime;
  bool _isMonitoring = false;
  bool _sleepDetected = false;
  String? _currentAutoAlarmId;

  /// Uyku algılandığında tetiklenen callback.
  void Function(Alarm alarm)? onSleepDetected;

  /// İzleme durumu değiştiğinde tetiklenen callback.
  void Function(bool isMonitoring)? onMonitoringChanged;

  UsageDetectionService({
    required SettingsRepository settingsRepository,
    required AlarmRepository alarmRepository,
    required AlarmService alarmService,
  }) : _settingsRepository = settingsRepository,
       _alarmRepository = alarmRepository,
       _alarmService = alarmService;

  /// İzleme aktif mi?
  bool get isMonitoring => _isMonitoring;

  /// Uyku algılandı mı?
  bool get isSleepDetected => _sleepDetected;

  /// Son etkileşim zamanı.
  DateTime? get lastInteractionTime => _lastInteractionTime;

  /// Hareketsizlik sayacında kalan süre (saniye).
  int get remainingInactivitySeconds {
    if (_lastInteractionTime == null || !_isMonitoring) return 0;
    final waitSeconds = _settingsRepository.getWaitSeconds();
    final elapsed = DateTime.now().difference(_lastInteractionTime!).inSeconds;
    final remaining = waitSeconds - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  // ─── Başlat / Durdur ──────────────────────────────────────

  /// Kullanım algılamayı başlat.
  void startMonitoring() {
    if (_isMonitoring) return;
    if (!_settingsRepository.getAutoDetection()) return;

    _isMonitoring = true;
    _sleepDetected = false;
    _lastInteractionTime = DateTime.now();

    // App lifecycle olaylarını dinle
    WidgetsBinding.instance.addObserver(this);

    // Hareketsizlik sayacını başlat
    _startInactivityTimer();

    onMonitoringChanged?.call(true);
    debugPrint('[UsageDetection] İzleme başladı');
  }

  /// Kullanım algılamayı durdur.
  void stopMonitoring() {
    if (!_isMonitoring) return;

    _isMonitoring = false;
    _sleepDetected = false;
    _inactivityTimer?.cancel();
    _inactivityTimer = null;

    WidgetsBinding.instance.removeObserver(this);

    onMonitoringChanged?.call(false);
    debugPrint('[UsageDetection] İzleme durdu');
  }

  /// Servisi temizle (dispose).
  void dispose() {
    stopMonitoring();
  }

  // ─── Kullanıcı Etkileşimi ─────────────────────────────────

  /// Kullanıcı etkileşimi algılandığında çağrılır.
  /// HomeScreen'den dokunma olaylarını buraya ileteceksiniz.
  void registerUserInteraction() {
    if (!_isMonitoring) return;

    _lastInteractionTime = DateTime.now();

    // Eğer uyku algılanmışsa ve kullanıcı geri döndüyse
    if (_sleepDetected) {
      debugPrint('[UsageDetection] Kullanıcı geri döndü, uyku iptal');
      _sleepDetected = false;
      // Otomatik alarmı iptal et (opsiyonel — kullanıcı isterse bırakılabilir)
    }

    // Sayacı yeniden başlat
    _startInactivityTimer();
  }

  // ─── App Lifecycle ─────────────────────────────────────────

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Uygulama öne geldi → kullanıcı aktif
        registerUserInteraction();
        debugPrint('[UsageDetection] App resumed — sayaç sıfırlandı');
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // Uygulama arka plana gitti → sayaç devam etsin
        debugPrint('[UsageDetection] App paused/inactive — sayaç devam ediyor');
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  // ─── Timer Mantığı ─────────────────────────────────────────

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();

    final waitSeconds = _settingsRepository.getWaitSeconds();

    debugPrint(
      '[UsageDetection] Hareketsizlik sayacı başladı: $waitSeconds saniye',
    );

    _inactivityTimer = Timer(Duration(seconds: waitSeconds), () {
      _onInactivityThresholdReached();
    });
  }

  Future<void> _onInactivityThresholdReached() async {
    if (!_isMonitoring || _sleepDetected) return;

    _sleepDetected = true;
    final sleepStart = _lastInteractionTime ?? DateTime.now();
    final sleepMinutes = _settingsRepository.getSleepMinutes();

    debugPrint(
      '[UsageDetection] ⏰ Hareketsizlik eşiği aşıldı! '
      'Uyku başlangıcı: $sleepStart, '
      '$sleepMinutes dakika sonraya alarm kuruluyor...',
    );

    // Mevcut otomatik alarm varsa iptal et (aynı geceye birden fazla alarm kurma)
    if (_currentAutoAlarmId != null) {
      await _alarmService.cancelAlarm(_currentAutoAlarmId!);
      await _alarmRepository.deleteAlarm(_currentAutoAlarmId!);
      debugPrint('[UsageDetection] Önceki otomatik alarm iptal edildi');
    }

    // Yeni otomatik alarm oluştur
    final alarmTime = sleepStart.add(Duration(minutes: sleepMinutes));
    final alarmId = _alarmService.generateId();
    final snoozeMinutes = _settingsRepository.getSnoozeMinutes();

    final alarm = Alarm(
      id: alarmId,
      scheduledAt: alarmTime,
      sleepStart: sleepStart,
      type: AlarmType.automatic,
      isActive: true,
      snoozeDurationMinutes: snoozeMinutes,
    );

    // Kaydet ve zamanla
    await _alarmRepository.saveAlarm(alarm);
    await _alarmService.scheduleAlarm(alarm);

    _currentAutoAlarmId = alarmId;

    onSleepDetected?.call(alarm);

    debugPrint(
      '[UsageDetection] ✅ Otomatik alarm kuruldu: $alarmTime '
      '(ID: $alarmId)',
    );
  }
}
