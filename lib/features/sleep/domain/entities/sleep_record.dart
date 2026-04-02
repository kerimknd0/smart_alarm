import 'package:equatable/equatable.dart';

/// Bir geceye ait tüm uyku kaydı.
class SleepRecord extends Equatable {
  final String id;
  final DateTime date; // Gün anahtarı (gece 00:00 UTC'ye normalize edilmiş)
  final DateTime sleepStart; // Uyku başlangıcı
  final DateTime sleepEnd; // Kalkış / alarm dismiss zamanı
  final int totalDurationMinutes; // Toplam uyku süresi (dk)
  final int score; // 0-100 uyku kalitesi skoru
  final int wakeCount; // Gece uyanma (ekran açma) sayısı
  final int snoozeCount; // Snooze sayısı
  final DismissType dismissType; // Alarm nasıl kapatıldı
  final List<SleepSession> sessions; // Ekran on/off oturumları
  final DateTime createdAt;

  const SleepRecord({
    required this.id,
    required this.date,
    required this.sleepStart,
    required this.sleepEnd,
    required this.totalDurationMinutes,
    required this.score,
    required this.wakeCount,
    required this.snoozeCount,
    required this.dismissType,
    required this.sessions,
    required this.createdAt,
  });

  /// Uyku verimliliği: uyku süresi / yatakta geçirilen süre
  double get efficiency {
    final inBedMinutes = sleepEnd.difference(sleepStart).inMinutes;
    if (inBedMinutes <= 0) return 0;
    return (totalDurationMinutes / inBedMinutes).clamp(0.0, 1.0);
  }

  /// Skora göre kalite etiketi
  String get qualityLabel {
    if (score >= 85) return 'Mükemmel';
    if (score >= 70) return 'İyi';
    if (score >= 50) return 'Orta';
    if (score >= 30) return 'Zayıf';
    return 'Çok Zayıf';
  }

  @override
  List<Object?> get props => [
        id,
        date,
        sleepStart,
        sleepEnd,
        totalDurationMinutes,
        score,
        wakeCount,
        snoozeCount,
        dismissType,
        sessions,
        createdAt,
      ];
}

/// Alarmın nasıl kapatıldığı.
enum DismissType {
  /// Normal dismiss (ilk çalmada kapatıldı)
  normal,

  /// Snooze sonrası kapatıldı
  afterSnooze,

  /// Akıllı alarm (REM penceresi) tetikledi
  smart,

  /// Bilinmiyor / sistem kaydı
  unknown,
}

/// Bir gece içindeki tek bir ekran açma/kapama oturumu.
class SleepSession extends Equatable {
  final DateTime timestamp;
  final SleepSessionType type;

  const SleepSession({required this.timestamp, required this.type});

  @override
  List<Object?> get props => [timestamp, type];
}

enum SleepSessionType { screenOn, screenOff }
