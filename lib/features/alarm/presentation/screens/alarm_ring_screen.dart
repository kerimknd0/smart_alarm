import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/background_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart' show isAlarmRingOpen;
import '../../domain/entities/alarm.dart';
import '../bloc/alarm_bloc.dart';
import '../bloc/alarm_event.dart';

/// Alarm çaldığında gösterilen tam ekran.
class AlarmRingScreen extends StatefulWidget {
  final Alarm alarm;

  const AlarmRingScreen({super.key, required this.alarm});

  @override
  State<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends State<AlarmRingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();

    // Ekranı açık tut
    WakelockPlus.enable();

    // Nabız animasyonu
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Saat güncelle
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateTimeUtils.formatTime(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    isAlarmRingOpen = false;
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final sleepDuration = widget.alarm.sleepStart != null
        ? DateTime.now().difference(widget.alarm.sleepStart!)
        : null;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Günaydın mesajı
              Text(
                t.goodMorning,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Animasyonlu saat
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: child,
                  );
                },
                child: Text(
                  _currentTime,
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: 4,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Uyku süresi
              if (sleepDuration != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bedtime,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        t.youSleptDuration(DateTimeUtils.formatDuration(
                          sleepDuration,
                          hourLabel: t.hours,
                          minuteLabel: t.minutes,
                        )),
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Tarih
              Text(
                DateTimeUtils.formatDate(DateTime.now()),
                style: const TextStyle(color: AppColors.textHint, fontSize: 14),
              ),

              const Spacer(flex: 3),

              // Kapat butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _dismissAlarm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    t.dismiss,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ertele butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => _snoozeAlarm(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.snoozeColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    t.snoozeWithDuration(widget.alarm.snoozeDurationMinutes),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.snoozeColor,
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _dismissAlarm(BuildContext context) {
    stopFiringAlarm(); // SharedPrefs temizle → AlarmSoundService sesi durdurur
    context.read<AlarmBloc>().add(DismissAlarmEvent(widget.alarm.id));
    Navigator.of(context).pop();
  }

  void _snoozeAlarm(BuildContext context) {
    stopFiringAlarm(); // SharedPrefs temizle → AlarmSoundService sesi durdurur
    context.read<AlarmBloc>().add(SnoozeAlarmEvent(widget.alarm));
    Navigator.of(context).pop();
  }
}
