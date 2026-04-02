import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/sleep_record.dart';

/// Son 7 gecenin skorunu bar chart olarak gösterir.
class WeeklyBarChart extends StatelessWidget {
  final List<SleepRecord> records; // yeniden eskiye sıralı

  const WeeklyBarChart({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final c = AppColorsExtension.of(context);
    final t = S.of(context);
    final reversed = records.reversed.toList(); // eskiden yeniye

    return SizedBox(
      height: 140,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          minY: 0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => c.card,
              getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                '${rod.toY.round()}',
                TextStyle(
                  color: _barColor(rod.toY.round()),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= reversed.length) {
                    return const SizedBox.shrink();
                  }
                  final day = reversed[idx].sleepStart;
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _dayLabel(t, day.weekday),
                      style: TextStyle(fontSize: 10, color: c.textHint),
                    ),
                  );
                },
                reservedSize: 22,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (_) => FlLine(
              color: c.textHint.withValues(alpha: 0.15),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(reversed.length, (i) {
            final score = reversed[i].score;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: score.toDouble(),
                  color: _barColor(score),
                  width: 18,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 100,
                    color: _barColor(score).withValues(alpha: 0.08),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Color _barColor(int score) {
    if (score >= 85) return AppColors.success;
    if (score >= 70) return AppColors.primary;
    if (score >= 50) return AppColors.snoozeColor;
    return AppColors.error;
  }

  String _dayLabel(S t, int weekday) {
    return switch (weekday) {
      1 => t.dayMon,
      2 => t.dayTue,
      3 => t.dayWed,
      4 => t.dayThu,
      5 => t.dayFri,
      6 => t.daySat,
      _ => t.daySun,
    };
  }
}
