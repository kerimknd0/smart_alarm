import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/alarm_service.dart';
import 'core/services/notification_service.dart';
import 'features/alarm/data/repositories/alarm_repository_impl.dart';
import 'features/alarm/domain/repositories/alarm_repository.dart';
import 'features/alarm/domain/usecases/cancel_alarm.dart';
import 'features/alarm/domain/usecases/get_alarms.dart';
import 'features/alarm/domain/usecases/set_alarm.dart';
import 'features/alarm/domain/usecases/toggle_alarm.dart';
import 'features/alarm/presentation/bloc/alarm_bloc.dart';
import 'features/settings/data/repositories/settings_repository.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/sleep/data/datasources/sleep_database.dart';
import 'features/sleep/data/repositories/sleep_repository_impl.dart';
import 'features/sleep/domain/repositories/sleep_repository.dart';
import 'features/sleep/domain/usecases/get_anomalies.dart';
import 'features/sleep/domain/usecases/get_sleep_history.dart';
import 'features/sleep/domain/usecases/get_weekly_stats.dart';
import 'features/sleep/domain/usecases/save_sleep_record.dart';
import 'features/sleep/presentation/bloc/sleep_bloc.dart';

final sl = GetIt.instance;

/// Dependency Injection kurulumu.
Future<void> initDependencies() async {
  // ── External ──
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // ── Services ──
  sl.registerLazySingleton(() => NotificationService());
  sl.registerLazySingleton(() => AlarmService());

  // ── Alarm ──
  sl.registerLazySingleton<AlarmRepository>(() => AlarmRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SettingsRepository(sl()));
  sl.registerLazySingleton(() => GetAlarms(sl()));
  sl.registerLazySingleton(() => SetAlarm(sl()));
  sl.registerLazySingleton(() => CancelAlarm(sl()));
  sl.registerLazySingleton(() => ToggleAlarm(sl()));

  sl.registerFactory(
    () => AlarmBloc(
      getAlarms: sl(),
      setAlarm: sl(),
      cancelAlarm: sl(),
      toggleAlarm: sl(),
      alarmService: sl(),
    ),
  );
  sl.registerFactory(() => SettingsBloc(repository: sl()));

  // ── Sleep Analysis ──
  sl.registerLazySingleton(() => SleepDatabase());
  sl.registerLazySingleton<SleepRepository>(
    () => SleepRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => SaveSleepRecord(sl()));
  sl.registerLazySingleton(() => GetSleepHistory(sl()));
  sl.registerLazySingleton(() => GetWeeklyStats(sl()));
  sl.registerLazySingleton(() => GetAnomalies(sl()));

  sl.registerFactory(
    () => SleepBloc(
      getSleepHistory: sl(),
      getWeeklyStats: sl(),
      getAnomalies: sl(),
      saveSleepRecord: sl(),
    ),
  );
}
