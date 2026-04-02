import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart' show S;
import '../../domain/entities/sleep_advice.dart';

/// Tek bir AI tavsiyesini gösteren kart.
class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key, required this.advice});

  final SleepAdvice advice;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);
    final color = _priorityColor(advice.priority);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori ikonu
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _categoryIcon(advice.category),
                color: color,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            // İçerik
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _title(t, advice),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Öncelik etiketi
                      if (advice.priority == AdvicePriority.high)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            t.advicePriorityHigh,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _desc(t, advice),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _categoryLabel(t, advice.category),
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _priorityColor(AdvicePriority p) {
    switch (p) {
      case AdvicePriority.high:
        return Colors.red;
      case AdvicePriority.medium:
        return Colors.orange;
      case AdvicePriority.low:
        return Colors.green;
    }
  }

  IconData _categoryIcon(AdviceCategory c) {
    switch (c) {
      case AdviceCategory.duration:
        return Icons.access_time;
      case AdviceCategory.quality:
        return Icons.bed;
      case AdviceCategory.consistency:
        return Icons.calendar_today;
      case AdviceCategory.habit:
        return Icons.nightlight;
      case AdviceCategory.achievement:
        return Icons.emoji_events;
    }
  }

  String _categoryLabel(S t, AdviceCategory c) {
    switch (c) {
      case AdviceCategory.duration:
        return t.adviceCategoryDuration;
      case AdviceCategory.quality:
        return t.adviceCategoryQuality;
      case AdviceCategory.consistency:
        return t.adviceCategoryConsistency;
      case AdviceCategory.habit:
        return t.adviceCategoryHabit;
      case AdviceCategory.achievement:
        return t.adviceCategoryAchievement;
    }
  }

  String _title(S t, SleepAdvice a) {
    switch (a.type) {
      case AdviceType.bedtimeTooLate:
        return t.adviceBedtimeTooLateTitle;
      case AdviceType.bedtimeTooEarly:
        return t.adviceBedtimeTooEarlyTitle;
      case AdviceType.sleepDurationShort:
        return t.adviceSleepDurationShortTitle;
      case AdviceType.sleepDurationLong:
        return t.adviceSleepDurationLongTitle;
      case AdviceType.reduceSnoozeDependency:
        return t.adviceReduceSnoozeTitle;
      case AdviceType.reduceNightWakeups:
        return t.adviceReduceWakeupsTitle;
      case AdviceType.improveSleepEfficiency:
        return t.adviceImproveEfficiencyTitle;
      case AdviceType.inconsistentBedtime:
        return t.adviceInconsistentBedtimeTitle;
      case AdviceType.socialJetLagWarning:
        return t.adviceSocialJetLagTitle;
      case AdviceType.sleepDebtBuilding:
        return t.adviceSleepDebtTitle;
      case AdviceType.greatStreak:
        return t.adviceGreatStreakTitle;
      case AdviceType.goalAchieved:
        return t.adviceGoalAchievedTitle;
      case AdviceType.personalBest:
        return t.advicePersonalBestTitle;
      case AdviceType.improvingTrend:
        return t.adviceImprovingTrendTitle;
    }
  }

  String _desc(S t, SleepAdvice a) {
    final p = a.params;
    switch (a.type) {
      case AdviceType.bedtimeTooLate:
        return t.adviceBedtimeTooLateDesc(
          p['diffMinutes'] as int? ?? 0,
          p['targetBedtime'] as String? ?? '--:--',
        );
      case AdviceType.bedtimeTooEarly:
        return t.adviceBedtimeTooEarlyDesc(
          p['avgBedtime'] as String? ?? '--:--',
          p['targetBedtime'] as String? ?? '--:--',
        );
      case AdviceType.sleepDurationShort:
        return t.adviceSleepDurationShortDesc(
            p['shortfallMinutes'] as int? ?? 0);
      case AdviceType.sleepDurationLong:
        return t.adviceSleepDurationLongDesc(
            p['excessMinutes'] as int? ?? 0);
      case AdviceType.reduceSnoozeDependency:
        return t.adviceReduceSnoozeDesc(p['avgSnooze'] as String? ?? '0');
      case AdviceType.reduceNightWakeups:
        return t.adviceReduceWakeupsDesc(
            p['avgWakeCount'] as String? ?? '0');
      case AdviceType.improveSleepEfficiency:
        return t.adviceImproveEfficiencyDesc(
            p['avgEfficiency'] as int? ?? 0);
      case AdviceType.inconsistentBedtime:
        return t.adviceInconsistentBedtimeDesc(
            p['varianceMinutes'] as int? ?? 0);
      case AdviceType.socialJetLagWarning:
        return t.adviceSocialJetLagDesc(p['diffMinutes'] as int? ?? 0);
      case AdviceType.sleepDebtBuilding:
        return t.adviceSleepDebtDesc(p['debtHours'] as String? ?? '0');
      case AdviceType.greatStreak:
        return t.adviceGreatStreakDesc(p['streak'] as int? ?? 0);
      case AdviceType.goalAchieved:
        return t.adviceGoalAchievedDesc;
      case AdviceType.personalBest:
        return t.advicePersonalBestDesc;
      case AdviceType.improvingTrend:
        return t.adviceImprovingTrendDesc(
          p['oldAvg'] as int? ?? 0,
          p['newAvg'] as int? ?? 0,
        );
    }
  }
}
