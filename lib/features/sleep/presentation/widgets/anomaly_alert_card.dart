import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/sleep_analysis.dart';

/// Anomali uyarı kartı.
class AnomalyAlertCard extends StatelessWidget {
  final SleepAnomaly anomaly;

  const AnomalyAlertCard({super.key, required this.anomaly});

  @override
  Widget build(BuildContext context) {
    final c = AppColorsExtension.of(context);
    final t = S.of(context);
    final (color, icon) = _style(anomaly.severity);
    final (title, description) = _localizedText(t, anomaly);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: c.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (Color, IconData) _style(AnomalySeverity severity) {
    return switch (severity) {
      AnomalySeverity.critical => (AppColors.error, Icons.warning_rounded),
      AnomalySeverity.warning => (AppColors.snoozeColor, Icons.info_outline),
      AnomalySeverity.positive => (AppColors.success, Icons.star_rounded),
    };
  }

  (String, String) _localizedText(S t, SleepAnomaly a) {
    final p = a.params;
    return switch (a.type) {
      AnomalyType.consecutiveShortSleep => (
          t.anomalyInsufficientSleepTitle,
          t.anomalyInsufficientSleepDesc(p['count'] as int? ?? 0),
        ),
      AnomalyType.scoreDrop => (
          t.anomalyScoreDropTitle,
          t.anomalyScoreDropDesc(
            p['score'] as int? ?? 0,
            p['avg'] as int? ?? 0,
          ),
        ),
      AnomalyType.frequentWaking => (
          t.anomalyFrequentWakingTitle,
          t.anomalyFrequentWakingDesc(p['count'] as int? ?? 0),
        ),
      AnomalyType.socialJetLag => (
          t.anomalySocialJetLagTitle,
          t.anomalySocialJetLagDesc(p['weekend'] as String? ?? ''),
        ),
      AnomalyType.bedtimeShift => (
          t.anomalyBedtimeShiftTitle,
          t.anomalyBedtimeShiftDesc,
        ),
      AnomalyType.excessiveSnooze => (
          t.anomalyExcessiveSnoozeTitle,
          t.anomalyExcessiveSnoozeDesc(p['count'] as int? ?? 0),
        ),
      AnomalyType.streak => (
          t.anomalyStreakTitle,
          t.anomalyStreakDesc,
        ),
      AnomalyType.improvement => (
          t.anomalyImprovementTitle,
          t.anomalyImprovementDesc(
            p['thisWeek'] as int? ?? 0,
            p['lastWeek'] as int? ?? 0,
          ),
        ),
    };
  }
}
