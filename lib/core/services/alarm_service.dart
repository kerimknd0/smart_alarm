import 'package:uuid/uuid.dart';

import '../../features/alarm/domain/entities/alarm.dart';
import 'notification_service.dart';

/// Alarm kurma/iptal işlemlerini NotificationService ile köprüleyen servis.
class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  final NotificationService _notificationService = NotificationService();
  final Uuid _uuid = const Uuid();

  /// Alarm'ın bildirim ID'sini hashCode ile üretir.
  int _notificationId(String alarmId) => alarmId.hashCode.abs() % 2147483647;

  /// Yeni bir alarm ID'si üretir.
  String generateId() => _uuid.v4();

  /// Alarm bildirimini zamanla.
  Future<void> scheduleAlarm(Alarm alarm) async {
    if (!alarm.isActive || alarm.isPast) return;

    await _notificationService.scheduleAlarm(
      id: _notificationId(alarm.id),
      title: '⏰ Alarm!',
      body: _alarmBody(alarm),
      scheduledAt: alarm.scheduledAt,
      payload: alarm.id,
    );
  }

  /// Alarm bildirimini iptal et.
  Future<void> cancelAlarm(String alarmId) async {
    await _notificationService.cancelNotification(_notificationId(alarmId));
  }

  /// Tüm alarm bildirimlerini iptal et.
  Future<void> cancelAllAlarms() async {
    await _notificationService.cancelAllNotifications();
  }

  /// Snooze: mevcut alarmı ertele.
  Future<Alarm> snoozeAlarm(Alarm alarm) async {
    // Mevcut bildirimi iptal et
    await cancelAlarm(alarm.id);

    // Yeni zamana göre alarm oluştur
    final snoozedAlarm = alarm.copyWith(
      scheduledAt: DateTime.now().add(
        Duration(minutes: alarm.snoozeDurationMinutes),
      ),
    );

    // Yeni bildirimi zamanla
    await scheduleAlarm(snoozedAlarm);
    return snoozedAlarm;
  }

  String _alarmBody(Alarm alarm) {
    if (alarm.type == AlarmType.automatic && alarm.sleepStart != null) {
      final duration = alarm.scheduledAt.difference(alarm.sleepStart!);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      return 'Kalkma zamanı! ${hours}s ${minutes}dk uyudunuz.';
    }
    return 'Alarm zamanı geldi!';
  }
}
