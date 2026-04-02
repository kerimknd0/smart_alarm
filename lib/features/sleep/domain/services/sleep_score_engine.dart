import '../entities/sleep_record.dart';

/// Uyku kalitesi skoru hesaplama motoru (0–100).
///
/// Bileşenler:
///  - Süre skoru       → 30 puan max
///  - Hareket skoru    → 25 puan max
///  - Tutarlılık skoru → 20 puan max  (önceki kayıtlarla karşılaştırma gerekir)
///  - Verimlilik skoru → 15 puan max
///  - Alarm tepkisi    → 10 puan max
class SleepScoreEngine {
  const SleepScoreEngine._();

  // ── Süre Skoru (0-30) ──────────────────────────────────────────────────────

  static int durationScore(int totalMinutes) {
    final hours = totalMinutes / 60.0;
    if (hours >= 7.0 && hours <= 9.0) return 30;
    if (hours >= 6.0 && hours < 7.0) return 22;
    if (hours > 9.0 && hours <= 10.0) return 22;
    if (hours >= 5.0 && hours < 6.0) return 13;
    if (hours > 10.0) return 12;
    if (hours >= 4.0 && hours < 5.0) return 5;
    return 0;
  }

  // ── Hareket Skoru (0-25) ───────────────────────────────────────────────────
  // Gece uyanma (ekran açma) sayısına ve zamanlamasına göre.

  static int motionScore({
    required int wakeCount,
    required List<SleepSession> sessions,
    required DateTime sleepStart,
    required DateTime sleepEnd,
  }) {
    if (wakeCount == 0) return 25;
    if (wakeCount == 1) return 20;

    // Gece yarısından sonraki kritik saatlerde (00:00-04:00) uyanma cezası
    int midnightWakes = 0;
    for (final s in sessions) {
      if (s.type == SleepSessionType.screenOn) {
        final h = s.timestamp.hour;
        if (h >= 0 && h < 4) midnightWakes++;
      }
    }

    final base = switch (wakeCount) {
      2 => 16,
      3 => 11,
      4 => 7,
      _ => 3,
    };
    final midnightPenalty = (midnightWakes * 3).clamp(0, 10);
    return (base - midnightPenalty).clamp(0, 25);
  }

  // ── Tutarlılık Skoru (0-20) ────────────────────────────────────────────────
  // Önceki kayıtların yatış/kalkış saatiyle karşılaştırma (dakika cinsinden sapma).

  static int consistencyScore({
    required DateTime currentBedtime,
    required DateTime currentWakeTime,
    required List<SleepRecord> recentRecords, // son 7 gün
  }) {
    if (recentRecords.isEmpty) return 15; // yeterli veri yok → orta puan

    // Ortalama yatış ve kalkış zamanlarını hesapla
    double avgBedMinutes = 0;
    double avgWakeMinutes = 0;
    for (final r in recentRecords) {
      avgBedMinutes += _minutesFromMidnight(r.sleepStart);
      avgWakeMinutes += _minutesFromMidnight(r.sleepEnd);
    }
    avgBedMinutes /= recentRecords.length;
    avgWakeMinutes /= recentRecords.length;

    final bedDiff =
        (_minutesFromMidnight(currentBedtime) - avgBedMinutes).abs();
    final wakeDiff =
        (_minutesFromMidnight(currentWakeTime) - avgWakeMinutes).abs();
    final avgDiff = (bedDiff + wakeDiff) / 2;

    if (avgDiff <= 30) return 20;
    if (avgDiff <= 60) return 16;
    if (avgDiff <= 90) return 11;
    if (avgDiff <= 120) return 6;
    return 0;
  }

  // ── Verimlilik Skoru (0-15) ────────────────────────────────────────────────

  static int efficiencyScore(double efficiency) {
    if (efficiency >= 0.92) return 15;
    if (efficiency >= 0.85) return 12;
    if (efficiency >= 0.75) return 8;
    if (efficiency >= 0.65) return 4;
    return 0;
  }

  // ── Alarm Tepkisi Skoru (0-10) ─────────────────────────────────────────────

  static int alarmScore({
    required DismissType dismissType,
    required int snoozeCount,
  }) {
    if (dismissType == DismissType.smart) return 10; // Akıllı alarm penceresinde
    if (snoozeCount == 0) return 10;
    if (snoozeCount == 1) return 6;
    if (snoozeCount == 2) return 3;
    return 0;
  }

  // ── Toplam Skor ────────────────────────────────────────────────────────────

  static ({
    int total,
    int duration,
    int motion,
    int consistency,
    int efficiency,
    int alarm,
  })
  calculate({
    required int totalDurationMinutes,
    required int wakeCount,
    required List<SleepSession> sessions,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    required DismissType dismissType,
    required int snoozeCount,
    required List<SleepRecord> recentRecords,
  }) {
    final d = durationScore(totalDurationMinutes);
    final m = motionScore(
      wakeCount: wakeCount,
      sessions: sessions,
      sleepStart: sleepStart,
      sleepEnd: sleepEnd,
    );
    final c = consistencyScore(
      currentBedtime: sleepStart,
      currentWakeTime: sleepEnd,
      recentRecords: recentRecords,
    );
    final eff = efficiencyScore(
      sleepEnd.difference(sleepStart).inMinutes > 0
          ? totalDurationMinutes /
              sleepEnd.difference(sleepStart).inMinutes.toDouble()
          : 0,
    );
    final a = alarmScore(dismissType: dismissType, snoozeCount: snoozeCount);

    return (
      total: (d + m + c + eff + a).clamp(0, 100),
      duration: d,
      motion: m,
      consistency: c,
      efficiency: eff,
      alarm: a,
    );
  }

  // ── Yardımcı ──────────────────────────────────────────────────────────────

  /// Gece yarısından itibaren dakika (22:30 → -90, 01:00 → 60).
  static double _minutesFromMidnight(DateTime dt) {
    final minutes = dt.hour * 60.0 + dt.minute;
    // Gece geçişi: 22:00+ → negatif yaparak sıralama kolaylaştır
    return minutes >= 12 * 60 ? minutes - 24 * 60 : minutes;
  }
}
