import 'dart:convert';

import '../../domain/entities/alarm.dart';

/// Alarm'ın JSON serialize/deserialize modeli.
class AlarmModel extends Alarm {
  const AlarmModel({
    required super.id,
    required super.scheduledAt,
    super.sleepStart,
    super.type,
    super.isActive,
    super.snoozeDurationMinutes,
    super.soundAsset,
  });

  /// Alarm entity'den AlarmModel oluştur.
  factory AlarmModel.fromEntity(Alarm alarm) {
    return AlarmModel(
      id: alarm.id,
      scheduledAt: alarm.scheduledAt,
      sleepStart: alarm.sleepStart,
      type: alarm.type,
      isActive: alarm.isActive,
      snoozeDurationMinutes: alarm.snoozeDurationMinutes,
      soundAsset: alarm.soundAsset,
    );
  }

  /// JSON Map'ten AlarmModel oluştur.
  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      sleepStart: json['sleepStart'] != null
          ? DateTime.parse(json['sleepStart'] as String)
          : null,
      type: AlarmType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AlarmType.manual,
      ),
      isActive: json['isActive'] as bool? ?? true,
      snoozeDurationMinutes: json['snoozeDurationMinutes'] as int? ?? 5,
      soundAsset: json['soundAsset'] as String? ?? 'default',
    );
  }

  /// JSON string'den AlarmModel oluştur.
  factory AlarmModel.fromJsonString(String jsonString) {
    return AlarmModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);
  }

  /// AlarmModel'i JSON Map'e çevir.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduledAt': scheduledAt.toIso8601String(),
      'sleepStart': sleepStart?.toIso8601String(),
      'type': type.name,
      'isActive': isActive,
      'snoozeDurationMinutes': snoozeDurationMinutes,
      'soundAsset': soundAsset,
    };
  }

  /// AlarmModel'i JSON string'e çevir.
  String toJsonString() => json.encode(toJson());
}
