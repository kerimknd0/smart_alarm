import '../entities/alarm.dart';
import '../repositories/alarm_repository.dart';

/// Tüm alarmları getiren use case.
class GetAlarms {
  final AlarmRepository repository;

  GetAlarms(this.repository);

  Future<List<Alarm>> call() async {
    final alarms = await repository.getAlarms();
    // Aktif alarmları önce, sonra zamana göre sırala
    alarms.sort((a, b) {
      if (a.isActive != b.isActive) {
        return a.isActive ? -1 : 1;
      }
      return a.scheduledAt.compareTo(b.scheduledAt);
    });
    return alarms;
  }
}
