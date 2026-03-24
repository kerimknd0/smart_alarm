import '../entities/alarm.dart';

/// Alarm repository arayüzü (domain katmanı).
abstract class AlarmRepository {
  /// Tüm alarmları getirir.
  Future<List<Alarm>> getAlarms();

  /// Belirli bir alarmı id ile getirir.
  Future<Alarm?> getAlarmById(String id);

  /// Yeni alarm kaydeder veya günceller.
  Future<void> saveAlarm(Alarm alarm);

  /// Alarmı siler.
  Future<void> deleteAlarm(String id);

  /// Tüm alarmları siler.
  Future<void> deleteAllAlarms();
}
