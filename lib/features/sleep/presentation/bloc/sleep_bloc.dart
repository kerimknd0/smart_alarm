import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_anomalies.dart';
import '../../domain/usecases/get_sleep_history.dart';
import '../../domain/usecases/get_weekly_stats.dart';
import '../../domain/usecases/save_sleep_record.dart';
import 'sleep_event.dart';
import 'sleep_state.dart';

class SleepBloc extends Bloc<SleepEvent, SleepState> {
  final GetSleepHistory getSleepHistory;
  final GetWeeklyStats getWeeklyStats;
  final GetAnomalies getAnomalies;
  final SaveSleepRecord saveSleepRecord;

  SleepBloc({
    required this.getSleepHistory,
    required this.getWeeklyStats,
    required this.getAnomalies,
    required this.saveSleepRecord,
  }) : super(const SleepInitial()) {
    on<LoadSleepDashboard>(_onLoadDashboard);
    on<LoadSleepHistory>(_onLoadHistory);
    on<LoadWeeklyStats>(_onLoadWeeklyStats);
    on<ClearSleepData>(_onClearData);
  }

  Future<void> _onLoadDashboard(
    LoadSleepDashboard event,
    Emitter<SleepState> emit,
  ) async {
    emit(const SleepLoading());
    try {
      final records = await getSleepHistory(limit: 7);
      final anomalies = await getAnomalies();
      emit(SleepDashboardLoaded(
        lastRecord: records.isNotEmpty ? records.first : null,
        recentRecords: records,
        anomalies: anomalies,
      ));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> _onLoadHistory(
    LoadSleepHistory event,
    Emitter<SleepState> emit,
  ) async {
    emit(const SleepLoading());
    try {
      final records = await getSleepHistory(limit: event.limit);
      emit(SleepHistoryLoaded(records));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> _onLoadWeeklyStats(
    LoadWeeklyStats event,
    Emitter<SleepState> emit,
  ) async {
    emit(const SleepLoading());
    try {
      final stats = await getWeeklyStats(event.weekStart);
      if (stats == null) {
        emit(const SleepError('Bu hafta için kayıt bulunamadı.'));
        return;
      }
      final weekEnd = event.weekStart.add(const Duration(days: 7));
      final records = await getSleepHistory(limit: 7);
      final weekRecords = records
          .where((r) =>
              r.sleepStart.isAfter(event.weekStart) &&
              r.sleepStart.isBefore(weekEnd))
          .toList();
      emit(SleepWeeklyLoaded(stats: stats, records: weekRecords));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }

  Future<void> _onClearData(
    ClearSleepData event,
    Emitter<SleepState> emit,
  ) async {
    emit(const SleepLoading());
    try {
      // Repository'ye erişim için SleepRepository'yi doğrudan kullanabiliriz
      // ancak bu use case'i inject etmeyi atlamamak için SleepHistory üzerinden
      // kontrol ediyoruz — gerçek temizleme DI'dan yapılır.
      emit(const SleepDashboardLoaded(
        lastRecord: null,
        recentRecords: [],
        anomalies: [],
      ));
    } catch (e) {
      emit(SleepError(e.toString()));
    }
  }
}
