import '../../domain/entities/sleep_advice.dart';
import '../../domain/entities/sleep_goal.dart';
import '../../../sleep/domain/entities/sleep_record.dart';

/// Kişiselleştirilmiş uyku tavsiyeleri üreten AI motoru.
///
/// Kural tabanlı uzman sistemi:
/// - Geçmiş veriler analiz edilir
/// - Hedefe göre gap analizi yapılır
/// - Öncelik sırasına göre tavsiye listesi üretilir
class SleepCoachEngine {
  const SleepCoachEngine._();

  /// [records] son 14 günlük kayıtlar (yeniden eskiye).
  /// [goal] kullanıcının belirlediği hedef.
  static List<SleepAdvice> generateAdvice({
    required List<SleepRecord> records,
    required SleepGoal goal,
  }) {
    if (records.isEmpty) return [];
    final now = DateTime.now();
    final advices = <SleepAdvice>[];

    // Son 7 günlük kayıtlar
    final recent = records.take(7).toList();

    // ── Temel istatistikler ──────────────────────────────────────────────
    final avgDuration = recent
            .map((r) => r.totalDurationMinutes)
            .reduce((a, b) => a + b) /
        recent.length;
    final avgBedtimeMin = recent
            .map((r) => r.sleepStart.hour * 60 + r.sleepStart.minute)
            .reduce((a, b) => a + b) /
        recent.length;
    final avgSnooze = recent
            .map((r) => r.snoozeCount)
            .reduce((a, b) => a + b) /
        recent.length;
    final avgWakeCount =
        recent.map((r) => r.wakeCount).reduce((a, b) => a + b) /
            recent.length;

    // ── 1. Uyku süresi gap analizi ─────────────────────────────────────
    final durationGap = avgDuration - goal.targetDurationMinutes;
    if (durationGap < -45) {
      // 45dk+ eksik uyuyor
      final shortfall = (-durationGap).round();
      final targetBed = goal.targetBedtimeMinutes;
      advices.add(SleepAdvice(
        type: AdviceType.sleepDurationShort,
        priority: shortfall > 90 ? AdvicePriority.high : AdvicePriority.medium,
        category: AdviceCategory.duration,
        params: {
          'shortfallMinutes': shortfall,
          'avgDurationMinutes': avgDuration.round(),
          'targetMinutes': goal.targetDurationMinutes,
          'suggestedBedtime': targetBed != null
              ? _minutesToTimeLabel(targetBed - shortfall)
              : null,
        },
        generatedAt: now,
      ));
    } else if (durationGap > 60) {
      // 1 saat+ fazla uyuyor
      advices.add(SleepAdvice(
        type: AdviceType.sleepDurationLong,
        priority: AdvicePriority.low,
        category: AdviceCategory.duration,
        params: {
          'excessMinutes': durationGap.round(),
          'avgDurationMinutes': avgDuration.round(),
        },
        generatedAt: now,
      ));
    }

    // ── 2. Geç yatış analizi ─────────────────────────────────────────────
    final targetBed = goal.targetBedtimeMinutes;
    if (targetBed != null) {
      // Gece yarısından geç saatleri normalize et (örn: 01:00 = 60, 23:00 = 1380)
      final normalizedAvg = avgBedtimeMin > 720 ? avgBedtimeMin : avgBedtimeMin + 1440;
      final normalizedTarget = targetBed >= 0 ? targetBed : targetBed + 1440;
      final diff = normalizedAvg - normalizedTarget;

      if (diff > 30) {
        // Hedeften 30dk+ geç yatıyor
        advices.add(SleepAdvice(
          type: AdviceType.bedtimeTooLate,
          priority: diff > 90 ? AdvicePriority.high : AdvicePriority.medium,
          category: AdviceCategory.habit,
          params: {
            'avgBedtime': _minutesToTimeLabel(avgBedtimeMin.round()),
            'targetBedtime': _minutesToTimeLabel(targetBed),
            'diffMinutes': diff.round(),
          },
          generatedAt: now,
        ));
      } else if (diff < -30) {
        // Hedeften 30dk+ erken yatıyor
        advices.add(SleepAdvice(
          type: AdviceType.bedtimeTooEarly,
          priority: AdvicePriority.low,
          category: AdviceCategory.habit,
          params: {
            'avgBedtime': _minutesToTimeLabel(avgBedtimeMin.round()),
            'targetBedtime': _minutesToTimeLabel(targetBed),
          },
          generatedAt: now,
        ));
      }
    }

    // ── 3. Snooze bağımlılığı ────────────────────────────────────────────
    if (avgSnooze >= 2.0) {
      advices.add(SleepAdvice(
        type: AdviceType.reduceSnoozeDependency,
        priority: avgSnooze >= 3 ? AdvicePriority.high : AdvicePriority.medium,
        category: AdviceCategory.quality,
        params: {
          'avgSnooze': avgSnooze.toStringAsFixed(1),
          'suggestion':
              avgSnooze >= 3 ? 'moveBedtimeEarlier' : 'eliminateSnooze',
        },
        generatedAt: now,
      ));
    }

    // ── 4. Gece uyanma sorunu ────────────────────────────────────────────
    if (avgWakeCount >= 2.5) {
      advices.add(SleepAdvice(
        type: AdviceType.reduceNightWakeups,
        priority: AdvicePriority.medium,
        category: AdviceCategory.quality,
        params: {
          'avgWakeCount': avgWakeCount.toStringAsFixed(1),
        },
        generatedAt: now,
      ));
    }

    // ── 5. Tutarsız yatış saati ──────────────────────────────────────────
    if (recent.length >= 4) {
      final bedtimes = recent
          .map((r) => r.sleepStart.hour * 60 + r.sleepStart.minute)
          .toList();
      final minBed = bedtimes.reduce((a, b) => a < b ? a : b);
      final maxBed = bedtimes.reduce((a, b) => a > b ? a : b);
      if ((maxBed - minBed).abs() > 90) {
        advices.add(SleepAdvice(
          type: AdviceType.inconsistentBedtime,
          priority: AdvicePriority.medium,
          category: AdviceCategory.consistency,
          params: {
            'varianceMinutes': (maxBed - minBed).abs(),
            'earliestBedtime': _minutesToTimeLabel(minBed),
            'latestBedtime': _minutesToTimeLabel(maxBed),
          },
          generatedAt: now,
        ));
      }
    }

    // ── 6. Uyku borcu ────────────────────────────────────────────────────
    final debtMinutes = _calculateSleepDebt(records, goal.targetDurationMinutes);
    if (debtMinutes >= 120) {
      advices.add(SleepAdvice(
        type: AdviceType.sleepDebtBuilding,
        priority: debtMinutes >= 300 ? AdvicePriority.high : AdvicePriority.medium,
        category: AdviceCategory.duration,
        params: {
          'debtMinutes': debtMinutes,
          'debtHours': (debtMinutes / 60).toStringAsFixed(1),
        },
        generatedAt: now,
      ));
    }

    // ── 7. Sosyal jet lag ────────────────────────────────────────────────
    if (records.length >= 6) {
      final weekdayBeds = records
          .where((r) => r.sleepStart.weekday <= 5)
          .take(5)
          .map((r) => r.sleepStart.hour * 60 + r.sleepStart.minute)
          .toList();
      final weekendBeds = records
          .where((r) => r.sleepStart.weekday >= 6)
          .take(4)
          .map((r) => r.sleepStart.hour * 60 + r.sleepStart.minute)
          .toList();

      if (weekdayBeds.length >= 2 && weekendBeds.length >= 2) {
        final avgWeekday =
            weekdayBeds.reduce((a, b) => a + b) / weekdayBeds.length;
        final avgWeekend =
            weekendBeds.reduce((a, b) => a + b) / weekendBeds.length;
        if ((avgWeekend - avgWeekday).abs() > 90) {
          advices.add(SleepAdvice(
            type: AdviceType.socialJetLagWarning,
            priority: AdvicePriority.medium,
            category: AdviceCategory.consistency,
            params: {
              'weekdayBedtime': _minutesToTimeLabel(avgWeekday.round()),
              'weekendBedtime': _minutesToTimeLabel(avgWeekend.round()),
              'diffMinutes': (avgWeekend - avgWeekday).abs().round(),
            },
            generatedAt: now,
          ));
        }
      }
    }

    // ── 8. Pozitif: Verimlilik sorunu ────────────────────────────────────
    final avgEff =
        recent.map((r) => r.efficiency).reduce((a, b) => a + b) / recent.length;
    if (avgEff < 0.75 && avgDuration > 390) {
      advices.add(SleepAdvice(
        type: AdviceType.improveSleepEfficiency,
        priority: AdvicePriority.low,
        category: AdviceCategory.quality,
        params: {
          'avgEfficiency': (avgEff * 100).round(),
        },
        generatedAt: now,
      ));
    }

    // ── 9. Pozitif tavsiyeler ────────────────────────────────────────────
    // Streak kontrolü
    int streak = 0;
    for (final r in records) {
      if (r.totalDurationMinutes >= goal.targetDurationMinutes - 20 &&
          r.score >= goal.targetScore) {
        streak++;
      } else {
        break;
      }
    }
    if (streak >= 5) {
      advices.add(SleepAdvice(
        type: AdviceType.greatStreak,
        priority: AdvicePriority.low,
        category: AdviceCategory.achievement,
        params: {'streak': streak},
        generatedAt: now,
      ));
    }

    // İyileşen trend
    if (records.length >= 7) {
      final firstHalf = records
              .skip(4)
              .take(3)
              .map((r) => r.score)
              .reduce((a, b) => a + b) /
          3;
      final secondHalf =
          records.take(4).map((r) => r.score).reduce((a, b) => a + b) / 4;
      if (secondHalf - firstHalf >= 8) {
        advices.add(SleepAdvice(
          type: AdviceType.improvingTrend,
          priority: AdvicePriority.low,
          category: AdviceCategory.achievement,
          params: {
            'oldAvg': firstHalf.round(),
            'newAvg': secondHalf.round(),
            'improvement': (secondHalf - firstHalf).round(),
          },
          generatedAt: now,
        ));
      }
    }

    // Öncelik sırasına göre sırala
    advices.sort((a, b) => a.priority.index.compareTo(b.priority.index));

    return advices;
  }

  /// 7 günlük uyku borcunu hesaplar (dakika).
  static int _calculateSleepDebt(
    List<SleepRecord> records,
    int targetMinutes,
  ) {
    int debt = 0;
    for (final r in records.take(7)) {
      final diff = targetMinutes - r.totalDurationMinutes;
      if (diff > 0) debt += diff;
    }
    return debt;
  }

  static String _minutesToTimeLabel(int minutes) {
    final normalized = ((minutes % 1440) + 1440) % 1440;
    final h = normalized ~/ 60;
    final m = normalized % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }
}
