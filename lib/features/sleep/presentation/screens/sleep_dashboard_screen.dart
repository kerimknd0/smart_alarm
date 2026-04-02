import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/sleep_record.dart';
import '../bloc/sleep_bloc.dart';
import '../bloc/sleep_event.dart';
import '../bloc/sleep_state.dart';
import '../widgets/anomaly_alert_card.dart';
import '../widgets/sleep_score_ring.dart';
import '../widgets/weekly_bar_chart.dart';
import 'sleep_detail_screen.dart';

/// Uyku Analizi ana ekranı.
class SleepDashboardScreen extends StatelessWidget {
  const SleepDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.sleepAnalysis),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<SleepBloc>().add(const LoadSleepDashboard()),
          ),
        ],
      ),
      body: BlocBuilder<SleepBloc, SleepState>(
        builder: (context, state) {
          if (state is SleepInitial) {
            context.read<SleepBloc>().add(const LoadSleepDashboard());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SleepLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SleepError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<SleepBloc>()
                        .add(const LoadSleepDashboard()),
                    child: Text(t.retryButton),
                  ),
                ],
              ),
            );
          }
          if (state is SleepDashboardLoaded) {
            return _buildContent(context, state, c);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    SleepDashboardLoaded state,
    AppColorsExtension c,
  ) {
    final t = S.of(context);
    final last = state.lastRecord;

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<SleepBloc>().add(const LoadSleepDashboard()),
      child: CustomScrollView(
        slivers: [
          // ── Dün Gecenin Özeti ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: last != null
                  ? _buildLastNightCard(context, last, c)
                  : _buildNoDataCard(context, c),
            ),
          ),

          // ── Haftalık Bar Chart ────────────────────────────────────────────
          if (state.recentRecords.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  t.thisWeek,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: c.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WeeklyBarChart(records: state.recentRecords),
                      const SizedBox(height: 12),
                      _weeklyStatRow(context, state.recentRecords, c),
                    ],
                  ),
                ),
              ),
            ),
          ],

          // ── Anomali Uyarıları ─────────────────────────────────────────────
          if (state.anomalies.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  t.alerts,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AnomalyAlertCard(anomaly: state.anomalies[i]),
                  ),
                  childCount: state.anomalies.length,
                ),
              ),
            ),
          ],

          // ── Geçmiş Butonu ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: geçmiş ekranı (Faz sonraki adım)
                },
                icon: const Icon(Icons.history),
                label: Text(t.viewAllHistory),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildLastNightCard(
    BuildContext context,
    SleepRecord record,
    AppColorsExtension c,
  ) {
    final t = S.of(context);
    final hours = record.totalDurationMinutes ~/ 60;
    final minutes = record.totalDurationMinutes % 60;
    final start = _timeLabel(record.sleepStart);
    final end = _timeLabel(record.sleepEnd);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SleepDetailScreen(record: record),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.bedtime, color: AppColors.primary, size: 18),
                const SizedBox(width: 6),
                Text(
                  t.lastNight,
                  style: TextStyle(color: c.textSecondary, fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '$start → $end',
                  style: TextStyle(color: c.textHint, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SleepScoreRing(score: record.score, size: 140),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _statItem(
                        icon: Icons.access_time,
                        label: t.sleepDurationLabel,
                        value: '${hours}s ${minutes}dk',
                        c: c,
                      ),
                      const SizedBox(height: 12),
                      _statItem(
                        icon: Icons.visibility_off,
                        label: t.wakeCount,
                        value: '${record.wakeCount} ${t.timesUnit}',
                        c: c,
                      ),
                      const SizedBox(height: 12),
                      _statItem(
                        icon: Icons.snooze,
                        label: t.snooze,
                        value: '${record.snoozeCount} ${t.timesUnit}',
                        c: c,
                      ),
                      const SizedBox(height: 12),
                      _statItem(
                        icon: Icons.speed,
                        label: t.efficiency,
                        value: '%${(record.efficiency * 100).round()}',
                        c: c,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  t.viewDetails,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataCard(BuildContext context, AppColorsExtension c) {
    final t = S.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.bedtime_off, size: 56, color: c.textHint),
          const SizedBox(height: 16),
          Text(
            t.noSleepRecordYet,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.noSleepRecordHint,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: c.textHint),
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required String label,
    required String value,
    required AppColorsExtension c,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: c.textHint),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 10, color: c.textHint)),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weeklyStatRow(BuildContext context, List<SleepRecord> records, AppColorsExtension c) {
    final t = S.of(context);
    final avgScore =
        records.map((r) => r.score).reduce((a, b) => a + b) / records.length;
    final avgDur = records
            .map((r) => r.totalDurationMinutes)
            .reduce((a, b) => a + b) ~/
        records.length;
    final h = avgDur ~/ 60;
    final m = avgDur % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _weekStat(t.avgScore, avgScore.round().toString(), c),
        Container(width: 1, height: 30, color: c.textHint.withValues(alpha: 0.3)),
        _weekStat(t.avgDuration, '${h}s ${m}dk', c),
        Container(width: 1, height: 30, color: c.textHint.withValues(alpha: 0.3)),
        _weekStat(t.recordCount, '${records.length} ${t.nightsUnit}', c),
      ],
    );
  }

  Widget _weekStat(String label, String value, AppColorsExtension c) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: c.textPrimary)),
        Text(label, style: TextStyle(fontSize: 11, color: c.textHint)),
      ],
    );
  }

  String _timeLabel(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
