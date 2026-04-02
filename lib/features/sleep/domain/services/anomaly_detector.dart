import '../entities/sleep_analysis.dart';
import '../entities/sleep_record.dart';

/// Haftalık uyku verilerine dayanarak anomalileri tespit eder.
class AnomalyDetector {
  const AnomalyDetector._();

  /// [records] son 14 günlük kayıtlar (yeniden eskiye).
  static List<SleepAnomaly> detect(List<SleepRecord> records) {
    if (records.isEmpty) return [];

    final anomalies = <SleepAnomaly>[];
    final now = DateTime.now();

    // ── 1. Ardışık kısa uyku (3+ gece < 5 saat) ──────────────────────────
    int consecutiveShort = 0;
    for (final r in records.take(7)) {
      if (r.totalDurationMinutes < 300) {
        consecutiveShort++;
      } else {
        break;
      }
    }
    if (consecutiveShort >= 3) {
      anomalies.add(SleepAnomaly(
        type: AnomalyType.consecutiveShortSleep,
        severity: AnomalySeverity.critical,
        title: '',
        description: '',
        detectedAt: now,
        params: {'count': consecutiveShort},
      ));
    }

    // ── 2. Skor düşüşü ────────────────────────────────────────────────────
    if (records.length >= 2) {
      final latest = records.first.score;
      final avg7 = records.take(7).map((r) => r.score).reduce((a, b) => a + b) /
          records.take(7).length;
      if (latest < avg7 * 0.6 && avg7 > 30) {
        anomalies.add(SleepAnomaly(
          type: AnomalyType.scoreDrop,
          severity: AnomalySeverity.warning,
          title: '',
          description: '',
          detectedAt: now,
          params: {'score': records.first.score, 'avg': avg7.round()},
        ));
      }
    }

    // ── 3. Sık uyanma (gece 3+ kez ekran açma, 4+ gece) ──────────────────
    int frequentWakingNights = 0;
    for (final r in records.take(7)) {
      if (r.wakeCount >= 3) frequentWakingNights++;
    }
    if (frequentWakingNights >= 4) {
      anomalies.add(SleepAnomaly(
        type: AnomalyType.frequentWaking,
        severity: AnomalySeverity.warning,
        title: '',
        description: '',
        detectedAt: now,
        params: {'count': frequentWakingNights},
      ));
    }

    // ── 4. Sosyal jet lag (hafta sonu uyku 3+ saat fazla) ─────────────────
    final weekdays = records
        .where((r) => r.sleepStart.weekday <= 5)
        .take(5)
        .toList();
    final weekends = records
        .where((r) => r.sleepStart.weekday >= 6)
        .take(4)
        .toList();
    if (weekdays.length >= 2 && weekends.length >= 2) {
      final avgWeekdayMin = weekdays
              .map((r) => r.totalDurationMinutes)
              .reduce((a, b) => a + b) /
          weekdays.length;
      final avgWeekendMin = weekends
              .map((r) => r.totalDurationMinutes)
              .reduce((a, b) => a + b) /
          weekends.length;
      if (avgWeekendMin - avgWeekdayMin > 180) {
        anomalies.add(SleepAnomaly(
          type: AnomalyType.socialJetLag,
          severity: AnomalySeverity.warning,
          title: '',
          description: '',
          detectedAt: now,
          params: {'weekend': (avgWeekendMin / 60).toStringAsFixed(1)},
        ));
      }
    }

    // ── 5. Yatış saatinde kayma (2+ saat fark) ───────────────────────────
    if (records.length >= 3) {
      final bedtimes = records
          .take(7)
          .map((r) => r.sleepStart.hour * 60 + r.sleepStart.minute)
          .toList();
      final minBed = bedtimes.reduce((a, b) => a < b ? a : b);
      final maxBed = bedtimes.reduce((a, b) => a > b ? a : b);
      if ((maxBed - minBed).abs() > 120) {
        anomalies.add(SleepAnomaly(
          type: AnomalyType.bedtimeShift,
          severity: AnomalySeverity.warning,
          title: '',
          description: '',
          detectedAt: now,
        ));
      }
    }

    // ── 6. Aşırı snooze ──────────────────────────────────────────────────
    if (records.isNotEmpty && records.first.snoozeCount >= 3) {
      anomalies.add(SleepAnomaly(
        type: AnomalyType.excessiveSnooze,
        severity: AnomalySeverity.warning,
        title: '',
        description: '',
        detectedAt: now,
        params: {'count': records.first.snoozeCount},
      ));
    }

    // ── 7. Pozitif: 7 günlük üst üste yüksek skor ────────────────────────
    if (records.length >= 7) {
      final allAbove80 = records.take(7).every((r) => r.score >= 80);
      if (allAbove80) {
        anomalies.add(SleepAnomaly(
          type: AnomalyType.streak,
          severity: AnomalySeverity.positive,
          title: '',
          description: '',
          detectedAt: now,
        ));
      }
    }

    // ── 8. Pozitif: Bu hafta geçen haftadan +10 puan ─────────────────────
    if (records.length >= 14) {
      final thisWeek =
          records.take(7).map((r) => r.score).reduce((a, b) => a + b) / 7;
      final lastWeek = records
              .skip(7)
              .take(7)
              .map((r) => r.score)
              .reduce((a, b) => a + b) /
          7;
      if (thisWeek - lastWeek >= 10) {
        anomalies.add(SleepAnomaly(
          type: AnomalyType.improvement,
          severity: AnomalySeverity.positive,
          title: '',
          description: '',
          detectedAt: now,
          params: {'thisWeek': thisWeek.round(), 'lastWeek': lastWeek.round()},
        ));
      }
    }

    return anomalies;
  }
}
