import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/alarm.dart';

/// Alarm listesindeki tek bir alarm kartı.
class AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const AlarmCard({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    return Dismissible(
      key: Key(alarm.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false; // Silme işlemini dialog üzerinden yönetiyoruz
      },
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: c.card,
                borderRadius: BorderRadius.circular(16),
                border: alarm.isActive
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  // Sol taraf — saat ve bilgi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTimeUtils.formatTime(alarm.scheduledAt),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: alarm.isActive
                                ? c.textPrimary
                                : c.textHint,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            // Alarm türü badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: alarm.type == AlarmType.automatic
                                    ? AppColors.primary.withValues(alpha: 0.2)
                                    : AppColors.snoozeColor.withValues(
                                        alpha: 0.2,
                                      ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                alarm.type == AlarmType.automatic
                                    ? t.automatic
                                    : t.manual,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: alarm.type == AlarmType.automatic
                                      ? AppColors.primary
                                      : AppColors.snoozeColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Tarih
                            Text(
                              DateTimeUtils.formatShortDate(alarm.scheduledAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: alarm.isActive
                                    ? c.textSecondary
                                    : c.textHint,
                              ),
                            ),
                          ],
                        ),
                        if (alarm.isActive && !alarm.isPast) ...[
                          const SizedBox(height: 4),
                          Text(
                            t.inTime(DateTimeUtils.timeUntil(
                              alarm.scheduledAt,
                              pastLabel: t.past,
                              hourLabel: t.hours,
                              minuteLabel: t.minutes,
                            )),
                            style: TextStyle(
                              fontSize: 12,
                              color: c.textHint,
                            ),
                          ),
                        ],
                        if (alarm.isPast) ...[
                          const SizedBox(height: 4),
                          Text(
                            t.past,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Sağ taraf — toggle switch
                  Switch(value: alarm.isActive, onChanged: (_) => onToggle()),
                ],
              ),
            ),

            // Sağ üst köşe — kırmızı çöp kutusu ikonu
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_rounded,
                  size: 20,
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
