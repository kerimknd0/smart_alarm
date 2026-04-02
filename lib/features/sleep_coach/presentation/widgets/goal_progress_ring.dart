import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../l10n/app_localizations.dart' show S;
import '../../domain/entities/sleep_goal.dart';

/// Çember grafik — hedefe ne kadar ulaşıldığını gösterir.
class GoalProgressRing extends StatelessWidget {
  const GoalProgressRing({
    super.key,
    required this.progress,
  });

  final GoalProgress progress;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);
    final rate = progress.completionRate.clamp(0.0, 1.0);
    final color = _ringColor(rate);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              t.goalProgress,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Çember
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    painter: _RingPainter(
                      progress: rate,
                      color: color,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(rate * 100).round()}%',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          Text(
                            t.completionRateLabel((rate * 100).round()),
                            style: theme.textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // İstatistikler
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _statRow(
                      context,
                      Icons.check_circle_outline,
                      t.daysAchievedLabel(
                        progress.daysAchieved,
                        progress.totalDays,
                      ),
                      Colors.green,
                    ),
                    const SizedBox(height: 8),
                    _statRow(
                      context,
                      Icons.local_fire_department,
                      t.currentStreakLabel(progress.currentStreak),
                      Colors.orange,
                    ),
                    const SizedBox(height: 8),
                    _statRow(
                      context,
                      Icons.star_outline,
                      t.avgScore,
                      theme.colorScheme.primary,
                      subtitle:
                          progress.avgScoreThisWeek.toStringAsFixed(0),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(
    BuildContext context,
    IconData icon,
    String label,
    Color color, {
    String? subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        subtitle != null
            ? RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(text: label),
                    const TextSpan(text: ': '),
                    TextSpan(
                      text: subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              )
            : Text(label,
                style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Color _ringColor(double rate) {
    if (rate >= 0.8) return Colors.green;
    if (rate >= 0.5) return Colors.orange;
    return Colors.red;
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  final double progress;
  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    // Arka plan
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // İlerleme
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}
