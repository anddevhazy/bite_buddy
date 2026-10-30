/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// Steps and sleep from Apple Health or Health Connect for one local day,
/// and how much they've already boosted the pet, so a day pays out once.
abstract class ActivityDay
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ActivityDay._({
    this.id,
    required this.ownerId,
    required this.day,
    required this.steps,
    required this.sleepMinutes,
    required this.energyAwarded,
    required this.healthAwarded,
    required this.updatedAt,
  });

  factory ActivityDay({
    int? id,
    required _is.UuidValue ownerId,
    required DateTime day,
    required int steps,
    required int sleepMinutes,
    required int energyAwarded,
    required int healthAwarded,
    required DateTime updatedAt,
  }) = _ActivityDayImpl;

  factory ActivityDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityDay(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      steps: jsonSerialization['steps'] as int,
      sleepMinutes: jsonSerialization['sleepMinutes'] as int,
      energyAwarded: jsonSerialization['energyAwarded'] as int,
      healthAwarded: jsonSerialization['healthAwarded'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ActivityDayTable();

  static const db = ActivityDayRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  /// The owner's local day (UTC midnight).
  DateTime day;

  int steps;

  /// Sleep in the night that ended this morning.
  int sleepMinutes;

  int energyAwarded;

  int healthAwarded;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActivityDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivityDay copyWith({
    int? id,
    _is.UuidValue? ownerId,
    DateTime? day,
    int? steps,
    int? sleepMinutes,
    int? energyAwarded,
    int? healthAwarded,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityDay',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyAwarded': energyAwarded,
      'healthAwarded': healthAwarded,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityDay',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyAwarded': energyAwarded,
      'healthAwarded': healthAwarded,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ActivityDayInclude include() {
    return ActivityDayInclude._();
  }

  static ActivityDayIncludeList includeList({
    _is.WhereExpressionBuilder<ActivityDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    ActivityDayInclude? include,
  }) {
    return ActivityDayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityDayImpl extends ActivityDay {
  _ActivityDayImpl({
    int? id,
    required _is.UuidValue ownerId,
    required DateTime day,
    required int steps,
    required int sleepMinutes,
    required int energyAwarded,
    required int healthAwarded,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         day: day,
         steps: steps,
         sleepMinutes: sleepMinutes,
         energyAwarded: energyAwarded,
         healthAwarded: healthAwarded,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ActivityDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivityDay copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    DateTime? day,
    int? steps,
    int? sleepMinutes,
    int? energyAwarded,
    int? healthAwarded,
    DateTime? updatedAt,
  }) {
    return ActivityDay(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      day: day ?? this.day,
      steps: steps ?? this.steps,
      sleepMinutes: sleepMinutes ?? this.sleepMinutes,
      energyAwarded: energyAwarded ?? this.energyAwarded,
      healthAwarded: healthAwarded ?? this.healthAwarded,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ActivityDayUpdateTable extends _is.UpdateTable<ActivityDayTable> {
  ActivityDayUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> day(DateTime value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<int, int> steps(int value) => _is.ColumnValue(
    table.steps,
    value,
  );

  _is.ColumnValue<int, int> sleepMinutes(int value) => _is.ColumnValue(
    table.sleepMinutes,
    value,
  );

  _is.ColumnValue<int, int> energyAwarded(int value) => _is.ColumnValue(
    table.energyAwarded,
    value,
  );

  _is.ColumnValue<int, int> healthAwarded(int value) => _is.ColumnValue(
    table.healthAwarded,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ActivityDayTable extends _is.Table<int?> {
  ActivityDayTable({super.tableRelation}) : super(tableName: 'activity_day') {
    updateTable = ActivityDayUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    day = _is.ColumnDateTime(
      'day',
      this,
    );
    steps = _is.ColumnInt(
      'steps',
      this,
    );
    sleepMinutes = _is.ColumnInt(
      'sleepMinutes',
      this,
    );
    energyAwarded = _is.ColumnInt(
      'energyAwarded',
      this,
    );
    healthAwarded = _is.ColumnInt(
      'healthAwarded',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ActivityDayUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  /// The owner's local day (UTC midnight).
  late final _is.ColumnDateTime day;

  late final _is.ColumnInt steps;

  /// Sleep in the night that ended this morning.
  late final _is.ColumnInt sleepMinutes;

  late final _is.ColumnInt energyAwarded;

  late final _is.ColumnInt healthAwarded;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    day,
    steps,
    sleepMinutes,
    energyAwarded,
    healthAwarded,
    updatedAt,
  ];
}

class ActivityDayInclude extends _is.IncludeObject {
  ActivityDayInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ActivityDay.t;
}

class ActivityDayIncludeList extends _is.IncludeList {
  ActivityDayIncludeList._({
    _is.WhereExpressionBuilder<ActivityDayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityDay.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ActivityDay.t;
}

class ActivityDayRepository {
  const ActivityDayRepository._();

  /// Returns a list of [ActivityDay]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ActivityDay>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityDayTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ActivityDay>(
      where: where?.call(ActivityDay.t),
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ActivityDay] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ActivityDay?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityDayTable>? where,
    int? offset,
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ActivityDay>(
      where: where?.call(ActivityDay.t),
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ActivityDay] by its [id] or null if no such row exists.
  Future<ActivityDay?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ActivityDay>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ActivityDay]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityDay]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> insert(
    _is.DatabaseSession session,
    List<ActivityDay> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ActivityDay>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ActivityDay] and returns the inserted row.
  ///
  /// The returned [ActivityDay] will have its `id` field set.
  Future<ActivityDay> insertRow(
    _is.DatabaseSession session,
    ActivityDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityDay>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ActivityDay]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ActivityDay]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> upsert(
    _is.DatabaseSession session,
    List<ActivityDay> rows, {
    required _is.ColumnSelections<ActivityDayTable> conflictColumns,
    _is.ColumnSelections<ActivityDayTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityDayTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ActivityDay>(
      rows,
      conflictColumns: conflictColumns(ActivityDay.t),
      updateColumns: updateColumns?.call(ActivityDay.t),
      updateWhere: updateWhere?.call(ActivityDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ActivityDay] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ActivityDay] will have its `id` field set.
  Future<ActivityDay?> upsertRow(
    _is.DatabaseSession session,
    ActivityDay row, {
    required _is.ColumnSelections<ActivityDayTable> conflictColumns,
    _is.ColumnSelections<ActivityDayTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityDayTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ActivityDay>(
      row,
      conflictColumns: conflictColumns(ActivityDay.t),
      updateColumns: updateColumns?.call(ActivityDay.t),
      updateWhere: updateWhere?.call(ActivityDay.t),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityDay]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> update(
    _is.DatabaseSession session,
    List<ActivityDay> rows, {
    _is.ColumnSelections<ActivityDayTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ActivityDay>(
      rows,
      columns: columns?.call(ActivityDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ActivityDay]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityDay> updateRow(
    _is.DatabaseSession session,
    ActivityDay row, {
    _is.ColumnSelections<ActivityDayTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityDay>(
      row,
      columns: columns?.call(ActivityDay.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityDay] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ActivityDay?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ActivityDayUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ActivityDay>(
      id,
      columnValues: columnValues(ActivityDay.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityDay]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ActivityDayUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ActivityDayTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ActivityDay>(
      columnValues: columnValues(ActivityDay.t.updateTable),
      where: where(ActivityDay.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ActivityDay]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> delete(
    _is.DatabaseSession session,
    List<ActivityDay> rows, {
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ActivityDay>(
      rows,
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ActivityDay].
  Future<ActivityDay> deleteRow(
    _is.DatabaseSession session,
    ActivityDay row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityDay>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityDay>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityDayTable> where,
    _is.OrderByBuilder<ActivityDayTable>? orderBy,
    _is.OrderByListBuilder<ActivityDayTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ActivityDay>(
      where: where(ActivityDay.t),
      orderBy: orderBy?.call(ActivityDay.t),
      orderByList: orderByList?.call(ActivityDay.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityDayTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ActivityDay>(
      where: where?.call(ActivityDay.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ActivityDay] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityDayTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ActivityDay>(
      where: where(ActivityDay.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
