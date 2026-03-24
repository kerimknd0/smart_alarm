import 'package:equatable/equatable.dart';

/// Alarm türü.
enum AlarmType { automatic, manual }

/// Alarm domain entity.
class Alarm extends Equatable {
  final String id;
  final DateTime scheduledAt;
  final DateTime? sleepStart;
  final AlarmType type;
  final bool isActive;
  final int snoozeDurationMinutes;
  final String soundAsset;

  const Alarm({
    required this.id,
    required this.scheduledAt,
    this.sleepStart,
    this.type = AlarmType.manual,
    this.isActive = true,
    this.snoozeDurationMinutes = 5,
    this.soundAsset = 'default',
  });

  /// Alarm'ı kopyalar, belirtilen alanları değiştirir.
  Alarm copyWith({
    String? id,
    DateTime? scheduledAt,
    DateTime? sleepStart,
    AlarmType? type,
    bool? isActive,
    int? snoozeDurationMinutes,
    String? soundAsset,
  }) {
    return Alarm(
      id: id ?? this.id,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sleepStart: sleepStart ?? this.sleepStart,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      snoozeDurationMinutes:
          snoozeDurationMinutes ?? this.snoozeDurationMinutes,
      soundAsset: soundAsset ?? this.soundAsset,
    );
  }

  /// Alarmın çalma zamanına ne kadar kaldığı.
  Duration get timeUntilAlarm => scheduledAt.difference(DateTime.now());

  /// Alarm zamanı geçmiş mi?
  bool get isPast => scheduledAt.isBefore(DateTime.now());

  @override
  List<Object?> get props => [
    id,
    scheduledAt,
    sleepStart,
    type,
    isActive,
    snoozeDurationMinutes,
    soundAsset,
  ];
}
