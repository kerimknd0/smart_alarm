import '../entities/sleep_goal.dart';
import '../repositories/goal_repository.dart';

class GetSleepGoal {
  const GetSleepGoal(this._repo);
  final GoalRepository _repo;
  Future<SleepGoal> call() => _repo.getGoal();
}
