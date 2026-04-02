import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/sleep_goal.dart';
import '../../domain/repositories/goal_repository.dart';

class GoalRepositoryImpl implements GoalRepository {
  GoalRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _keyDuration = 'coach_goal_duration';
  static const _keyBedtime = 'coach_goal_bedtime';
  static const _keyWakeTime = 'coach_goal_wake';
  static const _keyScore = 'coach_goal_score';

  @override
  Future<SleepGoal> getGoal() async {
    final duration = _prefs.getInt(_keyDuration) ?? 450; // 7.5 saat
    final bedtime = _prefs.containsKey(_keyBedtime)
        ? _prefs.getInt(_keyBedtime)
        : null; // 23:00
    final wakeTime = _prefs.containsKey(_keyWakeTime)
        ? _prefs.getInt(_keyWakeTime)
        : null; // 07:00 = 420 dk
    final score = _prefs.getInt(_keyScore) ?? 70;

    return SleepGoal(
      targetDurationMinutes: duration,
      targetBedtimeMinutes: bedtime,
      targetWakeMinutes: wakeTime,
      targetScore: score,
    );
  }

  @override
  Future<void> saveGoal(SleepGoal goal) async {
    await _prefs.setInt(_keyDuration, goal.targetDurationMinutes);
    await _prefs.setInt(_keyScore, goal.targetScore);

    if (goal.targetBedtimeMinutes != null) {
      await _prefs.setInt(_keyBedtime, goal.targetBedtimeMinutes!);
    } else {
      await _prefs.remove(_keyBedtime);
    }

    if (goal.targetWakeMinutes != null) {
      await _prefs.setInt(_keyWakeTime, goal.targetWakeMinutes!);
    } else {
      await _prefs.remove(_keyWakeTime);
    }
  }

  @override
  Future<void> clearGoal() async {
    await _prefs.remove(_keyDuration);
    await _prefs.remove(_keyBedtime);
    await _prefs.remove(_keyWakeTime);
    await _prefs.remove(_keyScore);
  }
}
