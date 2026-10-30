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

/// A shared streak between two league friends, Duolingo style: a day only
/// counts when both of them feed their buddy. [aUserId] sent the invite.
abstract class StreakBuddy
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StreakBuddy._({
    this.id,
    required this.aUserId,
    required this.bUserId,
    required this.accepted,
    required this.streak,
    required this.bestStreak,
    this.aLastFedDay,
    this.bLastFedDay,
    this.lastStreakDay,
    required this.createdAt,
  });

  factory StreakBuddy({
    int? id,
    required _is.UuidValue aUserId,
    required _is.UuidValue bUserId,
    required bool accepted,
    required int streak,
    required int bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    required DateTime createdAt,
  }) = _StreakBuddyImpl;

  factory StreakBuddy.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreakBuddy(
      id: jsonSerialization['id'] as int?,
      aUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['aUserId'],
      ),
      bUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['bUserId'],
      ),
      accepted: _is.BoolJsonExtension.fromJson(jsonSerialization['accepted']),
      streak: jsonSerialization['streak'] as int,
      bestStreak: jsonSerialization['bestStreak'] as int,
      aLastFedDay: jsonSerialization['aLastFedDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['aLastFedDay'],
            ),
      bLastFedDay: jsonSerialization['bLastFedDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['bLastFedDay'],
            ),
      lastStreakDay: jsonSerialization['lastStreakDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStreakDay'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = StreakBuddyTable();

  static const db = StreakBuddyRepository._();

  @override
  int? id;

  _is.UuidValue aUserId;

  _is.UuidValue bUserId;

  /// False until [bUserId] accepts the invite.
  bool accepted;

  /// Days in a row both friends fed. Missing a whole day resets it to 0.
  int streak;

  int bestStreak;

  /// The last local day (UTC midnight) each friend fed while paired.
  DateTime? aLastFedDay;

  DateTime? bLastFedDay;

  /// The last day that counted for the shared streak.
  DateTime? lastStreakDay;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StreakBuddy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StreakBuddy copyWith({
    int? id,
    _is.UuidValue? aUserId,
    _is.UuidValue? bUserId,
    bool? accepted,
    int? streak,
    int? bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreakBuddy',
      if (id != null) 'id': id,
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'accepted': accepted,
      'streak': streak,
      'bestStreak': bestStreak,
      if (aLastFedDay != null) 'aLastFedDay': aLastFedDay?.toJson(),
      if (bLastFedDay != null) 'bLastFedDay': bLastFedDay?.toJson(),
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreakBuddy',
      if (id != null) 'id': id,
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'accepted': accepted,
      'streak': streak,
      'bestStreak': bestStreak,
      if (aLastFedDay != null) 'aLastFedDay': aLastFedDay?.toJson(),
      if (bLastFedDay != null) 'bLastFedDay': bLastFedDay?.toJson(),
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static StreakBuddyInclude include() {
    return StreakBuddyInclude._();
  }

  static StreakBuddyIncludeList includeList({
    _is.WhereExpressionBuilder<StreakBuddyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    StreakBuddyInclude? include,
  }) {
    return StreakBuddyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreakBuddyImpl extends StreakBuddy {
  _StreakBuddyImpl({
    int? id,
    required _is.UuidValue aUserId,
    required _is.UuidValue bUserId,
    required bool accepted,
    required int streak,
    required int bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    required DateTime createdAt,
  }) : super._(
         id: id,
         aUserId: aUserId,
         bUserId: bUserId,
         accepted: accepted,
         streak: streak,
         bestStreak: bestStreak,
         aLastFedDay: aLastFedDay,
         bLastFedDay: bLastFedDay,
         lastStreakDay: lastStreakDay,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StreakBuddy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StreakBuddy copyWith({
    Object? id = _Undefined,
    _is.UuidValue? aUserId,
    _is.UuidValue? bUserId,
    bool? accepted,
    int? streak,
    int? bestStreak,
    Object? aLastFedDay = _Undefined,
    Object? bLastFedDay = _Undefined,
    Object? lastStreakDay = _Undefined,
    DateTime? createdAt,
  }) {
    return StreakBuddy(
      id: id is int? ? id : this.id,
      aUserId: aUserId ?? this.aUserId,
      bUserId: bUserId ?? this.bUserId,
      accepted: accepted ?? this.accepted,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      aLastFedDay: aLastFedDay is DateTime? ? aLastFedDay : this.aLastFedDay,
      bLastFedDay: bLastFedDay is DateTime? ? bLastFedDay : this.bLastFedDay,
      lastStreakDay: lastStreakDay is DateTime?
          ? lastStreakDay
          : this.lastStreakDay,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StreakBuddyUpdateTable extends _is.UpdateTable<StreakBuddyTable> {
  StreakBuddyUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> aUserId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.aUserId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> bUserId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.bUserId,
        value,
      );

  _is.ColumnValue<bool, bool> accepted(bool value) => _is.ColumnValue(
    table.accepted,
    value,
  );

  _is.ColumnValue<int, int> streak(int value) => _is.ColumnValue(
    table.streak,
    value,
  );

  _is.ColumnValue<int, int> bestStreak(int value) => _is.ColumnValue(
    table.bestStreak,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> aLastFedDay(DateTime? value) =>
      _is.ColumnValue(
        table.aLastFedDay,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> bLastFedDay(DateTime? value) =>
      _is.ColumnValue(
        table.bLastFedDay,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastStreakDay(DateTime? value) =>
      _is.ColumnValue(
        table.lastStreakDay,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class StreakBuddyTable extends _is.Table<int?> {
  StreakBuddyTable({super.tableRelation}) : super(tableName: 'streak_buddy') {
    updateTable = StreakBuddyUpdateTable(this);
    aUserId = _is.ColumnUuid(
      'aUserId',
      this,
    );
    bUserId = _is.ColumnUuid(
      'bUserId',
      this,
    );
    accepted = _is.ColumnBool(
      'accepted',
      this,
    );
    streak = _is.ColumnInt(
      'streak',
      this,
    );
    bestStreak = _is.ColumnInt(
      'bestStreak',
      this,
    );
    aLastFedDay = _is.ColumnDateTime(
      'aLastFedDay',
      this,
    );
    bLastFedDay = _is.ColumnDateTime(
      'bLastFedDay',
      this,
    );
    lastStreakDay = _is.ColumnDateTime(
      'lastStreakDay',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final StreakBuddyUpdateTable updateTable;

  late final _is.ColumnUuid aUserId;

  late final _is.ColumnUuid bUserId;

  /// False until [bUserId] accepts the invite.
  late final _is.ColumnBool accepted;

  /// Days in a row both friends fed. Missing a whole day resets it to 0.
  late final _is.ColumnInt streak;

  late final _is.ColumnInt bestStreak;

  /// The last local day (UTC midnight) each friend fed while paired.
  late final _is.ColumnDateTime aLastFedDay;

  late final _is.ColumnDateTime bLastFedDay;

  /// The last day that counted for the shared streak.
  late final _is.ColumnDateTime lastStreakDay;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    aUserId,
    bUserId,
    accepted,
    streak,
    bestStreak,
    aLastFedDay,
    bLastFedDay,
    lastStreakDay,
    createdAt,
  ];
}

class StreakBuddyInclude extends _is.IncludeObject {
  StreakBuddyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StreakBuddy.t;
}

class StreakBuddyIncludeList extends _is.IncludeList {
  StreakBuddyIncludeList._({
    _is.WhereExpressionBuilder<StreakBuddyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StreakBuddy.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StreakBuddy.t;
}

class StreakBuddyRepository {
  const StreakBuddyRepository._();

  /// Returns a list of [StreakBuddy]s matching the given query parameters.
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
  Future<List<StreakBuddy>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreakBuddyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StreakBuddy>(
      where: where?.call(StreakBuddy.t),
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StreakBuddy] matching the given query parameters.
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
  Future<StreakBuddy?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreakBuddyTable>? where,
    int? offset,
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StreakBuddy>(
      where: where?.call(StreakBuddy.t),
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StreakBuddy] by its [id] or null if no such row exists.
  Future<StreakBuddy?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StreakBuddy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StreakBuddy]s in the list and returns the inserted rows.
  ///
  /// The returned [StreakBuddy]s will have their `id` fields set.
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
  Future<List<StreakBuddy>> insert(
    _is.DatabaseSession session,
    List<StreakBuddy> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StreakBuddy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StreakBuddy] and returns the inserted row.
  ///
  /// The returned [StreakBuddy] will have its `id` field set.
  Future<StreakBuddy> insertRow(
    _is.DatabaseSession session,
    StreakBuddy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StreakBuddy>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StreakBuddy]s in the list and returns the resulting rows.
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
  /// The returned [StreakBuddy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreakBuddy>> upsert(
    _is.DatabaseSession session,
    List<StreakBuddy> rows, {
    required _is.ColumnSelections<StreakBuddyTable> conflictColumns,
    _is.ColumnSelections<StreakBuddyTable>? updateColumns,
    _is.WhereExpressionBuilder<StreakBuddyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StreakBuddy>(
      rows,
      conflictColumns: conflictColumns(StreakBuddy.t),
      updateColumns: updateColumns?.call(StreakBuddy.t),
      updateWhere: updateWhere?.call(StreakBuddy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StreakBuddy] and returns the resulting row.
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
  /// The returned [StreakBuddy] will have its `id` field set.
  Future<StreakBuddy?> upsertRow(
    _is.DatabaseSession session,
    StreakBuddy row, {
    required _is.ColumnSelections<StreakBuddyTable> conflictColumns,
    _is.ColumnSelections<StreakBuddyTable>? updateColumns,
    _is.WhereExpressionBuilder<StreakBuddyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StreakBuddy>(
      row,
      conflictColumns: conflictColumns(StreakBuddy.t),
      updateColumns: updateColumns?.call(StreakBuddy.t),
      updateWhere: updateWhere?.call(StreakBuddy.t),
      transaction: transaction,
    );
  }

  /// Updates all [StreakBuddy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreakBuddy>> update(
    _is.DatabaseSession session,
    List<StreakBuddy> rows, {
    _is.ColumnSelections<StreakBuddyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StreakBuddy>(
      rows,
      columns: columns?.call(StreakBuddy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StreakBuddy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StreakBuddy> updateRow(
    _is.DatabaseSession session,
    StreakBuddy row, {
    _is.ColumnSelections<StreakBuddyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StreakBuddy>(
      row,
      columns: columns?.call(StreakBuddy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StreakBuddy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StreakBuddy?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StreakBuddyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StreakBuddy>(
      id,
      columnValues: columnValues(StreakBuddy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StreakBuddy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreakBuddy>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StreakBuddyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StreakBuddyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StreakBuddy>(
      columnValues: columnValues(StreakBuddy.t.updateTable),
      where: where(StreakBuddy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StreakBuddy]s in the list and returns the deleted rows.
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
  Future<List<StreakBuddy>> delete(
    _is.DatabaseSession session,
    List<StreakBuddy> rows, {
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StreakBuddy>(
      rows,
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StreakBuddy].
  Future<StreakBuddy> deleteRow(
    _is.DatabaseSession session,
    StreakBuddy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StreakBuddy>(
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
  Future<List<StreakBuddy>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StreakBuddyTable> where,
    _is.OrderByBuilder<StreakBuddyTable>? orderBy,
    _is.OrderByListBuilder<StreakBuddyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StreakBuddy>(
      where: where(StreakBuddy.t),
      orderBy: orderBy?.call(StreakBuddy.t),
      orderByList: orderByList?.call(StreakBuddy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreakBuddyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StreakBuddy>(
      where: where?.call(StreakBuddy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StreakBuddy] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StreakBuddyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StreakBuddy>(
      where: where(StreakBuddy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
