import 'package:drift/drift.dart';

import '../../domain/entities/sleep_analysis.dart';
import '../../domain/entities/sleep_record.dart';
import '../../domain/repositories/sleep_repository.dart';
import '../../domain/services/anomaly_detector.dart';
import '../datasources/sleep_database.dart';

/// SleepRepository'nin Drift tabanlı implementasyonu.
class SleepRepositoryImpl implements SleepRepository {
  final SleepDatabase _db;

  const SleepRepositoryImpl(this._db);

  // ── Save ──────────────────────────────────────────────────────────────────

  @override
  Future<void> saveSleepRecord(SleepRecord record) async {
    // Ana kaydı upsert et
    await _db.upsertRecord(
      SleepRecordsTableCompanion(
        id: Value(record.id),
        date: Value(record.date),
        sleepStart: Value(record.sleepStart),
        sleepEnd: Value(record.sleepEnd),
        totalDurationMinutes: Value(record.totalDurationMinutes),
        score: Value(record.score),
        wakeCount: Value(record.wakeCount),
        snoozeCount: Value(record.snoozeCount),
        dismissType: Value(record.dismissType.name),
        createdAt: Value(record.createdAt),
      ),
    );

    // Eski oturumları sil, yenilerini ekle
    await _db.deleteSessionsForRecord(record.id);
    for (final s in record.sessions) {
      await _db.insertSession(
        SleepSessionsTableCompanion(
          recordId: Value(record.id),
          timestamp: Value(s.timestamp),
          type: Value(s.type.name),
        ),
      );
    }
  }

  // ── Queries ──────────────────────────────────────────────────────────────

  @override
  Future<SleepRecord?> getSleepRecordByDate(DateTime date) async {
    final row = await _db.getRecordByDate(date);
    if (row == null) return null;
    return _toEntity(row);
  }

  @override
  Future<List<SleepRecord>> getSleepHistory({int limit = 30}) async {
    final rows = await _db.getRecordsOrdered(limit: limit);
    return Future.wait(rows.map(_toEntity));
  }

  @override
  Future<List<SleepRecord>> getSleepRecordsBetween({
    required DateTime from,
    required DateTime to,
  }) async {
    final rows = await _db.getRecordsBetween(from, to);
    return Future.wait(rows.map(_toEntity));
  }

  // ── Weekly Stats ─────────────────────────────────────────────────────────

  @override
  Future<WeeklySleepStats?> getWeeklyStats(DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final records = await getSleepRecordsBetween(from: weekStart, to: weekEnd);
    if (records.isEmpty) return null;

    final scores = records.map((r) => r.score);
    final durations = records.map((r) => r.totalDurationMinutes);

    double bedtimeSum = 0;
    double wakeTimeSum = 0;
    for (final r in records) {
      bedtimeSum += _minutesFromMidnight(r.sleepStart);
      wakeTimeSum += _minutesFromMidnight(r.sleepEnd);
    }

    return WeeklySleepStats(
      weekStart: weekStart,
      avgScore: scores.reduce((a, b) => a + b) / records.length,
      avgDurationMinutes:
          durations.reduce((a, b) => a + b) / records.length,
      avgBedtimeMinutes: bedtimeSum / records.length,
      avgWakeTimeMinutes: wakeTimeSum / records.length,
      totalRecords: records.length,
      bestScore: scores.reduce((a, b) => a > b ? a : b),
      worstScore: scores.reduce((a, b) => a < b ? a : b),
    );
  }

  // ── Anomalies ─────────────────────────────────────────────────────────────

  @override
  Future<List<SleepAnomaly>> getAnomalies() async {
    final records = await getSleepHistory(limit: 14);
    return AnomalyDetector.detect(records);
  }

  // ── Clear ─────────────────────────────────────────────────────────────────

  @override
  Future<void> clearAll() => _db.clearAll();

  // ── Mappers ──────────────────────────────────────────────────────────────

  Future<SleepRecord> _toEntity(SleepRecordsTableData row) async {
    final sessionRows = await _db.getSessionsForRecord(row.id);
    final sessions = sessionRows
        .map(
          (s) => SleepSession(
            timestamp: s.timestamp,
            type: SleepSessionType.values.firstWhere(
              (e) => e.name == s.type,
              orElse: () => SleepSessionType.screenOn,
            ),
          ),
        )
        .toList();

    return SleepRecord(
      id: row.id,
      date: row.date,
      sleepStart: row.sleepStart,
      sleepEnd: row.sleepEnd,
      totalDurationMinutes: row.totalDurationMinutes,
      score: row.score,
      wakeCount: row.wakeCount,
      snoozeCount: row.snoozeCount,
      dismissType: DismissType.values.firstWhere(
        (e) => e.name == row.dismissType,
        orElse: () => DismissType.unknown,
      ),
      sessions: sessions,
      createdAt: row.createdAt,
    );
  }

  static double _minutesFromMidnight(DateTime dt) {
    final minutes = dt.hour * 60.0 + dt.minute;
    return minutes >= 12 * 60 ? minutes - 24 * 60 : minutes;
  }
}
