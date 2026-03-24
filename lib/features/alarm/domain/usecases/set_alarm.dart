import '../entities/alarm.dart';
import '../repositories/alarm_repository.dart';

/// Yeni alarm kuran veya var olanı güncelleyen use case.
class SetAlarm {
  final AlarmRepository repository;

  SetAlarm(this.repository);

  Future<void> call(Alarm alarm) async {
    await repository.saveAlarm(alarm);
  }
}
