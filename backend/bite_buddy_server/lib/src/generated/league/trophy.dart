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

/// Awarded to a league's weekly winner, shown on their profile.
abstract class Trophy implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Trophy._({
    this.id,
    required this.userId,
    required this.leagueId,
    required this.leagueName,
    required this.weekStart,
    required this.score,
    required this.createdAt,
  });

  factory Trophy({
    int? id,
    required _is.UuidValue userId,
    required int leagueId,
    required String leagueName,
    required DateTime weekStart,
    required int score,
    required DateTime createdAt,
  }) = _TrophyImpl;

  factory Trophy.fromJson(Map<String, dynamic> jsonSerialization) {
    return Trophy(
      id: jsonSerialization['id'] as int?,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      leagueId: jsonSerialization['leagueId'] as int,
      leagueName: jsonSerialization['leagueName'] as String,
      weekStart: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      score: jsonSerialization['score'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = TrophyTable();

  static const db = TrophyRepository._();

  @override
  int? id;

  _is.UuidValue userId;

  int leagueId;

  String leagueName;

  DateTime weekStart;

  int score;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Trophy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Trophy copyWith({
    int? id,
    _is.UuidValue? userId,
    int? leagueId,
    String? leagueName,
    DateTime? weekStart,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Trophy',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'leagueId': leagueId,
      'leagueName': leagueName,
      'weekStart': weekStart.toJson(),
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Trophy',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'leagueId': leagueId,
      'leagueName': leagueName,
      'weekStart': weekStart.toJson(),
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  static TrophyInclude include() {
    return TrophyInclude._();
  }

  static TrophyIncludeList includeList({
    _is.WhereExpressionBuilder<TrophyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    TrophyInclude? include,
  }) {
    return TrophyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrophyImpl extends Trophy {
  _TrophyImpl({
    int? id,
    required _is.UuidValue userId,
    required int leagueId,
    required String leagueName,
    required DateTime weekStart,
    required int score,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         leagueId: leagueId,
         leagueName: leagueName,
         weekStart: weekStart,
         score: score,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Trophy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Trophy copyWith({
    Object? id = _Undefined,
    _is.UuidValue? userId,
    int? leagueId,
    String? leagueName,
    DateTime? weekStart,
    int? score,
    DateTime? createdAt,
  }) {
    return Trophy(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      leagueId: leagueId ?? this.leagueId,
      leagueName: leagueName ?? this.leagueName,
      weekStart: weekStart ?? this.weekStart,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TrophyUpdateTable extends _is.UpdateTable<TrophyTable> {
  TrophyUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<int, int> leagueId(int value) => _is.ColumnValue(
    table.leagueId,
    value,
  );

  _is.ColumnValue<String, String> leagueName(String value) => _is.ColumnValue(
    table.leagueName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> weekStart(DateTime value) =>
      _is.ColumnValue(
        table.weekStart,
        value,
      );

  _is.ColumnValue<int, int> score(int value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class TrophyTable extends _is.Table<int?> {
  TrophyTable({super.tableRelation}) : super(tableName: 'trophy') {
    updateTable = TrophyUpdateTable(this);
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    leagueId = _is.ColumnInt(
      'leagueId',
      this,
    );
    leagueName = _is.ColumnString(
      'leagueName',
      this,
    );
    weekStart = _is.ColumnDateTime(
      'weekStart',
      this,
    );
    score = _is.ColumnInt(
      'score',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final TrophyUpdateTable updateTable;

  late final _is.ColumnUuid userId;

  late final _is.ColumnInt leagueId;

  late final _is.ColumnString leagueName;

  late final _is.ColumnDateTime weekStart;

  late final _is.ColumnInt score;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    leagueId,
    leagueName,
    weekStart,
    score,
    createdAt,
  ];
}

class TrophyInclude extends _is.IncludeObject {
  TrophyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Trophy.t;
}

class TrophyIncludeList extends _is.IncludeList {
  TrophyIncludeList._({
    _is.WhereExpressionBuilder<TrophyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Trophy.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Trophy.t;
}

class TrophyRepository {
  const TrophyRepository._();

  /// Returns a list of [Trophy]s matching the given query parameters.
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
  Future<List<Trophy>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrophyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Trophy>(
      where: where?.call(Trophy.t),
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Trophy] matching the given query parameters.
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
  Future<Trophy?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrophyTable>? where,
    int? offset,
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Trophy>(
      where: where?.call(Trophy.t),
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Trophy] by its [id] or null if no such row exists.
  Future<Trophy?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Trophy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Trophy]s in the list and returns the inserted rows.
  ///
  /// The returned [Trophy]s will have their `id` fields set.
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
  Future<List<Trophy>> insert(
    _is.DatabaseSession session,
    List<Trophy> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Trophy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Trophy] and returns the inserted row.
  ///
  /// The returned [Trophy] will have its `id` field set.
  Future<Trophy> insertRow(
    _is.DatabaseSession session,
    Trophy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Trophy>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Trophy]s in the list and returns the resulting rows.
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
  /// The returned [Trophy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Trophy>> upsert(
    _is.DatabaseSession session,
    List<Trophy> rows, {
    required _is.ColumnSelections<TrophyTable> conflictColumns,
    _is.ColumnSelections<TrophyTable>? updateColumns,
    _is.WhereExpressionBuilder<TrophyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Trophy>(
      rows,
      conflictColumns: conflictColumns(Trophy.t),
      updateColumns: updateColumns?.call(Trophy.t),
      updateWhere: updateWhere?.call(Trophy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Trophy] and returns the resulting row.
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
  /// The returned [Trophy] will have its `id` field set.
  Future<Trophy?> upsertRow(
    _is.DatabaseSession session,
    Trophy row, {
    required _is.ColumnSelections<TrophyTable> conflictColumns,
    _is.ColumnSelections<TrophyTable>? updateColumns,
    _is.WhereExpressionBuilder<TrophyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Trophy>(
      row,
      conflictColumns: conflictColumns(Trophy.t),
      updateColumns: updateColumns?.call(Trophy.t),
      updateWhere: updateWhere?.call(Trophy.t),
      transaction: transaction,
    );
  }

  /// Updates all [Trophy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Trophy>> update(
    _is.DatabaseSession session,
    List<Trophy> rows, {
    _is.ColumnSelections<TrophyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Trophy>(
      rows,
      columns: columns?.call(Trophy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Trophy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Trophy> updateRow(
    _is.DatabaseSession session,
    Trophy row, {
    _is.ColumnSelections<TrophyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Trophy>(
      row,
      columns: columns?.call(Trophy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Trophy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Trophy?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TrophyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Trophy>(
      id,
      columnValues: columnValues(Trophy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Trophy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Trophy>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TrophyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TrophyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Trophy>(
      columnValues: columnValues(Trophy.t.updateTable),
      where: where(Trophy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Trophy]s in the list and returns the deleted rows.
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
  Future<List<Trophy>> delete(
    _is.DatabaseSession session,
    List<Trophy> rows, {
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Trophy>(
      rows,
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Trophy].
  Future<Trophy> deleteRow(
    _is.DatabaseSession session,
    Trophy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Trophy>(
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
  Future<List<Trophy>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrophyTable> where,
    _is.OrderByBuilder<TrophyTable>? orderBy,
    _is.OrderByListBuilder<TrophyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Trophy>(
      where: where(Trophy.t),
      orderBy: orderBy?.call(Trophy.t),
      orderByList: orderByList?.call(Trophy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TrophyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Trophy>(
      where: where?.call(Trophy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Trophy] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TrophyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Trophy>(
      where: where(Trophy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
