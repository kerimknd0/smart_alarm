// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Smart Alarm';

  @override
  String get homeTitle => 'Smart Alarm';

  @override
  String get monitoring => 'Monitoring';

  @override
  String get notMonitoring => 'Inactive';

  @override
  String get nextAlarm => 'Next Alarm';

  @override
  String get noAlarm => 'No alarm';

  @override
  String get lastSleep => 'Last Sleep';

  @override
  String get alarms => 'Alarms';

  @override
  String get addAlarm => 'Add Alarm';

  @override
  String get editAlarm => 'Edit Alarm';

  @override
  String get deleteAlarm => 'Delete Alarm';

  @override
  String get deleteAlarmConfirm =>
      'Are you sure you want to delete this alarm?';

  @override
  String get automatic => 'Automatic';

  @override
  String get manual => 'Manual';

  @override
  String get alarmSet => 'Alarm set';

  @override
  String get alarmCancelled => 'Alarm cancelled';

  @override
  String nAlarms(int count) {
    return '$count alarm(s)';
  }

  @override
  String get goodMorning => 'Good Morning! ☀️';

  @override
  String get youSlept => 'You slept';

  @override
  String get hours => 'hours';

  @override
  String get minutes => 'minutes';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get snooze => 'Snooze';

  @override
  String snoozeWithDuration(int minutes) {
    return 'Snooze ($minutes min)';
  }

  @override
  String get settings => 'Settings';

  @override
  String get waitTime => 'Wait Time';

  @override
  String get waitTimeDesc => 'Wait time for sleep detection';

  @override
  String get sleepDuration => 'Sleep Duration';

  @override
  String get sleepDurationDesc => 'Sleep duration for automatic alarm';

  @override
  String get snoozeDuration => 'Snooze Duration';

  @override
  String get snoozeDurationDesc => 'Alarm snooze duration';

  @override
  String get alarmSound => 'Alarm Sound';

  @override
  String get alarmSoundDesc => 'Sound to play when alarm rings';

  @override
  String get autoDetection => 'Auto Detection';

  @override
  String get autoDetectionDesc => 'Start sleep detection automatically';

  @override
  String get screenModeDetection => 'Screen State Detection';

  @override
  String get screenModeDetectionDesc =>
      'On: Countdown starts only when screen is off\nOff: Countdown also starts on in-app inactivity';

  @override
  String get activeTimeRange => 'Active Time Range';

  @override
  String get activeTimeRangeDesc => 'Time range for automatic alarm detection';

  @override
  String get activeTimeRangeDialogDesc =>
      'Select the time range for automatic sleep detection. No new detection starts outside this range, but already set alarms are not affected.';

  @override
  String get permissionsRequired => 'Permissions Required';

  @override
  String get notificationPermission => 'Notification Permission';

  @override
  String get notificationPermissionDesc =>
      'Notification permission is required to sound alarms.';

  @override
  String get exactAlarmPermission => 'Exact Alarm Permission';

  @override
  String get exactAlarmPermissionDesc => 'Required for alarms to ring on time.';

  @override
  String get grant => 'Grant';

  @override
  String get granted => 'Granted ✓';

  @override
  String get continueText => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get retryButton => 'Retry';

  @override
  String get noAlarmsYet => 'No alarms yet';

  @override
  String get noAlarmsHint => 'Tap + to add an alarm';

  @override
  String get past => 'Past';

  @override
  String inTime(String time) {
    return 'in $time';
  }

  @override
  String get sweetDreams => 'Sweet dreams 🌙';

  @override
  String get stop => 'Stop';

  @override
  String get start => 'Start';

  @override
  String get statusSleepDetected => '😴 Sleep detected — alarm set';

  @override
  String get statusAutoDetectionOff => '⏸️ Auto detection is off';

  @override
  String get statusOutsideRange => '🕐 Outside active range — detection paused';

  @override
  String statusScreenOff(String time) {
    return '🌙 Screen off — alarm in $time';
  }

  @override
  String statusInactivity(String time) {
    return '⏳ Inactivity — alarm in $time';
  }

  @override
  String get statusScreenOn => '📱 Screen on — waiting...';

  @override
  String get statusPhoneInUse => '📱 Phone in use — monitoring...';

  @override
  String get sleepDetectedSnack => '😴 Sleep detected! Automatic alarm set.';

  @override
  String get movementDetectedSnack =>
      '🔄 Movement detected — automatic alarm cancelled.';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionTiming => 'Timing';

  @override
  String get sectionSound => 'Sound';

  @override
  String get sectionAbout => 'About';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get noAlarmSoundFound => 'No alarm sound found';

  @override
  String get defaultAlarmSound => 'Default Alarm Sound';

  @override
  String get defaultLabel => 'Default';

  @override
  String get startLabel => 'Start';

  @override
  String get endLabel => 'End';

  @override
  String alarmSetAt(String time) {
    return 'Alarm set: $time';
  }

  @override
  String youSleptDuration(String duration) {
    return 'You slept: $duration';
  }

  @override
  String get formatMinShort => 'min';

  @override
  String get formatSecShort => 'sec';

  @override
  String get formatHour => 'hours';

  @override
  String get formatHourShort => 'hr';

  @override
  String formatDurationHoursMinutes(int hours, int minutes) {
    return '$hours hours $minutes minutes';
  }

  @override
  String formatDurationHours(int hours) {
    return '$hours hours';
  }

  @override
  String formatDurationMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get language => 'Language';

  @override
  String get languageDesc => 'Change application language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get themeMode => 'Theme';

  @override
  String get themeModeDesc => 'Change application theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get sleepAnalysis => 'Sleep Analysis';

  @override
  String get sleepAnalysisTooltip => 'Sleep Analysis';

  @override
  String get lastNight => 'Last Night';

  @override
  String get thisWeek => 'This Week';

  @override
  String get alerts => 'Alerts';

  @override
  String get viewAllHistory => 'View All History';

  @override
  String get noSleepRecordYet => 'No Sleep Record Yet';

  @override
  String get noSleepRecordHint =>
      'After using the alarm,\nyour sleep analysis will appear here.';

  @override
  String get viewDetails => 'View details';

  @override
  String get sleepDurationLabel => 'Duration';

  @override
  String get wakeCount => 'Awakenings';

  @override
  String get efficiency => 'Efficiency';

  @override
  String get avgScore => 'Avg. Score';

  @override
  String get avgDuration => 'Avg. Duration';

  @override
  String get recordCount => 'Records';

  @override
  String get nightsUnit => 'nights';

  @override
  String get timesUnit => 'times';

  @override
  String get detailBedTime => 'Bedtime';

  @override
  String get detailWakeTime => 'Wake up';

  @override
  String get scoreDetail => 'Score Details';

  @override
  String get scoreMotion => 'Motion';

  @override
  String get scoreConsistency => 'Consistency';

  @override
  String get scoreAlarmResponse => 'Alarm Response';

  @override
  String get remCycles => 'REM Cycles (Estimated)';

  @override
  String get noRemData => 'Not enough data.';

  @override
  String get lightSleepWindow => 'Light sleep window';

  @override
  String get nightWakeups => 'Night Awakenings';

  @override
  String get screenTurnedOn => 'Screen turned on';

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get anomalyInsufficientSleepTitle => 'Insufficient Sleep';

  @override
  String anomalyInsufficientSleepDesc(int count) {
    return 'You slept less than 5 hours for $count consecutive nights. This may negatively affect your health.';
  }

  @override
  String get anomalyScoreDropTitle => 'Sleep Quality Dropped';

  @override
  String anomalyScoreDropDesc(int score, int avg) {
    return 'Last night\'s sleep score ($score) is well below your 7-day average ($avg).';
  }

  @override
  String get anomalyFrequentWakingTitle => 'Frequent Waking';

  @override
  String anomalyFrequentWakingDesc(int count) {
    return 'You woke up 3 or more times on $count nights in the past 7 nights.';
  }

  @override
  String get anomalySocialJetLagTitle => 'Social Jet Lag';

  @override
  String anomalySocialJetLagDesc(String weekend) {
    return 'Your weekend average (${weekend}h) is more than 3 hours above weekdays. This may disrupt your biological clock.';
  }

  @override
  String get anomalyBedtimeShiftTitle => 'Irregular Bedtime';

  @override
  String get anomalyBedtimeShiftDesc =>
      'Your bedtime varied by more than 2 hours in the last 7 days. Try to establish a consistent sleep routine.';

  @override
  String get anomalyExcessiveSnoozeTitle => 'Too Much Snoozing';

  @override
  String anomalyExcessiveSnoozeDesc(int count) {
    return 'You snoozed your alarm $count times this morning. This may indicate poor sleep quality.';
  }

  @override
  String get anomalyStreakTitle => '7-Day Perfect Sleep! 🌟';

  @override
  String get anomalyStreakDesc =>
      'Your sleep score has been above 80 for 7 nights in a row. You\'ve built a great sleep routine!';

  @override
  String get anomalyImprovementTitle => 'Sleep Quality Improved! 📈';

  @override
  String anomalyImprovementDesc(int thisWeek, int lastWeek) {
    return 'Your average score this week ($thisWeek) has significantly improved compared to last week ($lastWeek).';
  }
}
