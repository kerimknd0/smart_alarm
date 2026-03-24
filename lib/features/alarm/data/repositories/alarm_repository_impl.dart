import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/alarm.dart';
import '../../domain/repositories/alarm_repository.dart';
import '../models/alarm_model.dart';

/// SharedPreferences tabanlı Alarm repository implementasyonu.
class AlarmRepositoryImpl implements AlarmRepository {
  final SharedPreferences _prefs;

  AlarmRepositoryImpl(this._prefs);

  @override
  Future<List<Alarm>> getAlarms() async {
    // Arka plan isolate'ten yapılan değişiklikleri görmek için reload
    await _prefs.reload();
    final jsonString = _prefs.getString(AppConstants.prefAlarms);
    if (jsonString == null || jsonString.isEmpty) return [];

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => AlarmModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Alarm?> getAlarmById(String id) async {
    final alarms = await getAlarms();
    try {
      return alarms.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveAlarm(Alarm alarm) async {
    final alarms = await getAlarms();
    final model = AlarmModel.fromEntity(alarm);

    // Eğer aynı id varsa güncelle, yoksa ekle
    final index = alarms.indexWhere((a) => a.id == alarm.id);
    if (index >= 0) {
      alarms[index] = model;
    } else {
      alarms.add(model);
    }

    await _saveAlarms(alarms);
  }

  @override
  Future<void> deleteAlarm(String id) async {
    final alarms = await getAlarms();
    alarms.removeWhere((a) => a.id == id);
    await _saveAlarms(alarms);
  }

  @override
  Future<void> deleteAllAlarms() async {
    await _prefs.remove(AppConstants.prefAlarms);
  }

  /// Alarm listesini SharedPreferences'a JSON olarak kaydeder.
  Future<void> _saveAlarms(List<Alarm> alarms) async {
    final models = alarms
        .map((a) => AlarmModel.fromEntity(a).toJson())
        .toList();
    await _prefs.setString(AppConstants.prefAlarms, json.encode(models));
  }
}
