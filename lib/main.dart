import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_theme.dart';
import 'core/services/background_service.dart';
import 'core/services/notification_service.dart';
import 'features/alarm/data/models/alarm_model.dart';
import 'features/alarm/domain/entities/alarm.dart';
import 'features/alarm/presentation/bloc/alarm_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'injection_container.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Türkçe ve İngilizce tarih formatlaması için locale verisini başlat
  await initializeDateFormatting('tr_TR', null);
  await initializeDateFormatting('en_US', null);

  // Dependency Injection kurulumu
  await initDependencies();

  // Bildirim servisi başlat
  await sl<NotificationService>().init();

  // Bildirime tıklandığında alarm çalma ekranına yönlendir
  NotificationService.onNotificationTap = (payload) {
    if (payload != null && !isAlarmRingOpen) {
      _navigateToAlarmRing(payload);
    }
  };

  // Arka plan servisini yapılandır
  await initializeBackgroundService();

  runApp(const SmartAlarmApp());
}

/// Alarm ring ekranı açık mı? (çoklu açılmayı önler)
bool isAlarmRingOpen = false;

/// Bildirime tıklanınca alarm ID ile alarm ring ekranına git.
void _navigateToAlarmRing(String alarmId) async {
  if (isAlarmRingOpen) return; // zaten açık
  isAlarmRingOpen = true;

  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final jsonString = prefs.getString(AppConstants.prefAlarms);
    if (jsonString == null || jsonString.isEmpty) {
      isAlarmRingOpen = false;
      return;
    }

    final jsonList = json.decode(jsonString) as List<dynamic>;
    for (final item in jsonList) {
      if (item is Map<String, dynamic> && item['id'] == alarmId) {
        final alarm = AlarmModel.fromJson(item);
        appRouter.push('/alarm-ring', extra: alarm);
        return;
      }
    }

    // Alarm bulunamazsa yine de çalma ekranını aç (basit alarm ile)
    final fallbackAlarm = Alarm(
      id: alarmId,
      scheduledAt: DateTime.now(),
      type: AlarmType.automatic,
      isActive: true,
    );
    appRouter.push('/alarm-ring', extra: fallbackAlarm);
  } catch (e) {
    isAlarmRingOpen = false;
    debugPrint('[Main] Alarm ring navigasyonu hatası: $e');
  }
}

class SmartAlarmApp extends StatelessWidget {
  const SmartAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlarmBloc>(create: (_) => sl<AlarmBloc>()),
        BlocProvider<SettingsBloc>(
          create: (_) => sl<SettingsBloc>()..add(LoadSettings()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Smart Alarm',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: appRouter,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('tr'),
      ),
    );
  }
}
