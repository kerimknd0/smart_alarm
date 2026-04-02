import '../entities/sleep_analysis.dart';

/// REM döngüsü tahmin motoru.
///
/// Bilimsel temel:
///  - İlk REM uykuya daldıktan ~90 dk sonra başlar.
///  - Her döngü ~90-110 dk (ortalama 100 dk).
///  - REM fazı her döngüde uzar: ilk ~10 dk, son ~20-25 dk.
///  - Hafif uyku (N1/N2) REM öncesi ve sonrasında görülür.
///
/// Bu tahmin, uyku başlangıcından itibaren döngüleri hesaplar.
/// Gerçek bir akselerömetre olmadığı için bu teorik bir tahmintir;
/// ekran açma verileriyle birleştirerek iyileştirilir.
class RemCycleEstimator {
  const RemCycleEstimator._();

  /// Ortalama döngü süresi (dakika).
  static const int _cycleDurationMinutes = 100;

  /// İlk REM'e kadar geçen süre (dakika).
  static const int _firstRemOffsetMinutes = 90;

  /// REM faz süresi — döngü numarasına göre artar (dakika).
  static int _remDuration(int cycleNumber) {
    return switch (cycleNumber) {
      1 => 10,
      2 => 15,
      3 => 20,
      _ => 25, // 4. ve sonrası
    };
  }

  /// [sleepStart] ve [sleepEnd] arasındaki REM döngülerini hesaplar.
  static List<RemCycleWindow> estimate({
    required DateTime sleepStart,
    required DateTime sleepEnd,
  }) {
    final totalMinutes = sleepEnd.difference(sleepStart).inMinutes;
    if (totalMinutes < 60) return []; // çok kısa uyku, tahmin yapma

    final cycles = <RemCycleWindow>[];
    int cycleNumber = 1;
    int offsetMinutes = _firstRemOffsetMinutes;

    while (offsetMinutes < totalMinutes) {
      final remStart = sleepStart.add(Duration(minutes: offsetMinutes));
      final remDur = _remDuration(cycleNumber);
      final remEnd = remStart.add(Duration(minutes: remDur));

      // Uyku bitiş zamanını aşmasın
      if (remEnd.isAfter(sleepEnd)) break;

      cycles.add(RemCycleWindow(
        start: remStart,
        end: remEnd,
        cycleNumber: cycleNumber,
      ));

      cycleNumber++;
      offsetMinutes += _cycleDurationMinutes;
    }

    return cycles;
  }

  /// [alarmTime]'dan [windowMinutes] dk öncesine kadar olan en uygun
  /// hafif uyku penceresini döndürür.
  /// Hiçbir pencere bulunamazsa null döndürür.
  static RemCycleWindow? bestWakeWindow({
    required List<RemCycleWindow> cycles,
    required DateTime alarmTime,
    int windowMinutes = 30,
  }) {
    final windowStart = alarmTime.subtract(Duration(minutes: windowMinutes));

    // Alarm öncesi pencereye giren REM fazlarını bul (en yakın olanı seç)
    RemCycleWindow? best;
    Duration? bestDiff;

    for (final cycle in cycles) {
      // REM bitişi (hafif uykuya geçiş anı) alarm penceresinde mi?
      if (cycle.end.isAfter(windowStart) && cycle.end.isBefore(alarmTime)) {
        final diff = alarmTime.difference(cycle.end);
        if (bestDiff == null || diff < bestDiff) {
          bestDiff = diff;
          best = cycle;
        }
      }
    }

    return best;
  }
}
