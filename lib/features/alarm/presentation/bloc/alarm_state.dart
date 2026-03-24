import 'package:equatable/equatable.dart';

import '../../domain/entities/alarm.dart';

/// Alarm BLoC state'leri.
abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object?> get props => [];
}

/// Başlangıç durumu.
class AlarmInitial extends AlarmState {}

/// Yükleniyor.
class AlarmLoading extends AlarmState {}

/// Alarmlar yüklendi.
class AlarmLoaded extends AlarmState {
  final List<Alarm> alarms;

  const AlarmLoaded(this.alarms);

  /// En yakın aktif alarm.
  Alarm? get nextAlarm {
    final activeAlarms = alarms.where((a) => a.isActive && !a.isPast).toList();
    if (activeAlarms.isEmpty) return null;
    activeAlarms.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return activeAlarms.first;
  }

  @override
  List<Object?> get props => [alarms];
}

/// Hata durumu.
class AlarmError extends AlarmState {
  final String message;

  const AlarmError(this.message);

  @override
  List<Object?> get props => [message];
}
