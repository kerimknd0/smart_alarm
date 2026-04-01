import 'package:equatable/equatable.dart';

/// Settings BLoC event'leri.
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

/// Ayarları yükle.
class LoadSettings extends SettingsEvent {}

/// Bekleme süresini güncelle (saniye).
class UpdateWaitSeconds extends SettingsEvent {
  final int seconds;
  const UpdateWaitSeconds(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

/// Uyku süresini güncelle (dakika).
class UpdateSleepMinutes extends SettingsEvent {
  final int minutes;
  const UpdateSleepMinutes(this.minutes);

  @override
  List<Object?> get props => [minutes];
}

/// Snooze süresini güncelle.
class UpdateSnoozeMinutes extends SettingsEvent {
  final int minutes;
  const UpdateSnoozeMinutes(this.minutes);

  @override
  List<Object?> get props => [minutes];
}

/// Otomatik algılama toggle.
class ToggleAutoDetection extends SettingsEvent {}

/// Ekran modu algılama toggle.
class ToggleScreenModeDetection extends SettingsEvent {}

/// Alarm sesini güncelle.
class UpdateAlarmSound extends SettingsEvent {
  final String soundUri;
  final String soundTitle;
  const UpdateAlarmSound(this.soundUri, this.soundTitle);

  @override
  List<Object?> get props => [soundUri, soundTitle];
}

/// Otomatik alarm çalışma aralığını güncelle.
class UpdateAutoAlarmTimeRange extends SettingsEvent {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  const UpdateAutoAlarmTimeRange({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });

  @override
  List<Object?> get props => [startHour, startMinute, endHour, endMinute];
}

/// Dil tercihini güncelle ('system', 'tr', 'en').
class UpdateLanguage extends SettingsEvent {
  final String languageCode;
  const UpdateLanguage(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
