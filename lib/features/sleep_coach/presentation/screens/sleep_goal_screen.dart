import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../../l10n/app_localizations.dart' show S;
import '../../domain/entities/sleep_goal.dart';
import '../bloc/coach_bloc.dart';
import '../bloc/coach_event.dart';
import '../bloc/coach_state.dart';

class SleepGoalScreen extends StatelessWidget {
  const SleepGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CoachBloc>()..add(const LoadCoachDashboard()),
      child: const _SleepGoalView(),
    );
  }
}

class _SleepGoalView extends StatefulWidget {
  const _SleepGoalView();

  @override
  State<_SleepGoalView> createState() => _SleepGoalViewState();
}

class _SleepGoalViewState extends State<_SleepGoalView> {
  // Dakika cinsinden: 300 (5s) – 600 (10s)
  double _durationMinutes = 450;

  // Yatış saati: gece yarısından itibaren dakika (–120 = 22:00, 60 = 01:00)
  int? _bedtimeMinutes; // null = belirtilmedi

  // Uyanış saati: gece yarısından itibaren dakika (420 = 07:00)
  int? _wakeMinutes;

  double _targetScore = 70;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Mevcut hedefi yükle
    final state = context.read<CoachBloc>().state;
    if (state is CoachLoaded) {
      _durationMinutes = state.goal.targetDurationMinutes.toDouble();
      _bedtimeMinutes = state.goal.targetBedtimeMinutes;
      _wakeMinutes = state.goal.targetWakeMinutes;
      _targetScore = state.goal.targetScore.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);

    return BlocListener<CoachBloc, CoachState>(
      listener: (context, state) {
        if (state is CoachLoaded && _saving) {
          setState(() => _saving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.goalSavedMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(t.sleepGoalTitle)),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── Uyku süresi ──────────────────────────────────────────────
            _sectionTitle(context, t.durationSliderLabel,
                Icons.access_time),
            const SizedBox(height: 8),
            Text(
              _formatDuration(_durationMinutes.round()),
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Slider(
              min: 300,
              max: 600,
              divisions: 30, // 10'ar dakika
              value: _durationMinutes,
              label: _formatDuration(_durationMinutes.round()),
              onChanged: (v) => setState(() => _durationMinutes = v),
            ),
            const SizedBox(height: 20),

            // ── Yatış saati ───────────────────────────────────────────────
            _sectionTitle(context, t.bedtimePickerLabel, Icons.nightlight),
            const SizedBox(height: 8),
            _TimePickerTile(
              label: _bedtimeMinutes != null
                  ? _minutesToLabel(_bedtimeMinutes!)
                  : t.notSet,
              onTap: () => _pickTime(
                context,
                initial: _bedtimeMinutes,
                onPicked: (m) => setState(() => _bedtimeMinutes = m),
                onClear: () => setState(() => _bedtimeMinutes = null),
              ),
            ),
            const SizedBox(height: 16),

            // ── Uyanış saati ─────────────────────────────────────────────
            _sectionTitle(context, t.wakeTimePickerLabel,
                Icons.wb_sunny_outlined),
            const SizedBox(height: 8),
            _TimePickerTile(
              label: _wakeMinutes != null
                  ? _minutesToLabel(_wakeMinutes!)
                  : t.notSet,
              onTap: () => _pickTime(
                context,
                initial: _wakeMinutes,
                onPicked: (m) => setState(() => _wakeMinutes = m),
                onClear: () => setState(() => _wakeMinutes = null),
              ),
            ),
            const SizedBox(height: 20),

            // ── Hedef skor ───────────────────────────────────────────────
            _sectionTitle(
                context, t.scoreSliderLabel, Icons.star_outline),
            const SizedBox(height: 8),
            Text(
              _targetScore.round().toString(),
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Slider(
              min: 40,
              max: 100,
              divisions: 12,
              value: _targetScore,
              label: _targetScore.round().toString(),
              onChanged: (v) => setState(() => _targetScore = v),
            ),
            const SizedBox(height: 32),

            // ── Kaydet butonu ────────────────────────────────────────────
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save),
              label: Text(t.saveGoalButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _save() {
    setState(() => _saving = true);
    final goal = SleepGoal(
      targetDurationMinutes: _durationMinutes.round(),
      targetBedtimeMinutes: _bedtimeMinutes,
      targetWakeMinutes: _wakeMinutes,
      targetScore: _targetScore.round(),
    );
    context.read<CoachBloc>().add(SaveGoalEvent(goal));
  }

  Future<void> _pickTime(
    BuildContext context, {
    required int? initial,
    required void Function(int minutes) onPicked,
    required VoidCallback onClear,
  }) async {
    final initHour = initial != null
        ? (((initial % 1440) + 1440) % 1440) ~/ 60
        : 22;
    final initMin = initial != null
        ? (((initial % 1440) + 1440) % 1440) % 60
        : 0;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initHour, minute: initMin),
    );
    if (picked == null) return;

    // Normalize: saat 20-23 → gece yarısından önce dakika negatif
    // Kullanıcı dostu: 22:30 → 22*60+30 = 1350, ama gece yarısından geçerlerse 0-7 arası
    final minutes = picked.hour * 60 + picked.minute;
    onPicked(minutes);
  }

  String _formatDuration(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}s' : '${h}s ${m}dk';
  }

  String _minutesToLabel(int minutes) {
    final normalized = ((minutes % 1440) + 1440) % 1440;
    final h = normalized ~/ 60;
    final m = normalized % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }
}

class _TimePickerTile extends StatelessWidget {
  const _TimePickerTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(label, style: theme.textTheme.bodyLarge),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
