import 'package:equatable/equatable.dart';

import '../../domain/entities/sleep_analysis.dart';
import '../../domain/entities/sleep_record.dart';

abstract class SleepState extends Equatable {
  const SleepState();
  @override
  List<Object?> get props => [];
}

class SleepInitial extends SleepState {
  const SleepInitial();
}

class SleepLoading extends SleepState {
  const SleepLoading();
}

class SleepDashboardLoaded extends SleepState {
  final SleepRecord? lastRecord;
  final List<SleepRecord> recentRecords; // son 7 gün
  final List<SleepAnomaly> anomalies;

  const SleepDashboardLoaded({
    required this.lastRecord,
    required this.recentRecords,
    required this.anomalies,
  });

  @override
  List<Object?> get props => [lastRecord, recentRecords, anomalies];
}

class SleepHistoryLoaded extends SleepState {
  final List<SleepRecord> records;

  const SleepHistoryLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

class SleepWeeklyLoaded extends SleepState {
  final WeeklySleepStats stats;
  final List<SleepRecord> records;

  const SleepWeeklyLoaded({required this.stats, required this.records});

  @override
  List<Object?> get props => [stats, records];
}

class SleepError extends SleepState {
  final String message;
  const SleepError(this.message);

  @override
  List<Object?> get props => [message];
}
