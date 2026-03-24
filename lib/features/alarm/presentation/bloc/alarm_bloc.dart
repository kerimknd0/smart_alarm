import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/alarm_service.dart';
import '../../domain/entities/alarm.dart';
import '../../domain/usecases/cancel_alarm.dart';
import '../../domain/usecases/get_alarms.dart';
import '../../domain/usecases/set_alarm.dart';
import '../../domain/usecases/toggle_alarm.dart';
import 'alarm_event.dart';
import 'alarm_state.dart';

/// Alarm iş mantığı bileşeni.
class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final GetAlarms _getAlarms;
  final SetAlarm _setAlarm;
  final CancelAlarm _cancelAlarm;
  final ToggleAlarm _toggleAlarm;
  final AlarmService _alarmService;

  AlarmBloc({
    required GetAlarms getAlarms,
    required SetAlarm setAlarm,
    required CancelAlarm cancelAlarm,
    required ToggleAlarm toggleAlarm,
    required AlarmService alarmService,
  }) : _getAlarms = getAlarms,
       _setAlarm = setAlarm,
       _cancelAlarm = cancelAlarm,
       _toggleAlarm = toggleAlarm,
       _alarmService = alarmService,
       super(AlarmInitial()) {
    on<LoadAlarms>(_onLoadAlarms);
    on<AddAlarm>(_onAddAlarm);
    on<UpdateAlarm>(_onUpdateAlarm);
    on<DeleteAlarm>(_onDeleteAlarm);
    on<ToggleAlarmEvent>(_onToggleAlarm);
    on<SnoozeAlarmEvent>(_onSnoozeAlarm);
    on<DismissAlarmEvent>(_onDismissAlarm);
  }

  Future<void> _onLoadAlarms(LoadAlarms event, Emitter<AlarmState> emit) async {
    emit(AlarmLoading());
    try {
      final alarms = await _getAlarms();
      emit(AlarmLoaded(alarms));
    } catch (e) {
      emit(AlarmError('Alarmlar yüklenirken hata oluştu: $e'));
    }
  }

  Future<void> _onAddAlarm(AddAlarm event, Emitter<AlarmState> emit) async {
    try {
      final alarm = Alarm(
        id: _alarmService.generateId(),
        scheduledAt: event.scheduledAt,
        type: event.type,
        snoozeDurationMinutes: event.snoozeDurationMinutes,
      );

      await _setAlarm(alarm);
      await _alarmService.scheduleAlarm(alarm);

      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm eklenirken hata oluştu: $e'));
    }
  }

  Future<void> _onUpdateAlarm(
    UpdateAlarm event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      // Eski bildirimi iptal et, yenisini kur
      await _alarmService.cancelAlarm(event.alarm.id);
      await _setAlarm(event.alarm);

      if (event.alarm.isActive && !event.alarm.isPast) {
        await _alarmService.scheduleAlarm(event.alarm);
      }

      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm güncellenirken hata oluştu: $e'));
    }
  }

  Future<void> _onDeleteAlarm(
    DeleteAlarm event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      await _alarmService.cancelAlarm(event.alarmId);
      await _cancelAlarm(event.alarmId);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm silinirken hata oluştu: $e'));
    }
  }

  Future<void> _onToggleAlarm(
    ToggleAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      // Önce mevcut alarmı al
      final currentState = state;
      if (currentState is AlarmLoaded) {
        final alarm = currentState.alarms.firstWhere(
          (a) => a.id == event.alarmId,
        );

        if (alarm.isActive) {
          // Aktiften pasife → bildirimi iptal et
          await _alarmService.cancelAlarm(event.alarmId);
        } else {
          // Pasiften aktife → bildirimi zamanla
          final updatedAlarm = alarm.copyWith(isActive: true);
          if (!updatedAlarm.isPast) {
            await _alarmService.scheduleAlarm(updatedAlarm);
          }
        }
      }

      await _toggleAlarm(event.alarmId);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm değiştirilirken hata oluştu: $e'));
    }
  }

  Future<void> _onSnoozeAlarm(
    SnoozeAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      final snoozedAlarm = await _alarmService.snoozeAlarm(event.alarm);
      await _setAlarm(snoozedAlarm);
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm ertelenirken hata oluştu: $e'));
    }
  }

  Future<void> _onDismissAlarm(
    DismissAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {
    try {
      await _alarmService.cancelAlarm(event.alarmId);
      // Alarmı pasife çek
      final currentState = state;
      if (currentState is AlarmLoaded) {
        try {
          final alarm = currentState.alarms.firstWhere(
            (a) => a.id == event.alarmId,
          );
          await _setAlarm(alarm.copyWith(isActive: false));
        } catch (_) {
          // Alarm bulunamadı, sorun değil
        }
      }
      add(LoadAlarms());
    } catch (e) {
      emit(AlarmError('Alarm kapatılırken hata oluştu: $e'));
    }
  }
}
