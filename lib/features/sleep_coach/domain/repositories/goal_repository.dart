import '../entities/sleep_goal.dart';

abstract class GoalRepository {
  Future<SleepGoal> getGoal();
  Future<void> saveGoal(SleepGoal goal);
  Future<void> clearGoal();
}
