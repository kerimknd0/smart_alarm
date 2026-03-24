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

final sl = GetIt.instance;

/// Dependency Injection kurulumu.
Future<void> initDependencies() async {
  // ── External ──
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // ── Services ──
  sl.registerLazySingleton(() => NotificationService());
  sl.registerLazySingleton(() => AlarmService());

  // ── Repositories ──
  sl.registerLazySingleton<AlarmRepository>(() => AlarmRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SettingsRepository(sl()));

  // ── Use Cases ──
  sl.registerLazySingleton(() => GetAlarms(sl()));
  sl.registerLazySingleton(() => SetAlarm(sl()));
  sl.registerLazySingleton(() => CancelAlarm(sl()));
  sl.registerLazySingleton(() => ToggleAlarm(sl()));

  // ── BLoCs ──
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
}
