import 'package:equatable/equatable.dart';

import '../../domain/entities/alarm.dart';

/// Alarm BLoC event'leri.
abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object?> get props => [];
}

/// Alarmları yükle.
class LoadAlarms extends AlarmEvent {}

/// Yeni alarm ekle.
class AddAlarm extends AlarmEvent {
  final DateTime scheduledAt;
  final AlarmType type;
  final int snoozeDurationMinutes;

  const AddAlarm({
    required this.scheduledAt,
    this.type = AlarmType.manual,
    this.snoozeDurationMinutes = 5,
  });

  @override
  List<Object?> get props => [scheduledAt, type, snoozeDurationMinutes];
}

/// Alarmı güncelle.
class UpdateAlarm extends AlarmEvent {
  final Alarm alarm;

  const UpdateAlarm(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

/// Alarmı sil.
class DeleteAlarm extends AlarmEvent {
  final String alarmId;

  const DeleteAlarm(this.alarmId);

  @override
  List<Object?> get props => [alarmId];
}

/// Alarm aktif/pasif toggle.
class ToggleAlarmEvent extends AlarmEvent {
  final String alarmId;

  const ToggleAlarmEvent(this.alarmId);

  @override
  List<Object?> get props => [alarmId];
}

/// Alarmı ertele (snooze).
class SnoozeAlarmEvent extends AlarmEvent {
  final Alarm alarm;

  const SnoozeAlarmEvent(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

/// Alarmı kapat (dismiss).
class DismissAlarmEvent extends AlarmEvent {
  final String alarmId;

  const DismissAlarmEvent(this.alarmId);

  @override
  List<Object?> get props => [alarmId];
}
