// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_database.dart';

// ignore_for_file: type=lint
class $SleepRecordsTableTable extends SleepRecordsTable
    with TableInfo<$SleepRecordsTableTable, SleepRecordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepStartMeta = const VerificationMeta(
    'sleepStart',
  );
  @override
  late final GeneratedColumn<DateTime> sleepStart = GeneratedColumn<DateTime>(
    'sleep_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepEndMeta = const VerificationMeta(
    'sleepEnd',
  );
  @override
  late final GeneratedColumn<DateTime> sleepEnd = GeneratedColumn<DateTime>(
    'sleep_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDurationMinutesMeta =
      const VerificationMeta('totalDurationMinutes');
  @override
  late final GeneratedColumn<int> totalDurationMinutes = GeneratedColumn<int>(
    'total_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeCountMeta = const VerificationMeta(
    'wakeCount',
  );
  @override
  late final GeneratedColumn<int> wakeCount = GeneratedColumn<int>(
    'wake_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snoozeCountMeta = const VerificationMeta(
    'snoozeCount',
  );
  @override
  late final GeneratedColumn<int> snoozeCount = GeneratedColumn<int>(
    'snooze_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dismissTypeMeta = const VerificationMeta(
    'dismissType',
  );
  @override
  late final GeneratedColumn<String> dismissType = GeneratedColumn<String>(
    'dismiss_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    sleepStart,
    sleepEnd,
    totalDurationMinutes,
    score,
    wakeCount,
    snoozeCount,
    dismissType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_records_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepRecordsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('sleep_start')) {
      context.handle(
        _sleepStartMeta,
        sleepStart.isAcceptableOrUnknown(data['sleep_start']!, _sleepStartMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepStartMeta);
    }
    if (data.containsKey('sleep_end')) {
      context.handle(
        _sleepEndMeta,
        sleepEnd.isAcceptableOrUnknown(data['sleep_end']!, _sleepEndMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepEndMeta);
    }
    if (data.containsKey('total_duration_minutes')) {
      context.handle(
        _totalDurationMinutesMeta,
        totalDurationMinutes.isAcceptableOrUnknown(
          data['total_duration_minutes']!,
          _totalDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDurationMinutesMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('wake_count')) {
      context.handle(
        _wakeCountMeta,
        wakeCount.isAcceptableOrUnknown(data['wake_count']!, _wakeCountMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeCountMeta);
    }
    if (data.containsKey('snooze_count')) {
      context.handle(
        _snoozeCountMeta,
        snoozeCount.isAcceptableOrUnknown(
          data['snooze_count']!,
          _snoozeCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snoozeCountMeta);
    }
    if (data.containsKey('dismiss_type')) {
      context.handle(
        _dismissTypeMeta,
        dismissType.isAcceptableOrUnknown(
          data['dismiss_type']!,
          _dismissTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dismissTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepRecordsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecordsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      sleepStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sleep_start'],
      )!,
      sleepEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sleep_end'],
      )!,
      totalDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_duration_minutes'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      wakeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wake_count'],
      )!,
      snoozeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_count'],
      )!,
      dismissType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dismiss_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SleepRecordsTableTable createAlias(String alias) {
    return $SleepRecordsTableTable(attachedDatabase, alias);
  }
}

class SleepRecordsTableData extends DataClass
    implements Insertable<SleepRecordsTableData> {
  final String id;
  final DateTime date;
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final int totalDurationMinutes;
  final int score;
  final int wakeCount;
  final int snoozeCount;
  final String dismissType;
  final DateTime createdAt;
  const SleepRecordsTableData({
    required this.id,
    required this.date,
    required this.sleepStart,
    required this.sleepEnd,
    required this.totalDurationMinutes,
    required this.score,
    required this.wakeCount,
    required this.snoozeCount,
    required this.dismissType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['sleep_start'] = Variable<DateTime>(sleepStart);
    map['sleep_end'] = Variable<DateTime>(sleepEnd);
    map['total_duration_minutes'] = Variable<int>(totalDurationMinutes);
    map['score'] = Variable<int>(score);
    map['wake_count'] = Variable<int>(wakeCount);
    map['snooze_count'] = Variable<int>(snoozeCount);
    map['dismiss_type'] = Variable<String>(dismissType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordsTableCompanion(
      id: Value(id),
      date: Value(date),
      sleepStart: Value(sleepStart),
      sleepEnd: Value(sleepEnd),
      totalDurationMinutes: Value(totalDurationMinutes),
      score: Value(score),
      wakeCount: Value(wakeCount),
      snoozeCount: Value(snoozeCount),
      dismissType: Value(dismissType),
      createdAt: Value(createdAt),
    );
  }

  factory SleepRecordsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecordsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      sleepStart: serializer.fromJson<DateTime>(json['sleepStart']),
      sleepEnd: serializer.fromJson<DateTime>(json['sleepEnd']),
      totalDurationMinutes: serializer.fromJson<int>(
        json['totalDurationMinutes'],
      ),
      score: serializer.fromJson<int>(json['score']),
      wakeCount: serializer.fromJson<int>(json['wakeCount']),
      snoozeCount: serializer.fromJson<int>(json['snoozeCount']),
      dismissType: serializer.fromJson<String>(json['dismissType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'sleepStart': serializer.toJson<DateTime>(sleepStart),
      'sleepEnd': serializer.toJson<DateTime>(sleepEnd),
      'totalDurationMinutes': serializer.toJson<int>(totalDurationMinutes),
      'score': serializer.toJson<int>(score),
      'wakeCount': serializer.toJson<int>(wakeCount),
      'snoozeCount': serializer.toJson<int>(snoozeCount),
      'dismissType': serializer.toJson<String>(dismissType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepRecordsTableData copyWith({
    String? id,
    DateTime? date,
    DateTime? sleepStart,
    DateTime? sleepEnd,
    int? totalDurationMinutes,
    int? score,
    int? wakeCount,
    int? snoozeCount,
    String? dismissType,
    DateTime? createdAt,
  }) => SleepRecordsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    sleepStart: sleepStart ?? this.sleepStart,
    sleepEnd: sleepEnd ?? this.sleepEnd,
    totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
    score: score ?? this.score,
    wakeCount: wakeCount ?? this.wakeCount,
    snoozeCount: snoozeCount ?? this.snoozeCount,
    dismissType: dismissType ?? this.dismissType,
    createdAt: createdAt ?? this.createdAt,
  );
  SleepRecordsTableData copyWithCompanion(SleepRecordsTableCompanion data) {
    return SleepRecordsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      sleepStart: data.sleepStart.present
          ? data.sleepStart.value
          : this.sleepStart,
      sleepEnd: data.sleepEnd.present ? data.sleepEnd.value : this.sleepEnd,
      totalDurationMinutes: data.totalDurationMinutes.present
          ? data.totalDurationMinutes.value
          : this.totalDurationMinutes,
      score: data.score.present ? data.score.value : this.score,
      wakeCount: data.wakeCount.present ? data.wakeCount.value : this.wakeCount,
      snoozeCount: data.snoozeCount.present
          ? data.snoozeCount.value
          : this.snoozeCount,
      dismissType: data.dismissType.present
          ? data.dismissType.value
          : this.dismissType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sleepStart: $sleepStart, ')
          ..write('sleepEnd: $sleepEnd, ')
          ..write('totalDurationMinutes: $totalDurationMinutes, ')
          ..write('score: $score, ')
          ..write('wakeCount: $wakeCount, ')
          ..write('snoozeCount: $snoozeCount, ')
          ..write('dismissType: $dismissType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    sleepStart,
    sleepEnd,
    totalDurationMinutes,
    score,
    wakeCount,
    snoozeCount,
    dismissType,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecordsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.sleepStart == this.sleepStart &&
          other.sleepEnd == this.sleepEnd &&
          other.totalDurationMinutes == this.totalDurationMinutes &&
          other.score == this.score &&
          other.wakeCount == this.wakeCount &&
          other.snoozeCount == this.snoozeCount &&
          other.dismissType == this.dismissType &&
          other.createdAt == this.createdAt);
}

class SleepRecordsTableCompanion
    extends UpdateCompanion<SleepRecordsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<DateTime> sleepStart;
  final Value<DateTime> sleepEnd;
  final Value<int> totalDurationMinutes;
  final Value<int> score;
  final Value<int> wakeCount;
  final Value<int> snoozeCount;
  final Value<String> dismissType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SleepRecordsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.sleepStart = const Value.absent(),
    this.sleepEnd = const Value.absent(),
    this.totalDurationMinutes = const Value.absent(),
    this.score = const Value.absent(),
    this.wakeCount = const Value.absent(),
    this.snoozeCount = const Value.absent(),
    this.dismissType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepRecordsTableCompanion.insert({
    required String id,
    required DateTime date,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    required int totalDurationMinutes,
    required int score,
    required int wakeCount,
    required int snoozeCount,
    required String dismissType,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       sleepStart = Value(sleepStart),
       sleepEnd = Value(sleepEnd),
       totalDurationMinutes = Value(totalDurationMinutes),
       score = Value(score),
       wakeCount = Value(wakeCount),
       snoozeCount = Value(snoozeCount),
       dismissType = Value(dismissType),
       createdAt = Value(createdAt);
  static Insertable<SleepRecordsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<DateTime>? sleepStart,
    Expression<DateTime>? sleepEnd,
    Expression<int>? totalDurationMinutes,
    Expression<int>? score,
    Expression<int>? wakeCount,
    Expression<int>? snoozeCount,
    Expression<String>? dismissType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (sleepStart != null) 'sleep_start': sleepStart,
      if (sleepEnd != null) 'sleep_end': sleepEnd,
      if (totalDurationMinutes != null)
        'total_duration_minutes': totalDurationMinutes,
      if (score != null) 'score': score,
      if (wakeCount != null) 'wake_count': wakeCount,
      if (snoozeCount != null) 'snooze_count': snoozeCount,
      if (dismissType != null) 'dismiss_type': dismissType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepRecordsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<DateTime>? sleepStart,
    Value<DateTime>? sleepEnd,
    Value<int>? totalDurationMinutes,
    Value<int>? score,
    Value<int>? wakeCount,
    Value<int>? snoozeCount,
    Value<String>? dismissType,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SleepRecordsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      sleepStart: sleepStart ?? this.sleepStart,
      sleepEnd: sleepEnd ?? this.sleepEnd,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      score: score ?? this.score,
      wakeCount: wakeCount ?? this.wakeCount,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      dismissType: dismissType ?? this.dismissType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (sleepStart.present) {
      map['sleep_start'] = Variable<DateTime>(sleepStart.value);
    }
    if (sleepEnd.present) {
      map['sleep_end'] = Variable<DateTime>(sleepEnd.value);
    }
    if (totalDurationMinutes.present) {
      map['total_duration_minutes'] = Variable<int>(totalDurationMinutes.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (wakeCount.present) {
      map['wake_count'] = Variable<int>(wakeCount.value);
    }
    if (snoozeCount.present) {
      map['snooze_count'] = Variable<int>(snoozeCount.value);
    }
    if (dismissType.present) {
      map['dismiss_type'] = Variable<String>(dismissType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sleepStart: $sleepStart, ')
          ..write('sleepEnd: $sleepEnd, ')
          ..write('totalDurationMinutes: $totalDurationMinutes, ')
          ..write('score: $score, ')
          ..write('wakeCount: $wakeCount, ')
          ..write('snoozeCount: $snoozeCount, ')
          ..write('dismissType: $dismissType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepSessionsTableTable extends SleepSessionsTable
    with TableInfo<$SleepSessionsTableTable, SleepSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sleep_records_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recordId, timestamp, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepSessionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepSessionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepSessionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $SleepSessionsTableTable createAlias(String alias) {
    return $SleepSessionsTableTable(attachedDatabase, alias);
  }
}

class SleepSessionsTableData extends DataClass
    implements Insertable<SleepSessionsTableData> {
  final int id;
  final String recordId;
  final DateTime timestamp;
  final String type;
  const SleepSessionsTableData({
    required this.id,
    required this.recordId,
    required this.timestamp,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_id'] = Variable<String>(recordId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['type'] = Variable<String>(type);
    return map;
  }

  SleepSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return SleepSessionsTableCompanion(
      id: Value(id),
      recordId: Value(recordId),
      timestamp: Value(timestamp),
      type: Value(type),
    );
  }

  factory SleepSessionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepSessionsTableData(
      id: serializer.fromJson<int>(json['id']),
      recordId: serializer.fromJson<String>(json['recordId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordId': serializer.toJson<String>(recordId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'type': serializer.toJson<String>(type),
    };
  }

  SleepSessionsTableData copyWith({
    int? id,
    String? recordId,
    DateTime? timestamp,
    String? type,
  }) => SleepSessionsTableData(
    id: id ?? this.id,
    recordId: recordId ?? this.recordId,
    timestamp: timestamp ?? this.timestamp,
    type: type ?? this.type,
  );
  SleepSessionsTableData copyWithCompanion(SleepSessionsTableCompanion data) {
    return SleepSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionsTableData(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recordId, timestamp, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepSessionsTableData &&
          other.id == this.id &&
          other.recordId == this.recordId &&
          other.timestamp == this.timestamp &&
          other.type == this.type);
}

class SleepSessionsTableCompanion
    extends UpdateCompanion<SleepSessionsTableData> {
  final Value<int> id;
  final Value<String> recordId;
  final Value<DateTime> timestamp;
  final Value<String> type;
  const SleepSessionsTableCompanion({
    this.id = const Value.absent(),
    this.recordId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.type = const Value.absent(),
  });
  SleepSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String recordId,
    required DateTime timestamp,
    required String type,
  }) : recordId = Value(recordId),
       timestamp = Value(timestamp),
       type = Value(type);
  static Insertable<SleepSessionsTableData> custom({
    Expression<int>? id,
    Expression<String>? recordId,
    Expression<DateTime>? timestamp,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordId != null) 'record_id': recordId,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
    });
  }

  SleepSessionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? recordId,
    Value<DateTime>? timestamp,
    Value<String>? type,
  }) {
    return SleepSessionsTableCompanion(
      id: id ?? this.id,
      recordId: recordId ?? this.recordId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$SleepDatabase extends GeneratedDatabase {
  _$SleepDatabase(QueryExecutor e) : super(e);
  $SleepDatabaseManager get managers => $SleepDatabaseManager(this);
  late final $SleepRecordsTableTable sleepRecordsTable =
      $SleepRecordsTableTable(this);
  late final $SleepSessionsTableTable sleepSessionsTable =
      $SleepSessionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sleepRecordsTable,
    sleepSessionsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sleep_records_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sleep_sessions_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SleepRecordsTableTableCreateCompanionBuilder =
    SleepRecordsTableCompanion Function({
      required String id,
      required DateTime date,
      required DateTime sleepStart,
      required DateTime sleepEnd,
      required int totalDurationMinutes,
      required int score,
      required int wakeCount,
      required int snoozeCount,
      required String dismissType,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SleepRecordsTableTableUpdateCompanionBuilder =
    SleepRecordsTableCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<DateTime> sleepStart,
      Value<DateTime> sleepEnd,
      Value<int> totalDurationMinutes,
      Value<int> score,
      Value<int> wakeCount,
      Value<int> snoozeCount,
      Value<String> dismissType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SleepRecordsTableTableReferences
    extends
        BaseReferences<
          _$SleepDatabase,
          $SleepRecordsTableTable,
          SleepRecordsTableData
        > {
  $$SleepRecordsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SleepSessionsTableTable,
    List<SleepSessionsTableData>
  >
  _sleepSessionsTableRefsTable(_$SleepDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sleepSessionsTable,
        aliasName: $_aliasNameGenerator(
          db.sleepRecordsTable.id,
          db.sleepSessionsTable.recordId,
        ),
      );

  $$SleepSessionsTableTableProcessedTableManager get sleepSessionsTableRefs {
    final manager = $$SleepSessionsTableTableTableManager(
      $_db,
      $_db.sleepSessionsTable,
    ).filter((f) => f.recordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sleepSessionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SleepRecordsTableTableFilterComposer
    extends Composer<_$SleepDatabase, $SleepRecordsTableTable> {
  $$SleepRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sleepEnd => $composableBuilder(
    column: $table.sleepEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDurationMinutes => $composableBuilder(
    column: $table.totalDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wakeCount => $composableBuilder(
    column: $table.wakeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeCount => $composableBuilder(
    column: $table.snoozeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dismissType => $composableBuilder(
    column: $table.dismissType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sleepSessionsTableRefs(
    Expression<bool> Function($$SleepSessionsTableTableFilterComposer f) f,
  ) {
    final $$SleepSessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepSessionsTable,
      getReferencedColumn: (t) => t.recordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SleepRecordsTableTableOrderingComposer
    extends Composer<_$SleepDatabase, $SleepRecordsTableTable> {
  $$SleepRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sleepEnd => $composableBuilder(
    column: $table.sleepEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDurationMinutes => $composableBuilder(
    column: $table.totalDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wakeCount => $composableBuilder(
    column: $table.wakeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeCount => $composableBuilder(
    column: $table.snoozeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dismissType => $composableBuilder(
    column: $table.dismissType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepRecordsTableTableAnnotationComposer
    extends Composer<_$SleepDatabase, $SleepRecordsTableTable> {
  $$SleepRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sleepEnd =>
      $composableBuilder(column: $table.sleepEnd, builder: (column) => column);

  GeneratedColumn<int> get totalDurationMinutes => $composableBuilder(
    column: $table.totalDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get wakeCount =>
      $composableBuilder(column: $table.wakeCount, builder: (column) => column);

  GeneratedColumn<int> get snoozeCount => $composableBuilder(
    column: $table.snoozeCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dismissType => $composableBuilder(
    column: $table.dismissType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> sleepSessionsTableRefs<T extends Object>(
    Expression<T> Function($$SleepSessionsTableTableAnnotationComposer a) f,
  ) {
    final $$SleepSessionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sleepSessionsTable,
          getReferencedColumn: (t) => t.recordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SleepSessionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.sleepSessionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SleepRecordsTableTableTableManager
    extends
        RootTableManager<
          _$SleepDatabase,
          $SleepRecordsTableTable,
          SleepRecordsTableData,
          $$SleepRecordsTableTableFilterComposer,
          $$SleepRecordsTableTableOrderingComposer,
          $$SleepRecordsTableTableAnnotationComposer,
          $$SleepRecordsTableTableCreateCompanionBuilder,
          $$SleepRecordsTableTableUpdateCompanionBuilder,
          (SleepRecordsTableData, $$SleepRecordsTableTableReferences),
          SleepRecordsTableData,
          PrefetchHooks Function({bool sleepSessionsTableRefs})
        > {
  $$SleepRecordsTableTableTableManager(
    _$SleepDatabase db,
    $SleepRecordsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepRecordsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepRecordsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepRecordsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> sleepStart = const Value.absent(),
                Value<DateTime> sleepEnd = const Value.absent(),
                Value<int> totalDurationMinutes = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> wakeCount = const Value.absent(),
                Value<int> snoozeCount = const Value.absent(),
                Value<String> dismissType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsTableCompanion(
                id: id,
                date: date,
                sleepStart: sleepStart,
                sleepEnd: sleepEnd,
                totalDurationMinutes: totalDurationMinutes,
                score: score,
                wakeCount: wakeCount,
                snoozeCount: snoozeCount,
                dismissType: dismissType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required DateTime sleepStart,
                required DateTime sleepEnd,
                required int totalDurationMinutes,
                required int score,
                required int wakeCount,
                required int snoozeCount,
                required String dismissType,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsTableCompanion.insert(
                id: id,
                date: date,
                sleepStart: sleepStart,
                sleepEnd: sleepEnd,
                totalDurationMinutes: totalDurationMinutes,
                score: score,
                wakeCount: wakeCount,
                snoozeCount: snoozeCount,
                dismissType: dismissType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepRecordsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sleepSessionsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sleepSessionsTableRefs) db.sleepSessionsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sleepSessionsTableRefs)
                    await $_getPrefetchedData<
                      SleepRecordsTableData,
                      $SleepRecordsTableTable,
                      SleepSessionsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$SleepRecordsTableTableReferences
                          ._sleepSessionsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SleepRecordsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).sleepSessionsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.recordId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SleepRecordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$SleepDatabase,
      $SleepRecordsTableTable,
      SleepRecordsTableData,
      $$SleepRecordsTableTableFilterComposer,
      $$SleepRecordsTableTableOrderingComposer,
      $$SleepRecordsTableTableAnnotationComposer,
      $$SleepRecordsTableTableCreateCompanionBuilder,
      $$SleepRecordsTableTableUpdateCompanionBuilder,
      (SleepRecordsTableData, $$SleepRecordsTableTableReferences),
      SleepRecordsTableData,
      PrefetchHooks Function({bool sleepSessionsTableRefs})
    >;
typedef $$SleepSessionsTableTableCreateCompanionBuilder =
    SleepSessionsTableCompanion Function({
      Value<int> id,
      required String recordId,
      required DateTime timestamp,
      required String type,
    });
typedef $$SleepSessionsTableTableUpdateCompanionBuilder =
    SleepSessionsTableCompanion Function({
      Value<int> id,
      Value<String> recordId,
      Value<DateTime> timestamp,
      Value<String> type,
    });

final class $$SleepSessionsTableTableReferences
    extends
        BaseReferences<
          _$SleepDatabase,
          $SleepSessionsTableTable,
          SleepSessionsTableData
        > {
  $$SleepSessionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SleepRecordsTableTable _recordIdTable(_$SleepDatabase db) =>
      db.sleepRecordsTable.createAlias(
        $_aliasNameGenerator(
          db.sleepSessionsTable.recordId,
          db.sleepRecordsTable.id,
        ),
      );

  $$SleepRecordsTableTableProcessedTableManager get recordId {
    final $_column = $_itemColumn<String>('record_id')!;

    final manager = $$SleepRecordsTableTableTableManager(
      $_db,
      $_db.sleepRecordsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SleepSessionsTableTableFilterComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTableTable> {
  $$SleepSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  $$SleepRecordsTableTableFilterComposer get recordId {
    final $$SleepRecordsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recordId,
      referencedTable: $db.sleepRecordsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepRecordsTableTableFilterComposer(
            $db: $db,
            $table: $db.sleepRecordsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionsTableTableOrderingComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTableTable> {
  $$SleepSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$SleepRecordsTableTableOrderingComposer get recordId {
    final $$SleepRecordsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recordId,
      referencedTable: $db.sleepRecordsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepRecordsTableTableOrderingComposer(
            $db: $db,
            $table: $db.sleepRecordsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionsTableTableAnnotationComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTableTable> {
  $$SleepSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$SleepRecordsTableTableAnnotationComposer get recordId {
    final $$SleepRecordsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recordId,
          referencedTable: $db.sleepRecordsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SleepRecordsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.sleepRecordsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SleepSessionsTableTableTableManager
    extends
        RootTableManager<
          _$SleepDatabase,
          $SleepSessionsTableTable,
          SleepSessionsTableData,
          $$SleepSessionsTableTableFilterComposer,
          $$SleepSessionsTableTableOrderingComposer,
          $$SleepSessionsTableTableAnnotationComposer,
          $$SleepSessionsTableTableCreateCompanionBuilder,
          $$SleepSessionsTableTableUpdateCompanionBuilder,
          (SleepSessionsTableData, $$SleepSessionsTableTableReferences),
          SleepSessionsTableData,
          PrefetchHooks Function({bool recordId})
        > {
  $$SleepSessionsTableTableTableManager(
    _$SleepDatabase db,
    $SleepSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> type = const Value.absent(),
              }) => SleepSessionsTableCompanion(
                id: id,
                recordId: recordId,
                timestamp: timestamp,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recordId,
                required DateTime timestamp,
                required String type,
              }) => SleepSessionsTableCompanion.insert(
                id: id,
                recordId: recordId,
                timestamp: timestamp,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepSessionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recordId,
                                referencedTable:
                                    $$SleepSessionsTableTableReferences
                                        ._recordIdTable(db),
                                referencedColumn:
                                    $$SleepSessionsTableTableReferences
                                        ._recordIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SleepSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$SleepDatabase,
      $SleepSessionsTableTable,
      SleepSessionsTableData,
      $$SleepSessionsTableTableFilterComposer,
      $$SleepSessionsTableTableOrderingComposer,
      $$SleepSessionsTableTableAnnotationComposer,
      $$SleepSessionsTableTableCreateCompanionBuilder,
      $$SleepSessionsTableTableUpdateCompanionBuilder,
      (SleepSessionsTableData, $$SleepSessionsTableTableReferences),
      SleepSessionsTableData,
      PrefetchHooks Function({bool recordId})
    >;

class $SleepDatabaseManager {
  final _$SleepDatabase _db;
  $SleepDatabaseManager(this._db);
  $$SleepRecordsTableTableTableManager get sleepRecordsTable =>
      $$SleepRecordsTableTableTableManager(_db, _db.sleepRecordsTable);
  $$SleepSessionsTableTableTableManager get sleepSessionsTable =>
      $$SleepSessionsTableTableTableManager(_db, _db.sleepSessionsTable);
}
