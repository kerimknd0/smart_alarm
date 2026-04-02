import 'package:equatable/equatable.dart';

import 'sleep_record.dart';

/// Hesaplanmış REM döngüsü penceresi.
class RemCycleWindow extends Equatable {
  final DateTime start; // REM başlangıcı (hafif uyku)
  final DateTime end; // REM bitişi
  final int cycleNumber; // 1-tabanlı döngü numarası

  const RemCycleWindow({
    required this.start,
    required this.end,
    required this.cycleNumber,
  });

  bool contains(DateTime t) => t.isAfter(start) && t.isBefore(end);

  @override
  List<Object?> get props => [start, end, cycleNumber];
}

/// Haftalık uyku özeti.
class WeeklySleepStats extends Equatable {
  final DateTime weekStart;
  final double avgScore;
  final double avgDurationMinutes;
  final double avgBedtimeMinutes; // Gece yarısından itibaren dakika (22:30 → -90)
  final double avgWakeTimeMinutes; // Gece yarısından itibaren dakika
  final int totalRecords;
  final int bestScore;
  final int worstScore;

  const WeeklySleepStats({
    required this.weekStart,
    required this.avgScore,
    required this.avgDurationMinutes,
    required this.avgBedtimeMinutes,
    required this.avgWakeTimeMinutes,
    required this.totalRecords,
    required this.bestScore,
    required this.worstScore,
  });

  String get avgBedtimeLabel {
    final h = (avgBedtimeMinutes ~/ 60 + 24) % 24;
    final m = (avgBedtimeMinutes % 60).abs().round();
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  String get avgWakeTimeLabel {
    final h = (avgWakeTimeMinutes ~/ 60 + 24) % 24;
    final m = (avgWakeTimeMinutes % 60).abs().round();
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [
        weekStart,
        avgScore,
        avgDurationMinutes,
        avgBedtimeMinutes,
        avgWakeTimeMinutes,
        totalRecords,
        bestScore,
        worstScore,
      ];
}

/// Anomali türleri.
enum AnomalyType {
  /// 3+ gece < 5 saat uyku
  consecutiveShortSleep,

  /// Skor, 7 günlük ortalamanın %40 altında
  scoreDrop,

  /// Gece 3+ kez ekran açma (4+ gece)
  frequentWaking,

  /// Hafta sonu uyku 3+ saat fazla (sosyal jet lag)
  socialJetLag,

  /// Yatış saatinde 2+ saat kayma
  bedtimeShift,

  /// Snooze 3+ kez
  excessiveSnooze,

  /// Pozitif: 7 gün üst üste skor > 80
  streak,

  /// Pozitif: bu hafta geçen haftadan +10 puan
  improvement,
}

enum AnomalySeverity { critical, warning, positive }

/// Tek bir anomali uyarısı.
class SleepAnomaly extends Equatable {
  final AnomalyType type;
  final AnomalySeverity severity;
  final String title;
  final String description;
  final DateTime detectedAt;
  /// Localization için sayısal/string parametreler (opsiyonel).
  final Map<String, dynamic> params;

  const SleepAnomaly({
    required this.type,
    required this.severity,
    required this.title,
    required this.description,
    required this.detectedAt,
    this.params = const {},
  });

  @override
  List<Object?> get props => [type, severity, title, description, detectedAt];
}

/// Tek bir geceye ait tam analiz sonucu.
class SleepAnalysis extends Equatable {
  final SleepRecord record;
  final List<RemCycleWindow> remCycles;
  final bool wasSmartWake; // Akıllı alarm penceresinde uyandı mı?
  final int durationScore; // 0-30
  final int motionScore; // 0-25
  final int consistencyScore; // 0-20
  final int efficiencyScore; // 0-15
  final int alarmScore; // 0-10

  const SleepAnalysis({
    required this.record,
    required this.remCycles,
    required this.wasSmartWake,
    required this.durationScore,
    required this.motionScore,
    required this.consistencyScore,
    required this.efficiencyScore,
    required this.alarmScore,
  });

  int get totalScore =>
      durationScore + motionScore + consistencyScore + efficiencyScore + alarmScore;

  /// En uygun akıllı kalkış penceresi (alarm zamanından 30 dk önce).
  RemCycleWindow? bestWakeWindow(DateTime alarmTime) {
    final windowStart = alarmTime.subtract(const Duration(minutes: 30));
    for (final w in remCycles.reversed) {
      if (w.start.isAfter(windowStart) && w.start.isBefore(alarmTime)) {
        return w;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [
        record,
        remCycles,
        wasSmartWake,
        durationScore,
        motionScore,
        consistencyScore,
        efficiencyScore,
        alarmScore,
      ];
}
