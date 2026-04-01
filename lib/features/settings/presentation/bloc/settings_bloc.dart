import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/background_service.dart';
import '../../data/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// Ayarlar iş mantığı bileşeni.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({required SettingsRepository repository})
    : _repository = repository,
      super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateWaitSeconds>(_onUpdateWaitSeconds);
    on<UpdateSleepMinutes>(_onUpdateSleepMinutes);
    on<UpdateSnoozeMinutes>(_onUpdateSnoozeMinutes);
    on<ToggleAutoDetection>(_onToggleAutoDetection);
    on<ToggleScreenModeDetection>(_onToggleScreenModeDetection);
    on<UpdateAlarmSound>(_onUpdateAlarmSound);
    on<UpdateAutoAlarmTimeRange>(_onUpdateAutoAlarmTimeRange);
    on<UpdateLanguage>(_onUpdateLanguage);
    on<UpdateThemeMode>(_onUpdateThemeMode);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    emit(
      SettingsState(
        waitSeconds: _repository.getWaitSeconds(),
        sleepMinutes: _repository.getSleepMinutes(),
        snoozeMinutes: _repository.getSnoozeMinutes(),
        autoDetection: _repository.getAutoDetection(),
        screenModeDetection: _repository.getScreenModeDetection(),
        alarmSound: _repository.getAlarmSound(),
        alarmSoundTitle: _repository.getAlarmSoundTitle(),
        autoAlarmStartHour: _repository.getAutoAlarmStartHour(),
        autoAlarmStartMinute: _repository.getAutoAlarmStartMinute(),
        autoAlarmEndHour: _repository.getAutoAlarmEndHour(),
        autoAlarmEndMinute: _repository.getAutoAlarmEndMinute(),
        languageCode: _repository.getLanguage(),
        themeMode: _repository.getThemeMode(),
      ),
    );
  }

  Future<void> _onUpdateWaitSeconds(
    UpdateWaitSeconds event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setWaitSeconds(event.seconds);
    emit(state.copyWith(waitSeconds: event.seconds));
  }

  Future<void> _onUpdateSleepMinutes(
    UpdateSleepMinutes event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setSleepMinutes(event.minutes);
    emit(state.copyWith(sleepMinutes: event.minutes));
  }

  Future<void> _onUpdateSnoozeMinutes(
    UpdateSnoozeMinutes event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setSnoozeMinutes(event.minutes);
    emit(state.copyWith(snoozeMinutes: event.minutes));
  }

  Future<void> _onToggleAutoDetection(
    ToggleAutoDetection event,
    Emitter<SettingsState> emit,
  ) async {
    final newValue = !state.autoDetection;
    await _repository.setAutoDetection(newValue);
    // Algılama açıldığında geri sayımı sıfırla (eski lastInteraction'dan
    // kalan süre nedeniyle anında alarm kurulmasını engelle)
    if (newValue) {
      await resetDetectionTimers();
    }
    emit(state.copyWith(autoDetection: newValue));
  }

  Future<void> _onToggleScreenModeDetection(
    ToggleScreenModeDetection event,
    Emitter<SettingsState> emit,
  ) async {
    final newValue = !state.screenModeDetection;
    await _repository.setScreenModeDetection(newValue);
    await resetDetectionTimers();
    emit(state.copyWith(screenModeDetection: newValue));
  }

  Future<void> _onUpdateAlarmSound(
    UpdateAlarmSound event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setAlarmSound(event.soundUri);
    await _repository.setAlarmSoundTitle(event.soundTitle);
    emit(state.copyWith(
      alarmSound: event.soundUri,
      alarmSoundTitle: event.soundTitle,
    ));
  }

  Future<void> _onUpdateAutoAlarmTimeRange(
    UpdateAutoAlarmTimeRange event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setAutoAlarmStartHour(event.startHour);
    await _repository.setAutoAlarmStartMinute(event.startMinute);
    await _repository.setAutoAlarmEndHour(event.endHour);
    await _repository.setAutoAlarmEndMinute(event.endMinute);
    emit(state.copyWith(
      autoAlarmStartHour: event.startHour,
      autoAlarmStartMinute: event.startMinute,
      autoAlarmEndHour: event.endHour,
      autoAlarmEndMinute: event.endMinute,
    ));
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setLanguage(event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }

  Future<void> _onUpdateThemeMode(
    UpdateThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
