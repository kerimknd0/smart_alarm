import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'sleep_database.g.dart';

// ══════════════════════════════════════════════════════════════
// TABLOLAR
// ══════════════════════════════════════════════════════════════

/// Bir geceye ait uyku kaydı.
class SleepRecordsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()(); // Normalize edilmiş gün (00:00 UTC)
  DateTimeColumn get sleepStart => dateTime()();
  DateTimeColumn get sleepEnd => dateTime()();
  IntColumn get totalDurationMinutes => integer()();
  IntColumn get score => integer()();
  IntColumn get wakeCount => integer()();
  IntColumn get snoozeCount => integer()();
  TextColumn get dismissType => text()(); // DismissType.name
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Gece içindeki ekran açma/kapama oturumları.
class SleepSessionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recordId =>
      text().references(SleepRecordsTable, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get type => text()(); // SleepSessionType.name
}

// ══════════════════════════════════════════════════════════════
// VERİTABANI
// ══════════════════════════════════════════════════════════════

@DriftDatabase(tables: [SleepRecordsTable, SleepSessionsTable])
class SleepDatabase extends _$SleepDatabase {
  SleepDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );

  // ── Kayıt CRUD ─────────────────────────────────────────────────────────────

  Future<void> upsertRecord(SleepRecordsTableCompanion record) =>
      into(sleepRecordsTable).insertOnConflictUpdate(record);

  Future<SleepRecordsTableData?> getRecordByDate(DateTime date) {
    final normalized = _normalizeDate(date);
    return (select(sleepRecordsTable)
          ..where((t) => t.date.equals(normalized)))
        .getSingleOrNull();
  }

  Future<List<SleepRecordsTableData>> getRecordsOrdered({int limit = 30}) =>
      (select(sleepRecordsTable)
            ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)])
            ..limit(limit))
          .get();

  Future<List<SleepRecordsTableData>> getRecordsBetween(
    DateTime from,
    DateTime to,
  ) =>
      (select(sleepRecordsTable)
            ..where(
              (t) => t.sleepStart.isBetweenValues(from, to),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.sleepStart)]))
          .get();

  // ── Oturum CRUD ────────────────────────────────────────────────────────────

  Future<void> insertSession(SleepSessionsTableCompanion session) =>
      into(sleepSessionsTable).insert(session);

  Future<List<SleepSessionsTableData>> getSessionsForRecord(
    String recordId,
  ) =>
      (select(sleepSessionsTable)
            ..where((t) => t.recordId.equals(recordId))
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  Future<void> deleteSessionsForRecord(String recordId) =>
      (delete(sleepSessionsTable)
            ..where((t) => t.recordId.equals(recordId)))
          .go();

  // ── Temizlik ───────────────────────────────────────────────────────────────

  Future<void> clearAll() async {
    await delete(sleepSessionsTable).go();
    await delete(sleepRecordsTable).go();
  }

  // ── Yardımcı ──────────────────────────────────────────────────────────────

  static DateTime _normalizeDate(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'smart_alarm_sleep.db'));
    return NativeDatabase.createInBackground(file);
  });
}
