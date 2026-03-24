import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import '../constants/app_constants.dart';

/// Bildirim ve alarm yönetim servisi.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Callback: bildirime tıklandığında.
  static void Function(String? payload)? onNotificationTap;

  /// Servisi başlat.
  Future<void> init() async {
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        onNotificationTap?.call(response.payload);
      },
    );

    // Uygulama bildirime tıklanarak başlatıldıysa, payload'ı al
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails != null &&
        launchDetails.didNotificationLaunchApp &&
        launchDetails.notificationResponse != null) {
      // Biraz gecikme ile çağır (navigasyon hazır olsun diye)
      Future.delayed(const Duration(milliseconds: 500), () {
        onNotificationTap
            ?.call(launchDetails.notificationResponse!.payload);
      });
    }

    // Android bildirim kanalı oluştur
    final androidChannel = AndroidNotificationChannel(
      AppConstants.alarmChannelId,
      AppConstants.alarmChannelName,
      description: AppConstants.alarmChannelDescription,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  /// Zamanlanmış alarm bildirimi kur.
  Future<void> scheduleAlarm({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      AppConstants.alarmChannelId,
      AppConstants.alarmChannelName,
      channelDescription: AppConstants.alarmChannelDescription,
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
      visibility: NotificationVisibility.public,
      autoCancel: false,
      ongoing: true,
      playSound: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000, 500, 1000]),
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledAt, tz.local),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  /// Belirli bir bildirimi iptal et.
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  /// Tüm bildirimleri iptal et.
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  /// Hemen bildirim göster (test amaçlı).
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.alarmChannelId,
      AppConstants.alarmChannelName,
      channelDescription: AppConstants.alarmChannelDescription,
      importance: Importance.max,
      priority: Priority.max,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }
}
