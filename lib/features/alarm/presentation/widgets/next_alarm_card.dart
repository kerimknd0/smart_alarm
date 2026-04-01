import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/alarm.dart';

/// Sonraki alarm bilgisini gösteren büyük kart.
class NextAlarmCard extends StatelessWidget {
  final Alarm? alarm;

  const NextAlarmCard({super.key, this.alarm});

  @override
  Widget build(BuildContext context) {
    final c = AppColorsExtension.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: alarm != null
            ? const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: alarm == null ? c.card : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: alarm != null ? _buildActiveAlarm(context) : _buildNoAlarm(context),
    );
  }

  Widget _buildActiveAlarm(BuildContext context) {
    final t = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.alarm, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Text(
              t.nextAlarm,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                alarm!.type == AlarmType.automatic
                    ? t.automatic
                    : t.manual,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          DateTimeUtils.formatTime(alarm!.scheduledAt),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 56,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateTimeUtils.formatDate(alarm!.scheduledAt),
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.timelapse, color: Colors.white60, size: 16),
            const SizedBox(width: 6),
            Text(
              t.inTime(DateTimeUtils.timeUntil(
                alarm!.scheduledAt,
                pastLabel: t.past,
                hourLabel: t.hours,
                minuteLabel: t.minutes,
              )),
              style: const TextStyle(color: Colors.white60, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoAlarm(BuildContext context) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    return Column(
      children: [
        Icon(Icons.nights_stay_outlined, color: c.textHint, size: 48),
        const SizedBox(height: 12),
        Text(
          t.noAlarm,
          style: TextStyle(color: c.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          t.sweetDreams,
          style: TextStyle(color: c.textHint, fontSize: 13),
        ),
      ],
    );
  }
}
