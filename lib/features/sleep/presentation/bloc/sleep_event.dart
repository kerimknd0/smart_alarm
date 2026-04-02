import 'package:equatable/equatable.dart';

abstract class SleepEvent extends Equatable {
  const SleepEvent();
  @override
  List<Object?> get props => [];
}

/// Dashboard için son kaydı + anomalileri yükle.
class LoadSleepDashboard extends SleepEvent {
  const LoadSleepDashboard();
}

/// Uyku geçmişini yükle.
class LoadSleepHistory extends SleepEvent {
  final int limit;
  const LoadSleepHistory({this.limit = 30});
  @override
  List<Object?> get props => [limit];
}

/// Bu haftanın istatistiklerini yükle.
class LoadWeeklyStats extends SleepEvent {
  final DateTime weekStart;
  const LoadWeeklyStats(this.weekStart);
  @override
  List<Object?> get props => [weekStart];
}

/// Tüm kayıtları sil (debug).
class ClearSleepData extends SleepEvent {
  const ClearSleepData();
}
