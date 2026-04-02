import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart' show S;
import '../../domain/services/sleep_debt_calculator.dart';

/// Uyku borç göstergesi — yatay bir progress bar.
class SleepDebtMeter extends StatelessWidget {
  const SleepDebtMeter({
    super.key,
    required this.result,
  });

  final SleepDebtResult result;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);
    final maxDebt = 480.0; // 8 saat = kritik üst sınır
    final debtRatio = (result.totalDebtMinutes / maxDebt).clamp(0.0, 1.0);
    final color = _debtColor(result.debtLevel);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.battery_alert, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  t.sleepDebtTitle,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  result.hasDebt
                      ? t.sleepDebtValue(
                          result.totalDebtHours.toStringAsFixed(1))
                      : t.noDebt,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: debtRatio,
                minHeight: 10,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            if (result.hasDebt && result.projectedRecoveryDays > 0) ...[
              const SizedBox(height: 6),
              Text(
                t.debtRecovery(result.projectedRecoveryDays),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _debtColor(int level) {
    switch (level) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.lightGreen;
      case 2:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
