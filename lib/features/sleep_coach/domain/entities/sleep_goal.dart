import 'package:equatable/equatable.dart';

/// Kullanıcının belirlediği uyku hedefi.
class SleepGoal extends Equatable {
  /// Hedef uyku süresi (dakika). Örn: 450 = 7.5 saat
  final int targetDurationMinutes;

  /// Hedef yatış saati (gece yarısından dakika). Örn: -90 = 22:30
  final int? targetBedtimeMinutes;

  /// Hedef kalkış saati (gece yarısından dakika). Örn: 420 = 07:00
  final int? targetWakeMinutes;

  /// Hedef minimum skor (0-100)
  final int targetScore;

  const SleepGoal({
    required this.targetDurationMinutes,
    this.targetBedtimeMinutes,
    this.targetWakeMinutes,
    this.targetScore = 70,
  });

  /// Hedef uyku süresini saat olarak döndürür.
  double get targetHours => targetDurationMinutes / 60.0;

  /// Yatış saatini okunabilir formata çevirir. Örn: "22:30"
  String? get bedtimeLabel {
    final minutes = targetBedtimeMinutes;
    if (minutes == null) return null;
    final normalized = ((minutes % 1440) + 1440) % 1440;
    final h = normalized ~/ 60;
    final m = normalized % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  /// Kalkış saatini okunabilir formata çevirir. Örn: "07:00"
  String? get wakeTimeLabel {
    final minutes = targetWakeMinutes;
    if (minutes == null) return null;
    final normalized = ((minutes % 1440) + 1440) % 1440;
    final h = normalized ~/ 60;
    final m = normalized % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  SleepGoal copyWith({
    int? targetDurationMinutes,
    int? targetBedtimeMinutes,
    int? targetWakeMinutes,
    int? targetScore,
  }) {
    return SleepGoal(
      targetDurationMinutes:
          targetDurationMinutes ?? this.targetDurationMinutes,
      targetBedtimeMinutes: targetBedtimeMinutes ?? this.targetBedtimeMinutes,
      targetWakeMinutes: targetWakeMinutes ?? this.targetWakeMinutes,
      targetScore: targetScore ?? this.targetScore,
    );
  }

  @override
  List<Object?> get props => [
        targetDurationMinutes,
        targetBedtimeMinutes,
        targetWakeMinutes,
        targetScore,
      ];
}

/// Hedef ilerleme özeti.
class GoalProgress extends Equatable {
  final SleepGoal goal;

  /// Son 7 günde hedefe ulaşılan gece sayısı
  final int daysAchieved;

  /// Son 7 günde toplam kayıt
  final int totalDays;

  /// Mevcut streak (üst üste hedef geceler)
  final int currentStreak;

  /// Toplam birikmiş uyku borcu (dakika)
  final int sleepDebtMinutes;

  /// Bu haftaki ortalama skor
  final double avgScoreThisWeek;

  const GoalProgress({
    required this.goal,
    required this.daysAchieved,
    required this.totalDays,
    required this.currentStreak,
    required this.sleepDebtMinutes,
    required this.avgScoreThisWeek,
  });

  double get completionRate =>
      totalDays == 0 ? 0 : daysAchieved / totalDays;

  /// Uyku borcunu saat cinsinden döndürür
  double get sleepDebtHours => sleepDebtMinutes / 60.0;

  @override
  List<Object?> get props => [
        goal,
        daysAchieved,
        totalDays,
        currentStreak,
        sleepDebtMinutes,
        avgScoreThisWeek,
      ];
}
