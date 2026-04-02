import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/background_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart' show isAlarmRingOpen;
import '../../../alarm/data/models/alarm_model.dart';
import '../bloc/alarm_bloc.dart';
import '../bloc/alarm_event.dart';
import '../bloc/alarm_state.dart';
import '../widgets/alarm_card.dart';
import '../widgets/next_alarm_card.dart';

/// Ana ekran — alarm listesi ve sonraki alarm bilgisi.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Timer? _countdownTimer;
  BackgroundServiceStatus _status = const BackgroundServiceStatus(
    isMonitoring: false,
    sleepDetected: false,
    isScreenOff: false,
    isCountingDown: false,
    screenModeDetection: true,
    autoDetection: true,
    remainingSeconds: 0,
    outsideTimeRange: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AlarmBloc>().add(LoadAlarms());

    // Durum güncelleme döngüsünü başlat
    _startStatusPolling();
  }
  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App öne geldi — alarm çalıyor olabilir, kontrol et
      _refreshStatus().then((_) {
        if (_status.alarmFiring && !isAlarmRingOpen) {
          _navigateToAlarmRing();
        } else if (!_status.alarmFiring) {
          notifyScreenOn();
          notifyUserInteraction();
        }
      });
      context.read<AlarmBloc>().add(LoadAlarms());
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // App arka plana gitti → mod'a göre farklı davran
      notifyAppBackgrounded();
    }
  }

  void _startStatusPolling() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (mounted) {
        final newStatus = await getBackgroundServiceStatus();
        final oldSleepDetected = _status.sleepDetected;
        final oldAlarmFiring = _status.alarmFiring;
        setState(() {
          _status = newStatus;
        });

        // Alarm çalıyorsa alarm-ring ekranına yönlendir
        if (newStatus.alarmFiring && !oldAlarmFiring && !isAlarmRingOpen) {
          if (mounted) {
            context.read<AlarmBloc>().add(LoadAlarms());
            _navigateToAlarmRing();
          }
        }

        // Uyku yeni algılandıysa alarm listesini yenile
        if (newStatus.sleepDetected && !oldSleepDetected) {
          if (mounted) {
            context.read<AlarmBloc>().add(LoadAlarms());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).sleepDetectedSnack),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.primary,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }

        // Alarm iptal edildiyse (sleepDetected false oldu) alarm listesini yenile
        if (!newStatus.sleepDetected && oldSleepDetected) {
          if (mounted) {
            context.read<AlarmBloc>().add(LoadAlarms());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).movementDetectedSnack),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.snoozeColor,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      }
    });
  }

  Future<void> _navigateToAlarmRing() async {
    if (isAlarmRingOpen) return; // zaten açık
    isAlarmRingOpen = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final jsonString = prefs.getString(AppConstants.prefAlarms);
      if (jsonString == null || jsonString.isEmpty) {
        isAlarmRingOpen = false;
        return;
      }

      // Çalan alarm'ın id'sini bul
      final firingId = prefs.getString('bg_alarm_firing_id');
      if (firingId == null) {
        isAlarmRingOpen = false;
        return;
      }

      final jsonList = json.decode(jsonString) as List<dynamic>;
      for (final item in jsonList) {
        if (item is Map<String, dynamic> && item['id'] == firingId) {
          final alarm = AlarmModel.fromJson(item);
          if (mounted) {
            context.push('/alarm-ring', extra: alarm);
          }
          return;
        }
      }
      isAlarmRingOpen = false; // alarm bulunamadı
    } catch (e) {
      isAlarmRingOpen = false;
      debugPrint('[HomeScreen] Alarm ring navigation hatası: $e');
    }
  }

  Future<void> _refreshStatus() async {
    final newStatus = await getBackgroundServiceStatus();
    if (mounted) {
      setState(() {
        _status = newStatus;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.bedtime_outlined),
            tooltip: t.sleepAnalysisTooltip,
            onPressed: () => context.push('/sleep'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          // Genel modda (ekran modu kapalı) dokunma = etkileşim
          if (!_status.screenModeDetection) {
            notifyUserInteraction();
          }
        },
        child: BlocBuilder<AlarmBloc, AlarmState>(
          builder: (context, state) {
            if (state is AlarmLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AlarmError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AlarmBloc>().add(LoadAlarms()),
                      child: Text(t.retryButton),
                    ),
                  ],
                ),
              );
            }

            if (state is AlarmLoaded) {
              return _buildContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAlarmDialog(context),
        icon: const Icon(Icons.alarm_add),
        label: Text(t.addAlarm),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AlarmLoaded state) {
    final t = S.of(context);
    return CustomScrollView(
      slivers: [
        // İzleme durumu kartı
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _buildMonitoringCard(),
          ),
        ),

        // Sonraki alarm kartı
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: NextAlarmCard(alarm: state.nextAlarm),
          ),
        ),

        // AI Uyku Koçu giriş kartı
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: _AiCoachBannerCard(),
          ),
        ),

        // Alarm listesi başlığı
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  t.alarms,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  t.nAlarms(state.alarms.length),
                  style: TextStyle(color: AppColorsExtension.of(context).textSecondary),
                ),
              ],
            ),
          ),
        ),

        // Alarm listesi
        if (state.alarms.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.alarm_off, size: 64, color: AppColorsExtension.of(context).textHint),
                  const SizedBox(height: 16),
                  Text(
                    t.noAlarmsYet,
                    style: TextStyle(
                      color: AppColorsExtension.of(context).textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.noAlarmsHint,
                    style: TextStyle(color: AppColorsExtension.of(context).textHint),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final alarm = state.alarms[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AlarmCard(
                    alarm: alarm,
                    onToggle: () {
                      context.read<AlarmBloc>().add(ToggleAlarmEvent(alarm.id));
                    },
                    onDelete: () {
                      _showDeleteConfirm(context, alarm.id);
                    },
                    onTap: () {
                      // Alarm çalma ekranını test etmek için
                      // Gerçek uygulamada bu, bildirimden tetiklenir
                    },
                  ),
                );
              }, childCount: state.alarms.length),
            ),
          ),

        // Alt boşluk (FAB'ın altında kalan içerik için)
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  void _showAddAlarmDialog(BuildContext context) async {
    final now = DateTime.now();
    final initialTime = TimeOfDay(hour: now.hour + 1, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        final c = AppColorsExtension.of(context);
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: c.surface,
              hourMinuteColor: c.card,
              dialBackgroundColor: c.card,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && context.mounted) {
      var scheduledAt = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Eğer seçilen saat geçmişse, yarına kur
      if (scheduledAt.isBefore(now)) {
        scheduledAt = scheduledAt.add(const Duration(days: 1));
      }

      if (context.mounted) {
        context.read<AlarmBloc>().add(AddAlarm(scheduledAt: scheduledAt));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).alarmSetAt(DateTimeUtils.formatTimeWithDate(scheduledAt)),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }

  Widget _buildMonitoringCard() {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    final isMonitoring = _status.isMonitoring;
    final isSleepDetected = _status.sleepDetected;
    final isScreenOff = _status.isScreenOff;
    final isCountingDown = _status.isCountingDown;
    final isScreenMode = _status.screenModeDetection;
    final isAutoDetection = _status.autoDetection;

    String statusText;
    IconData statusIcon;
    Color statusColor;

    if (isSleepDetected) {
      statusText = t.statusSleepDetected;
      statusIcon = Icons.bedtime;
      statusColor = AppColors.success;
    } else if (isMonitoring && !isAutoDetection) {
      statusText = t.statusAutoDetectionOff;
      statusIcon = Icons.pause_circle_outline;
      statusColor = c.textHint;
    } else if (isMonitoring && _status.outsideTimeRange) {
      statusText = t.statusOutsideRange;
      statusIcon = Icons.schedule;
      statusColor = c.textHint;
    } else if (isMonitoring && isCountingDown) {
      final remaining = _status.remainingSeconds;
      final timeText = remaining > 60
          ? '${remaining ~/ 60} ${t.formatMinShort} ${remaining % 60} ${t.formatSecShort}'
          : '$remaining ${t.formatSecShort}';
      if (isScreenMode) {
        statusText = t.statusScreenOff(timeText);
        statusIcon = Icons.nightlight_round;
      } else {
        statusText = t.statusInactivity(timeText);
        statusIcon = Icons.hourglass_bottom;
      }
      statusColor = AppColors.snoozeColor;
    } else if (isMonitoring && isScreenMode && !isScreenOff) {
      statusText = t.statusScreenOn;
      statusIcon = Icons.visibility;
      statusColor = AppColors.primary;
    } else if (isMonitoring && !isScreenMode && !isScreenOff) {
      statusText = t.statusPhoneInUse;
      statusIcon = Icons.phone_android;
      statusColor = AppColors.primary;
    } else if (isMonitoring) {
      statusText = t.monitoring;
      statusIcon = Icons.visibility;
      statusColor = AppColors.primary;
    } else {
      statusText = t.notMonitoring;
      statusIcon = Icons.visibility_off;
      statusColor = c.textHint;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              statusText,
              style: TextStyle(color: statusColor, fontSize: 13),
            ),
          ),
          // Başlat / Durdur butonu
          GestureDetector(
            onTap: () async {
              if (isMonitoring) {
                await stopBackgroundService();
              } else {
                await startBackgroundService();
              }
              await _refreshStatus();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isMonitoring ? t.stop : t.start,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, String alarmId) {
    final t = S.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColorsExtension.of(context).surface,
        title: Text(t.deleteAlarm),
        content: Text(t.deleteAlarmConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AlarmBloc>().add(DeleteAlarm(alarmId));
            },
            child: Text(
              t.delete,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Ana sayfada AI Uyku Koçu'na yönlendiren belirgin banner kart.
class _AiCoachBannerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: InkWell(
        onTap: () => context.push('/coach'),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.tertiary.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Sol: ikon + metin
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          t.coachTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.coachSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Sağ: ok ikonu
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
