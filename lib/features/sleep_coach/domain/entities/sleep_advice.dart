import 'package:equatable/equatable.dart';

/// Koçun ürettiği bir öneri/tavsiye.
enum AdviceType {
  // Uyku süresi tavsiyeleri
  bedtimeTooLate,
  bedtimeTooEarly,
  sleepDurationShort,
  sleepDurationLong,

  // Kalite tavsiyeleri
  reduceSnoozeDependency,
  reduceNightWakeups,
  improveSleepEfficiency,

  // Rutine dair
  inconsistentBedtime,
  socialJetLagWarning,
  sleepDebtBuilding,

  // Pozitif
  greatStreak,
  goalAchieved,
  personalBest,
  improvingTrend,
}

enum AdvicePriority { high, medium, low }

enum AdviceCategory { duration, quality, consistency, habit, achievement }

class SleepAdvice extends Equatable {
  final AdviceType type;
  final AdvicePriority priority;
  final AdviceCategory category;
  final Map<String, dynamic> params;
  final DateTime generatedAt;

  const SleepAdvice({
    required this.type,
    required this.priority,
    required this.category,
    this.params = const {},
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [type, priority, category, params, generatedAt];
}
