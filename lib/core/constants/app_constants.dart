/// Uygulama genelinde kullanılan sabit değerler.
class AppConstants {
  AppConstants._();

  // Uygulama bilgileri
  static const String appName = 'Smart Alarm';

  // Varsayılan süreler
  static const int defaultWaitSeconds = 1800; // Uyku algılama bekleme süresi (sn) = 30 dk
  static const int defaultSleepMinutes = 480; // Uyku süresi (dakika) = 8 saat
  static const int defaultSnoozeDurationMinutes = 5; // Snooze süresi (dk)

  // Bekleme süresi seçenekleri (saniye)
  static const List<int> waitTimeOptions = [30, 600, 1200, 1800, 2700, 3600];
  // 30sn, 10dk, 20dk, 30dk, 45dk, 60dk

  // Uyku süresi seçenekleri (dakika)
  static const List<int> sleepDurationOptions = [1, 300, 360, 420, 480, 540, 600];
  // 1dk (test), 5sa, 6sa, 7sa, 8sa, 9sa, 10sa

  // Snooze süresi seçenekleri (dakika)
  static const List<int> snoozeOptions = [5, 10, 15];

  // Otomatik alarm çalışma aralığı varsayılanları
  static const int defaultAutoAlarmStartHour = 22;
  static const int defaultAutoAlarmStartMinute = 0;
  static const int defaultAutoAlarmEndHour = 6;
  static const int defaultAutoAlarmEndMinute = 0;

  // Notification kanal bilgileri
  static const String alarmChannelId = 'smart_alarm_channel_v2';
  static const String alarmChannelName = 'Alarm Bildirimleri';
  static const String alarmChannelDescription =
      'Alarm bildirimleri için kullanılır';

  // SharedPreferences anahtarları
  static const String prefWaitSeconds = 'pref_wait_seconds';
  static const String prefSleepMinutes = 'pref_sleep_minutes';
  static const String prefSnoozeMinutes = 'pref_snooze_minutes';
  static const String prefAutoDetection = 'pref_auto_detection';
  static const String prefScreenModeDetection = 'pref_screen_mode_detection';
  static const String prefAlarmSound = 'pref_alarm_sound';
  static const String prefAlarmSoundTitle = 'pref_alarm_sound_title';
  static const String prefAlarms = 'pref_alarms';
  static const String prefAutoAlarmStartHour = 'pref_auto_alarm_start_hour';
  static const String prefAutoAlarmStartMinute = 'pref_auto_alarm_start_minute';
  static const String prefAutoAlarmEndHour = 'pref_auto_alarm_end_hour';
  static const String prefAutoAlarmEndMinute = 'pref_auto_alarm_end_minute';
  static const String prefLanguage = 'pref_language';
  static const String prefThemeMode = 'pref_theme_mode';
}
