import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/alarm.dart';

/// Sonraki alarm bilgisini gösteren büyük kart.
class NextAlarmCard extends StatelessWidget {
  final Alarm? alarm;

  const NextAlarmCard({super.key, this.alarm});

  @override
  Widget build(BuildContext context) {
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
        color: alarm == null ? AppColors.cardDark : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: alarm != null ? _buildActiveAlarm() : _buildNoAlarm(),
    );
  }

  Widget _buildActiveAlarm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.alarm, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            const Text(
              AppStrings.nextAlarm,
              style: TextStyle(color: Colors.white70, fontSize: 14),
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
                    ? AppStrings.automatic
                    : AppStrings.manual,
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
              '${DateTimeUtils.timeUntil(alarm!.scheduledAt)} sonra',
              style: const TextStyle(color: Colors.white60, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoAlarm() {
    return const Column(
      children: [
        Icon(Icons.nights_stay_outlined, color: AppColors.textHint, size: 48),
        SizedBox(height: 12),
        Text(
          AppStrings.noAlarm,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          'İyi uykular 🌙',
          style: TextStyle(color: AppColors.textHint, fontSize: 13),
        ),
      ],
    );
  }
}
