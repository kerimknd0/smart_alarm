import '../entities/sleep_advice.dart';
import '../repositories/goal_repository.dart';
import '../services/sleep_coach_engine.dart';
import '../../../sleep/domain/repositories/sleep_repository.dart';

class GetCoachAdvice {
  const GetCoachAdvice(this._sleepRepo, this._goalRepo);

  final SleepRepository _sleepRepo;
  final GoalRepository _goalRepo;

  Future<List<SleepAdvice>> call() async {
    final goal = await _goalRepo.getGoal();
    final records = await _sleepRepo.getSleepHistory(limit: 14);
    return SleepCoachEngine.generateAdvice(records: records, goal: goal);
  }
}
