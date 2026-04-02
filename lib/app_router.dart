import 'package:go_router/go_router.dart';

import 'features/alarm/domain/entities/alarm.dart';
import 'features/alarm/presentation/screens/alarm_ring_screen.dart';
import 'features/alarm/presentation/screens/home_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/sleep/presentation/screens/sleep_dashboard_screen.dart';

/// Uygulama route yapılandırması.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/sleep',
      name: 'sleep',
      builder: (context, state) => const SleepDashboardScreen(),
    ),
    GoRoute(
      path: '/alarm-ring',
      name: 'alarm-ring',
      builder: (context, state) {
        final alarm = state.extra as Alarm;
        return AlarmRingScreen(alarm: alarm);
      },
    ),
  ],
);
