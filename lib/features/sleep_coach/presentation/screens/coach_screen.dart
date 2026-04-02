import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/app_localizations.dart' show S;
import '../../domain/services/sleep_debt_calculator.dart';
import '../bloc/coach_bloc.dart';
import '../bloc/coach_event.dart';
import '../bloc/coach_state.dart';
import '../widgets/advice_card.dart';
import '../widgets/goal_progress_ring.dart';
import '../widgets/sleep_debt_meter.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CoachBloc>()..add(const LoadCoachDashboard()),
      child: const _CoachView(),
    );
  }
}

class _CoachView extends StatelessWidget {
  const _CoachView();

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.coachTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<CoachBloc>().add(const RefreshCoach()),
          ),
        ],
      ),
      body: BlocBuilder<CoachBloc, CoachState>(
        builder: (context, state) {
          if (state is CoachLoading || state is CoachInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CoachError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<CoachBloc>()
                        .add(const LoadCoachDashboard()),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }
          if (state is CoachLoaded) {
            return _CoachContent(state: state);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/coach/goal'),
        icon: const Icon(Icons.flag),
        label: Text(t.setGoal),
      ),
    );
  }
}

class _CoachContent extends StatelessWidget {
  const _CoachContent({required this.state});

  final CoachLoaded state;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<CoachBloc>().add(const RefreshCoach()),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Başlık
          Text(
            t.coachSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),

          // Hedefe ulaşma halkası
          GoalProgressRing(progress: state.progress),
          const SizedBox(height: 12),

          // Uyku borcu
          SleepDebtMeter(
            result: SleepDebtResult(
              totalDebtMinutes: state.progress.sleepDebtMinutes,
              debtByDay: const [],
              projectedRecoveryDays: state.progress.sleepDebtMinutes > 0
                  ? (state.progress.sleepDebtMinutes / 90).ceil()
                  : 0,
              averageDeficitPerNight: 0,
            ),
          ),          const SizedBox(height: 16),

          // Hedef özet kartı
          _GoalSummaryCard(goal: state.goal),
          const SizedBox(height: 16),

          // Tavsiyeler
          Text(
            t.advicesTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (state.advices.isEmpty)
            _EmptyAdvices()
          else
            ...state.advices.map((a) => AdviceCard(advice: a)),

          const SizedBox(height: 80), // FAB alanı
        ],
      ),
    );
  }
}

class _GoalSummaryCard extends StatelessWidget {
  const _GoalSummaryCard({required this.goal});

  final dynamic goal;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, size: 18),
                const SizedBox(width: 6),
                Text(
                  t.yourGoal,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20),
            _goalRow(
              context,
              t.targetDuration,
              '${(goal.targetDurationMinutes / 60).toStringAsFixed(1)}h',
              Icons.access_time,
            ),
            _goalRow(
              context,
              t.targetBedtime,
              goal.bedtimeLabel ?? t.notSet,
              Icons.nightlight,
            ),
            _goalRow(
              context,
              t.targetWakeTime,
              goal.wakeTimeLabel ?? t.notSet,
              Icons.wb_sunny_outlined,
            ),
            _goalRow(
              context,
              t.targetScore,
              '${goal.targetScore}',
              Icons.star_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _goalRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(label, style: theme.textTheme.bodyMedium),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _EmptyAdvices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 56, color: Colors.green),
            const SizedBox(height: 12),
            Text(t.noAdvices,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              t.noAdvicesHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
