import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/ringtone_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

/// Ayarlar ekranı.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Otomatik Algılama
              _buildSectionTitle(t.sectionGeneral),
              _buildSwitchTile(
                context: context,
                title: t.autoDetection,
                subtitle: t.autoDetectionDesc,
                value: state.autoDetection,
                icon: Icons.auto_awesome,
                onChanged: (_) {
                  context.read<SettingsBloc>().add(ToggleAutoDetection());
                },
              ),
              _buildSwitchTile(
                context: context,
                title: t.screenModeDetection,
                subtitle: t.screenModeDetectionDesc,
                value: state.screenModeDetection,
                icon: Icons.screen_lock_portrait,
                onChanged: (_) {
                  context
                      .read<SettingsBloc>()
                      .add(ToggleScreenModeDetection());
                },
              ),
              _buildOptionTile(
                context: context,
                title: t.language,
                subtitle: t.languageDesc,
                value: _languageLabel(t, state.languageCode),
                icon: Icons.language,
                onTap: () => _showLanguageDialog(context, state.languageCode),
              ),
              _buildOptionTile(
                context: context,
                title: t.themeMode,
                subtitle: t.themeModeDesc,
                value: _themeModeLabel(t, state.themeMode),
                icon: Icons.palette_outlined,
                onTap: () => _showThemeModeDialog(context, state.themeMode),
              ),
              const SizedBox(height: 24),

              // Zamanlama
              _buildSectionTitle(t.sectionTiming),
              _buildOptionTile(
                context: context,
                title: t.waitTime,
                subtitle: t.waitTimeDesc,
                value: _formatWaitTime(context, state.waitSeconds),
                icon: Icons.hourglass_empty,
                onTap: () => _showWaitTimeDialog(context, state.waitSeconds),
              ),
              _buildOptionTile(
                context: context,
                title: t.sleepDuration,
                subtitle: t.sleepDurationDesc,
                value: _formatSleepDuration(context, state.sleepMinutes),
                icon: Icons.bedtime,
                onTap: () =>
                    _showSleepDurationDialog(context, state.sleepMinutes),
              ),
              _buildOptionTile(
                context: context,
                title: t.snoozeDuration,
                subtitle: t.snoozeDurationDesc,
                value: '${state.snoozeMinutes} ${t.formatMinShort}',
                icon: Icons.snooze,
                onTap: () => _showSnoozeDialog(context, state.snoozeMinutes),
              ),
              _buildOptionTile(
                context: context,
                title: t.activeTimeRange,
                subtitle: t.activeTimeRangeDesc,
                value: state.autoAlarmTimeRangeText,
                icon: Icons.schedule,
                onTap: () => _showTimeRangeDialog(context, state),
              ),
              const SizedBox(height: 24),

              // Ses
              _buildSectionTitle(t.sectionSound),
              _buildOptionTile(
                context: context,
                title: t.alarmSound,
                subtitle: t.alarmSoundDesc,
                value: state.alarmSoundTitle,
                icon: Icons.music_note,
                onTap: () => _showAlarmSoundDialog(context, state.alarmSound),
              ),
              const SizedBox(height: 24),

              // Hakkında
              _buildSectionTitle(t.sectionAbout),
              _buildInfoTile(
                context: context,
                title: AppConstants.appName,
                subtitle: t.version('1.0.0'),
                icon: Icons.info_outline,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    final c = AppColorsExtension.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: c.textHint),
        ),
        secondary: Icon(icon, color: AppColors.primary),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final c = AppColorsExtension.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: c.textHint),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final c = AppColorsExtension.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: c.textHint),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  /// Saniye değerini okunabilir formata çevirir.
  String _formatWaitTime(BuildContext context, int seconds) {
    final t = S.of(context);
    if (seconds < 60) {
      return '$seconds ${t.formatSecShort}';
    }
    final minutes = seconds ~/ 60;
    return '$minutes ${t.formatMinShort}';
  }

  /// Dakika değerini okunabilir uyku süresi formatına çevirir.
  String _formatSleepDuration(BuildContext context, int minutes) {
    final t = S.of(context);
    if (minutes < 60) {
      return '$minutes ${t.formatMinShort}';
    }
    final hours = minutes ~/ 60;
    final remainingMin = minutes % 60;
    if (remainingMin == 0) {
      return '$hours ${t.formatHour}';
    }
    return '$hours ${t.formatHourShort} $remainingMin ${t.formatMinShort}';
  }

  void _showWaitTimeDialog(BuildContext context, int currentValue) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.surface,
        title: Text(t.waitTime),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.waitTimeOptions.map((option) {
            final isSelected = option == currentValue;
            final label = option < 60
                ? '$option ${t.formatSecShort}'
                : '${option ~/ 60} ${t.formatMinShort}';
            return ListTile(
              title: Text(
                label,
                style: TextStyle(
                  color:
                      isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(UpdateWaitSeconds(option));
                Navigator.pop(dialogContext);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSleepDurationDialog(BuildContext context, int currentValue) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.surface,
        title: Text(t.sleepDuration),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.sleepDurationOptions.map((option) {
            final isSelected = option == currentValue;
            return ListTile(
              title: Text(
                _formatSleepDuration(context, option),
                style: TextStyle(
                  color: isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(UpdateSleepMinutes(option));
                Navigator.pop(dialogContext);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSnoozeDialog(BuildContext context, int currentValue) {
    final t = S.of(context);
    _showOptionDialog(
      context: context,
      title: t.snoozeDuration,
      options: AppConstants.snoozeOptions,
      currentValue: currentValue,
      suffix: t.formatMinShort,
      onSelected: (value) {
        context.read<SettingsBloc>().add(UpdateSnoozeMinutes(value));
      },
    );
  }

  /// Dil koduna göre okunabilir etiket.
  String _languageLabel(S t, String code) {
    switch (code) {
      case 'tr':
        return t.languageTurkish;
      case 'en':
        return t.languageEnglish;
      default:
        return t.languageSystem;
    }
  }

  void _showLanguageDialog(BuildContext context, String currentCode) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    final options = [
      ('system', t.languageSystem),
      ('tr', t.languageTurkish),
      ('en', t.languageEnglish),
    ];
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.surface,
        title: Text(t.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            final code = option.$1;
            final label = option.$2;
            final isSelected = code == currentCode;
            return ListTile(
              title: Text(
                label,
                style: TextStyle(
                  color:
                      isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(UpdateLanguage(code));
                Navigator.pop(dialogContext);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Tema moduna göre okunabilir etiket.
  String _themeModeLabel(S t, String mode) {
    switch (mode) {
      case 'light':
        return t.themeLight;
      case 'dark':
        return t.themeDark;
      default:
        return t.themeSystem;
    }
  }

  void _showThemeModeDialog(BuildContext context, String currentMode) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    final options = [
      ('dark', t.themeDark),
      ('light', t.themeLight),
      ('system', t.themeSystem),
    ];
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.surface,
        title: Text(t.themeMode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            final code = option.$1;
            final label = option.$2;
            final isSelected = code == currentMode;
            return ListTile(
              title: Text(
                label,
                style: TextStyle(
                  color:
                      isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(UpdateThemeMode(code));
                Navigator.pop(dialogContext);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showOptionDialog({
    required BuildContext context,
    required String title,
    required List<int> options,
    required int currentValue,
    required String suffix,
    required ValueChanged<int> onSelected,
  }) {
    final c = AppColorsExtension.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.surface,
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            final isSelected = option == currentValue;
            return ListTile(
              title: Text(
                '$option $suffix',
                style: TextStyle(
                  color: isSelected ? AppColors.primary : c.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                onSelected(option);
                Navigator.pop(dialogContext);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showTimeRangeDialog(BuildContext context, SettingsState state) {
    showDialog(
      context: context,
      builder: (dialogContext) => _TimeRangeDialog(
        startHour: state.autoAlarmStartHour,
        startMinute: state.autoAlarmStartMinute,
        endHour: state.autoAlarmEndHour,
        endMinute: state.autoAlarmEndMinute,
        onSaved: (sh, sm, eh, em) {
          context.read<SettingsBloc>().add(UpdateAutoAlarmTimeRange(
                startHour: sh,
                startMinute: sm,
                endHour: eh,
                endMinute: em,
              ));
        },
      ),
    );
  }

  void _showAlarmSoundDialog(BuildContext context, String currentUri) {
    showDialog(
      context: context,
      builder: (dialogContext) => _AlarmSoundDialog(
        currentUri: currentUri,
        onSelected: (uri, title) {
          context.read<SettingsBloc>().add(UpdateAlarmSound(uri, title));
        },
      ),
    );
  }
}

/// Alarm sesi seçim dialogu — sistem seslerini listeler ve önizleme çalar.
class _AlarmSoundDialog extends StatefulWidget {
  final String currentUri;
  final void Function(String uri, String title) onSelected;

  const _AlarmSoundDialog({
    required this.currentUri,
    required this.onSelected,
  });

  @override
  State<_AlarmSoundDialog> createState() => _AlarmSoundDialogState();
}

class _AlarmSoundDialogState extends State<_AlarmSoundDialog> {
  List<RingtoneItem> _ringtones = [];
  bool _loading = true;
  String _selectedUri = '';
  String _selectedTitle = '';
  String _playingUri = '';

  @override
  void initState() {
    super.initState();
    _selectedUri = widget.currentUri;
    _loadRingtones();
  }

  Future<void> _loadRingtones() async {
    final alarmSounds = await RingtoneService.getAlarmRingtones();

    // "default" seçili ise gerçek varsayılan URI'yi al
    if (_selectedUri == 'default') {
      final defaultUri = await RingtoneService.getDefaultAlarmUri();
      _selectedUri = defaultUri;
    }

    // Mevcut seçili sesin başlığını bul
    for (final item in alarmSounds) {
      if (item.uri == _selectedUri) {
        _selectedTitle = item.title;
        break;
      }
    }

    if (mounted) {
      setState(() {
        _ringtones = alarmSounds;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    RingtoneService.stopPreview();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    return AlertDialog(
      backgroundColor: c.surface,
      title: Row(
        children: [
          const Icon(Icons.music_note, color: AppColors.primary, size: 24),
          const SizedBox(width: 8),
          Text(t.alarmSound),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _ringtones.isEmpty
                ? Center(
                    child: Text(
                      t.noAlarmSoundFound,
                      style: TextStyle(color: c.textHint),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _ringtones.length,
                    itemBuilder: (context, index) {
                      final item = _ringtones[index];
                      final isSelected = item.uri == _selectedUri;
                      final isPlaying = item.uri == _playingUri;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.4))
                              : null,
                        ),
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_outline,
                            color: isSelected
                                ? AppColors.primary
                                : c.textHint,
                            size: 28,
                          ),
                          title: Text(
                            item.title,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primary
                                  : c.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle,
                                  color: AppColors.primary, size: 22)
                              : null,
                          onTap: () {
                            // Önizleme çal / durdur
                            if (isPlaying) {
                              RingtoneService.stopPreview();
                              setState(() => _playingUri = '');
                            } else {
                              RingtoneService.playPreview(item.uri);
                              setState(() {
                                _playingUri = item.uri;
                                _selectedUri = item.uri;
                                _selectedTitle = item.title;
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            RingtoneService.stopPreview();
            Navigator.pop(context);
          },
          child: Text(t.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            RingtoneService.stopPreview();
            final title = _selectedTitle.isEmpty
                ? S.of(context).defaultLabel
                : _selectedTitle;
            widget.onSelected(_selectedUri, title);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: Text(t.save),
        ),
      ],
    );
  }
}

/// Çalışma aralığı seçim dialogu — başlangıç ve bitiş saati seçimi.
class _TimeRangeDialog extends StatefulWidget {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final void Function(int sh, int sm, int eh, int em) onSaved;

  const _TimeRangeDialog({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.onSaved,
  });

  @override
  State<_TimeRangeDialog> createState() => _TimeRangeDialogState();
}

class _TimeRangeDialogState extends State<_TimeRangeDialog> {
  late TimeOfDay _start;
  late TimeOfDay _end;

  @override
  void initState() {
    super.initState();
    _start = TimeOfDay(hour: widget.startHour, minute: widget.startMinute);
    _end = TimeOfDay(hour: widget.endHour, minute: widget.endMinute);
  }

  String _formatTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickTime(bool isStart) async {
    final initial = isStart ? _start : _end;
    final c = AppColorsExtension.of(context);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: c.surface,
              hourMinuteColor: c.card,
              dialBackgroundColor: c.card,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _start = picked;
        } else {
          _end = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final c = AppColorsExtension.of(context);
    return AlertDialog(
      backgroundColor: c.surface,
      title: Row(
        children: [
          const Icon(Icons.schedule, color: AppColors.primary, size: 24),
          const SizedBox(width: 8),
          Text(t.activeTimeRange),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.activeTimeRangeDialogDesc,
            style: TextStyle(color: c.textHint, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _timeButton(
                  label: t.startLabel,
                  time: _formatTime(_start),
                  onTap: () => _pickTime(true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.arrow_forward, color: c.textHint),
              ),
              Expanded(
                child: _timeButton(
                  label: t.endLabel,
                  time: _formatTime(_end),
                  onTap: () => _pickTime(false),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSaved(
              _start.hour,
              _start.minute,
              _end.hour,
              _end.minute,
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: Text(t.save),
        ),
      ],
    );
  }

  Widget _timeButton({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    final c = AppColorsExtension.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: c.textHint,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}