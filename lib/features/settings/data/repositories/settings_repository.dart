import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

/// SharedPreferences tabanlı ayar deposu.
class SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  int getWaitSeconds() =>
      _prefs.getInt(AppConstants.prefWaitSeconds) ??
      AppConstants.defaultWaitSeconds;

  Future<void> setWaitSeconds(int value) =>
      _prefs.setInt(AppConstants.prefWaitSeconds, value);

  int getSleepMinutes() =>
      _prefs.getInt(AppConstants.prefSleepMinutes) ??
      AppConstants.defaultSleepMinutes;

  Future<void> setSleepMinutes(int value) =>
      _prefs.setInt(AppConstants.prefSleepMinutes, value);

  int getSnoozeMinutes() =>
      _prefs.getInt(AppConstants.prefSnoozeMinutes) ??
      AppConstants.defaultSnoozeDurationMinutes;

  Future<void> setSnoozeMinutes(int value) =>
      _prefs.setInt(AppConstants.prefSnoozeMinutes, value);

  bool getAutoDetection() =>
      _prefs.getBool(AppConstants.prefAutoDetection) ?? true;

  Future<void> setAutoDetection(bool value) =>
      _prefs.setBool(AppConstants.prefAutoDetection, value);

  /// Ekran modu: true = sadece ekran kapalıyken algıla, false = genel hareketsizlik algıla
  bool getScreenModeDetection() =>
      _prefs.getBool(AppConstants.prefScreenModeDetection) ?? true;

  Future<void> setScreenModeDetection(bool value) =>
      _prefs.setBool(AppConstants.prefScreenModeDetection, value);

  String getAlarmSound() =>
      _prefs.getString(AppConstants.prefAlarmSound) ?? 'default';

  Future<void> setAlarmSound(String value) =>
      _prefs.setString(AppConstants.prefAlarmSound, value);

  String getAlarmSoundTitle() =>
      _prefs.getString(AppConstants.prefAlarmSoundTitle) ?? 'Varsayılan';

  Future<void> setAlarmSoundTitle(String value) =>
      _prefs.setString(AppConstants.prefAlarmSoundTitle, value);

  // Otomatik alarm çalışma aralığı
  int getAutoAlarmStartHour() =>
      _prefs.getInt(AppConstants.prefAutoAlarmStartHour) ??
      AppConstants.defaultAutoAlarmStartHour;

  Future<void> setAutoAlarmStartHour(int value) =>
      _prefs.setInt(AppConstants.prefAutoAlarmStartHour, value);

  int getAutoAlarmStartMinute() =>
      _prefs.getInt(AppConstants.prefAutoAlarmStartMinute) ??
      AppConstants.defaultAutoAlarmStartMinute;

  Future<void> setAutoAlarmStartMinute(int value) =>
      _prefs.setInt(AppConstants.prefAutoAlarmStartMinute, value);

  int getAutoAlarmEndHour() =>
      _prefs.getInt(AppConstants.prefAutoAlarmEndHour) ??
      AppConstants.defaultAutoAlarmEndHour;

  Future<void> setAutoAlarmEndHour(int value) =>
      _prefs.setInt(AppConstants.prefAutoAlarmEndHour, value);

  int getAutoAlarmEndMinute() =>
      _prefs.getInt(AppConstants.prefAutoAlarmEndMinute) ??
      AppConstants.defaultAutoAlarmEndMinute;

  Future<void> setAutoAlarmEndMinute(int value) =>
      _prefs.setInt(AppConstants.prefAutoAlarmEndMinute, value);

  /// Dil tercihi: 'system', 'tr', 'en'
  String getLanguage() =>
      _prefs.getString(AppConstants.prefLanguage) ?? 'system';

  Future<void> setLanguage(String value) =>
      _prefs.setString(AppConstants.prefLanguage, value);
}
