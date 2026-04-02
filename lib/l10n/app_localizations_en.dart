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

  @override
  String get coachTitle => 'AI Sleep Coach';

  @override
  String get coachSubtitle =>
      'Personalized recommendations based on your sleep data';

  @override
  String get coachNoData => 'No sleep data yet';

  @override
  String get coachNoDataHint =>
      'Start tracking your sleep to get personalized recommendations.';

  @override
  String get sleepGoalTitle => 'Sleep Goal';

  @override
  String get setGoal => 'Set Goal';

  @override
  String get editGoal => 'Edit Goal';

  @override
  String get yourGoal => 'Your Goal';

  @override
  String get goalNotSet => 'Goal not set';

  @override
  String get goalProgress => 'Goal Progress';

  @override
  String daysAchievedLabel(int achieved, int total) {
    return '$achieved / $total nights';
  }

  @override
  String currentStreakLabel(int streak) {
    return '$streak night streak';
  }

  @override
  String get sleepDebtTitle => 'Sleep Debt';

  @override
  String sleepDebtValue(String hours) {
    return '${hours}h debt';
  }

  @override
  String get noDebt => 'No debt 🎉';

  @override
  String debtRecovery(int days) {
    return '~$days nights to recover';
  }

  @override
  String get targetDuration => 'Target Duration';

  @override
  String get targetBedtime => 'Target Bedtime';

  @override
  String get targetWakeTime => 'Target Wake Time';

  @override
  String get targetScore => 'Target Score';

  @override
  String get notSet => 'Not set';

  @override
  String hoursMinutesLabel(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String get advicesTitle => 'Recommendations';

  @override
  String get noAdvices => 'No recommendations';

  @override
  String get noAdvicesHint => 'Your sleep looks great! Keep it up.';

  @override
  String get advicePriorityHigh => 'High';

  @override
  String get advicePriorityMedium => 'Medium';

  @override
  String get advicePriorityLow => 'Low';

  @override
  String get adviceCategoryDuration => 'Duration';

  @override
  String get adviceCategoryQuality => 'Quality';

  @override
  String get adviceCategoryConsistency => 'Consistency';

  @override
  String get adviceCategoryHabit => 'Habit';

  @override
  String get adviceCategoryAchievement => 'Achievement';

  @override
  String get adviceBedtimeTooLateTitle => 'Late Bedtime';

  @override
  String adviceBedtimeTooLateDesc(int diffMinutes, String targetBedtime) {
    return 'You\'re going to bed $diffMinutes minutes later than your goal ($targetBedtime). Try going to bed at $targetBedtime tonight.';
  }

  @override
  String get adviceBedtimeTooEarlyTitle => 'Early Bedtime';

  @override
  String adviceBedtimeTooEarlyDesc(String avgBedtime, String targetBedtime) {
    return 'You\'re going to bed earlier than your goal. Average: $avgBedtime, Target: $targetBedtime.';
  }

  @override
  String get adviceSleepDurationShortTitle => 'Insufficient Sleep';

  @override
  String adviceSleepDurationShortDesc(int shortfallMinutes) {
    return 'You\'re sleeping $shortfallMinutes minutes less than your goal. Try going to bed $shortfallMinutes minutes earlier.';
  }

  @override
  String get adviceSleepDurationLongTitle => 'Excessive Sleep';

  @override
  String adviceSleepDurationLongDesc(int excessMinutes) {
    return 'You\'re sleeping $excessMinutes minutes more than optimal. A regular wake time will increase energy levels.';
  }

  @override
  String get adviceReduceSnoozeTitle => 'Stop Snoozing';

  @override
  String adviceReduceSnoozeDesc(String avgSnooze) {
    return 'You\'re snoozing an average of $avgSnooze times per night. Fragmented sleep reduces sleep quality.';
  }

  @override
  String get adviceReduceWakeupsTitle => 'Frequent Night Waking';

  @override
  String adviceReduceWakeupsDesc(String avgWakeCount) {
    return 'You\'re waking up $avgWakeCount times per night on average. Limit screen time and caffeine before bed.';
  }

  @override
  String get adviceImproveEfficiencyTitle => 'Low Sleep Efficiency';

  @override
  String adviceImproveEfficiencyDesc(int avgEfficiency) {
    return 'Your sleep efficiency is $avgEfficiency%. Avoiding screen use before bed can help.';
  }

  @override
  String get adviceInconsistentBedtimeTitle => 'Irregular Sleep Schedule';

  @override
  String adviceInconsistentBedtimeDesc(int varianceMinutes) {
    return 'Your bedtime varies by $varianceMinutes minutes. Consistent sleep times support your circadian rhythm.';
  }

  @override
  String get adviceSocialJetLagTitle => 'Social Jet Lag Warning';

  @override
  String adviceSocialJetLagDesc(int diffMinutes) {
    return 'There\'s a $diffMinutes-minute difference between your weekday and weekend bedtimes. This disrupts your circadian rhythm.';
  }

  @override
  String get adviceSleepDebtTitle => 'Sleep Debt Building';

  @override
  String adviceSleepDebtDesc(String debtHours) {
    return 'You\'ve accumulated $debtHours hours of sleep debt in the last 7 days. Try going to bed earlier.';
  }

  @override
  String get adviceGreatStreakTitle => 'Amazing Streak! 🏆';

  @override
  String adviceGreatStreakDesc(int streak) {
    return 'You\'ve met your sleep goal for $streak consecutive nights. Keep it up!';
  }

  @override
  String get adviceGoalAchievedTitle => 'Goal Achieved! ✅';

  @override
  String get adviceGoalAchievedDesc =>
      'You hit your sleep goal last night. Great job!';

  @override
  String get advicePersonalBestTitle => 'Personal Best! 🌟';

  @override
  String get advicePersonalBestDesc =>
      'Last night was your best sleep quality ever. Keep building on this!';

  @override
  String get adviceImprovingTrendTitle => 'Improving Trend! 📈';

  @override
  String adviceImprovingTrendDesc(int oldAvg, int newAvg) {
    return 'Your average score improved from $oldAvg to $newAvg this week. Great progress!';
  }

  @override
  String get saveGoalButton => 'Save Goal';

  @override
  String get durationSliderLabel => 'Sleep Duration';

  @override
  String get bedtimePickerLabel => 'Bedtime';

  @override
  String get wakeTimePickerLabel => 'Wake Time';

  @override
  String get scoreSliderLabel => 'Target Score';

  @override
  String get goalSavedMessage => 'Goal saved!';

  @override
  String get coachEntryButton => 'AI Coach';

  @override
  String completionRateLabel(int rate) {
    return '$rate% success rate';
  }
}
