import '../entities/sleep_goal.dart';
import '../repositories/goal_repository.dart';

class SaveSleepGoal {
  const SaveSleepGoal(this._repo);
  final GoalRepository _repo;
  Future<void> call(SleepGoal goal) => _repo.saveGoal(goal);
}
