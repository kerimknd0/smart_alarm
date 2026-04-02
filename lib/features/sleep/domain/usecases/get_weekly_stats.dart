import '../entities/sleep_analysis.dart';
import '../repositories/sleep_repository.dart';

class GetWeeklyStats {
  final SleepRepository repository;
  const GetWeeklyStats(this.repository);

  /// [weekStart] = haftanın başladığı Pazartesi günü (00:00).
  Future<WeeklySleepStats?> call(DateTime weekStart) =>
      repository.getWeeklyStats(weekStart);
}
