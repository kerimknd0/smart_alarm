import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';

/// Settings state.
class SettingsState extends Equatable {
  final int waitSeconds;
  final int sleepMinutes;
  final int snoozeMinutes;
  final bool autoDetection;
  final bool screenModeDetection;
  final String alarmSound;
  final String alarmSoundTitle;
  final int autoAlarmStartHour;
  final int autoAlarmStartMinute;
  final int autoAlarmEndHour;
  final int autoAlarmEndMinute;
  final String languageCode; // 'system', 'tr', 'en'

  const SettingsState({
    this.waitSeconds = AppConstants.defaultWaitSeconds,
    this.sleepMinutes = AppConstants.defaultSleepMinutes,
    this.snoozeMinutes = AppConstants.defaultSnoozeDurationMinutes,
    this.autoDetection = true,
    this.screenModeDetection = true,
    this.alarmSound = 'default',
    this.alarmSoundTitle = 'Varsayılan',
    this.autoAlarmStartHour = AppConstants.defaultAutoAlarmStartHour,
    this.autoAlarmStartMinute = AppConstants.defaultAutoAlarmStartMinute,
    this.autoAlarmEndHour = AppConstants.defaultAutoAlarmEndHour,
    this.autoAlarmEndMinute = AppConstants.defaultAutoAlarmEndMinute,
    this.languageCode = 'system',
  });

  /// Çalışma aralığı okunabilir metni.
  String get autoAlarmTimeRangeText {
    final sh = autoAlarmStartHour.toString().padLeft(2, '0');
    final sm = autoAlarmStartMinute.toString().padLeft(2, '0');
    final eh = autoAlarmEndHour.toString().padLeft(2, '0');
    final em = autoAlarmEndMinute.toString().padLeft(2, '0');
    return '$sh:$sm — $eh:$em';
  }

  SettingsState copyWith({
    int? waitSeconds,
    int? sleepMinutes,
    int? snoozeMinutes,
    bool? autoDetection,
    bool? screenModeDetection,
    String? alarmSound,
    String? alarmSoundTitle,
    int? autoAlarmStartHour,
    int? autoAlarmStartMinute,
    int? autoAlarmEndHour,
    int? autoAlarmEndMinute,
    String? languageCode,
  }) {
    return SettingsState(
      waitSeconds: waitSeconds ?? this.waitSeconds,
      sleepMinutes: sleepMinutes ?? this.sleepMinutes,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      autoDetection: autoDetection ?? this.autoDetection,
      screenModeDetection: screenModeDetection ?? this.screenModeDetection,
      alarmSound: alarmSound ?? this.alarmSound,
      alarmSoundTitle: alarmSoundTitle ?? this.alarmSoundTitle,
      autoAlarmStartHour: autoAlarmStartHour ?? this.autoAlarmStartHour,
      autoAlarmStartMinute: autoAlarmStartMinute ?? this.autoAlarmStartMinute,
      autoAlarmEndHour: autoAlarmEndHour ?? this.autoAlarmEndHour,
      autoAlarmEndMinute: autoAlarmEndMinute ?? this.autoAlarmEndMinute,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [
    waitSeconds,
    sleepMinutes,
    snoozeMinutes,
    autoDetection,
    screenModeDetection,
    alarmSound,
    alarmSoundTitle,
    autoAlarmStartHour,
    autoAlarmStartMinute,
    autoAlarmEndHour,
    autoAlarmEndMinute,
    languageCode,
  ];
}
