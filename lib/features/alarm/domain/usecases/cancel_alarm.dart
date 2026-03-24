import '../repositories/alarm_repository.dart';

/// Alarm iptal eden / silen use case.
class CancelAlarm {
  final AlarmRepository repository;

  CancelAlarm(this.repository);

  Future<void> call(String alarmId) async {
    await repository.deleteAlarm(alarmId);
  }
}
