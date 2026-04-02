import '../entities/sleep_goal.dart';
import '../repositories/goal_repository.dart';
import '../../../sleep/domain/repositories/sleep_repository.dart';

class GetGoalProgress {
  const GetGoalProgress(this._sleepRepo, this._goalRepo);

  final SleepRepository _sleepRepo;
  final GoalRepository _goalRepo;

  Future<GoalProgress> call() async {
    final goal = await _goalRepo.getGoal();
    final records = await _sleepRepo.getSleepHistory(limit: 14);

    if (records.isEmpty) {
      return GoalProgress(
        goal: goal,
        daysAchieved: 0,
        totalDays: 0,
        currentStreak: 0,
        sleepDebtMinutes: 0,
        avgScoreThisWeek: 0,
      );
    }

    final recent7 = records.take(7).toList();

    // Kaç gece hedefe ulaşıldı
    int daysAchieved = 0;
    for (final r in recent7) {
      if (r.totalDurationMinutes >= goal.targetDurationMinutes - 20 &&
          r.score >= goal.targetScore) {
        daysAchieved++;
      }
    }

    // Mevcut seri
    int streak = 0;
    for (final r in records) {
      if (r.totalDurationMinutes >= goal.targetDurationMinutes - 20 &&
          r.score >= goal.targetScore) {
        streak++;
      } else {
        break;
      }
    }

    // Uyku borcu (son 7 gün, yalnızca eksikler)
    int debtMinutes = 0;
    for (final r in recent7) {
      final diff = goal.targetDurationMinutes - r.totalDurationMinutes;
      if (diff > 0) debtMinutes += diff;
    }

    // Bu haftaki ortalama skor
    final avgScore = recent7.isEmpty
        ? 0.0
        : recent7.map((r) => r.score).reduce((a, b) => a + b) /
            recent7.length;

    return GoalProgress(
      goal: goal,
      daysAchieved: daysAchieved,
      totalDays: recent7.length,
      currentStreak: streak,
      sleepDebtMinutes: debtMinutes,
      avgScoreThisWeek: avgScore.toDouble(),
    );
  }
}
