import '../repositories/alarm_repository.dart';

/// Alarm aktif/pasif durumunu değiştiren use case.
class ToggleAlarm {
  final AlarmRepository repository;

  ToggleAlarm(this.repository);

  Future<void> call(String alarmId) async {
    final alarm = await repository.getAlarmById(alarmId);
    if (alarm != null) {
      final updated = alarm.copyWith(isActive: !alarm.isActive);
      await repository.saveAlarm(updated);
    }
  }
}
