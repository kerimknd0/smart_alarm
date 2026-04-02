import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/sleep_record.dart';
import '../../domain/services/rem_cycle_estimator.dart';
import '../../domain/services/sleep_score_engine.dart';
import '../widgets/sleep_score_ring.dart';

/// Tek bir gece için detaylı analiz ekranı.
class SleepDetailScreen extends StatelessWidget {
  final SleepRecord record;

  const SleepDetailScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final c = AppColorsExtension.of(context);
    final t = S.of(context);
    final remCycles = RemCycleEstimator.estimate(
      sleepStart: record.sleepStart,
      sleepEnd: record.sleepEnd,
    );

    // Skor bileşenlerini yeniden hesapla (göstermek için)
    final scoreDetail = SleepScoreEngine.calculate(
      totalDurationMinutes: record.totalDurationMinutes,
      wakeCount: record.wakeCount,
      sessions: record.sessions,
      sleepStart: record.sleepStart,
      sleepEnd: record.sleepEnd,
      dismissType: record.dismissType,
      snoozeCount: record.snoozeCount,
      recentRecords: const [],
    );

    final hours = record.totalDurationMinutes ~/ 60;
    final minutes = record.totalDurationMinutes % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(_dateLabel(context, record.sleepStart)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Skor kartı ────────────────────────────────────────────────
            _card(
              c: c,
              child: Row(
                children: [
                  SleepScoreRing(score: record.score, size: 120),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                          Icons.access_time,
                          t.sleepDurationLabel,
                          '${hours}s ${minutes}dk',
                          c,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.bedtime,
                          t.detailBedTime,
                          _timeLabel(record.sleepStart),
                          c,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.wb_sunny_outlined,
                          t.detailWakeTime,
                          _timeLabel(record.sleepEnd),
                          c,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.speed,
                          t.efficiency,
                          '%${(record.efficiency * 100).round()}',
                          c,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Skor Detayı ───────────────────────────────────────────────
            _sectionTitle(t.scoreDetail, c),
            const SizedBox(height: 8),
            _card(
              c: c,
              child: Column(
                children: [
                  _scoreBar(t.sleepDurationLabel, scoreDetail.duration, 30, c),
                  _scoreBar(t.scoreMotion, scoreDetail.motion, 25, c),
                  _scoreBar(t.scoreConsistency, scoreDetail.consistency, 20, c),
                  _scoreBar(t.efficiency, scoreDetail.efficiency, 15, c),
                  _scoreBar(t.scoreAlarmResponse, scoreDetail.alarm, 10, c),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── REM Döngüleri ─────────────────────────────────────────────
            _sectionTitle(t.remCycles, c),
            const SizedBox(height: 8),
            _card(
              c: c,
              child: remCycles.isEmpty
                  ? Text(
                      t.noRemData,
                      style: TextStyle(color: c.textHint),
                    )
                  : Column(
                      children: remCycles.map((cycle) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${cycle.cycleNumber}',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_timeLabel(cycle.start)} – ${_timeLabel(cycle.end)}',
                                    style: TextStyle(
                                      color: c.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    t.lightSleepWindow,
                                    style: TextStyle(
                                      color: c.textHint,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 16),

            // ── Gece Uyanmaları ────────────────────────────────────────────
            if (record.wakeCount > 0) ...[
              _sectionTitle(t.nightWakeups, c),
              const SizedBox(height: 8),
              _card(
                c: c,
                child: Column(
                  children: record.sessions
                      .where((s) => s.type == SleepSessionType.screenOn)
                      .map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  size: 16,
                                  color: c.textHint,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _timeLabel(s.timestamp),
                                  style: TextStyle(
                                    color: c.textPrimary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  t.screenTurnedOn,
                                  style: TextStyle(
                                    color: c.textHint,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _card({required AppColorsExtension c, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title, AppColorsExtension c) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: c.textPrimary,
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, AppColorsExtension c) {
    return Row(
      children: [
        Icon(icon, size: 14, color: c.textHint),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: c.textHint, fontSize: 12)),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            color: c.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _scoreBar(
    String label,
    int score,
    int max,
    AppColorsExtension c,
  ) {
    final ratio = score / max;
    final color = ratio >= 0.8
        ? AppColors.success
        : ratio >= 0.6
            ? AppColors.primary
            : ratio >= 0.4
                ? AppColors.snoozeColor
                : AppColors.error;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label,
                    style: TextStyle(fontSize: 12, color: c.textSecondary)),
              ),
              Text(
                '$score / $max',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  String _timeLabel(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _dateLabel(BuildContext context, DateTime dt) {
    final t = S.of(context);
    final months = [
      '', t.monthJan, t.monthFeb, t.monthMar, t.monthApr,
      t.monthMay, t.monthJun, t.monthJul, t.monthAug,
      t.monthSep, t.monthOct, t.monthNov, t.monthDec,
    ];
    return '${dt.day} ${months[dt.month]}';
  }
}
