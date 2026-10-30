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
import 'package:bite_buddy_server/src/generated/protocol.dart' as _i61ow1lb;
import 'package:serverpod/serverpod.dart' as _is;
import '../league/league_standing.dart' as _iyvw479e;

/// The final standings of one finished weekly season. Its unique index is
/// what stops a season being paid out twice.
abstract class SeasonResult
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SeasonResult._({
    this.id,
    required this.leagueId,
    required this.weekStart,
    this.winnerUserId,
    required this.standings,
    bool? challengeCompleted,
    required this.createdAt,
  }) : challengeCompleted = challengeCompleted ?? false;

  factory SeasonResult({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    _is.UuidValue? winnerUserId,
    required List<_iyvw479e.LeagueStanding> standings,
    bool? challengeCompleted,
    required DateTime createdAt,
  }) = _SeasonResultImpl;

  factory SeasonResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeasonResult(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      weekStart: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      winnerUserId: jsonSerialization['winnerUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['winnerUserId'],
            ),
      standings: _i61ow1lb.Protocol()
          .deserialize<List<_iyvw479e.LeagueStanding>>(
            jsonSerialization['standings'],
          ),
      challengeCompleted: jsonSerialization['challengeCompleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['challengeCompleted'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SeasonResultTable();

  static const db = SeasonResultRepository._();

  @override
  int? id;

  int leagueId;

  /// Monday 00:00 UTC of the season's week.
  DateTime weekStart;

  /// Null when nobody scored or the league had fewer than 2 members.
  _is.UuidValue? winnerUserId;

  List<_iyvw479e.LeagueStanding> standings;

  /// Whether the league met that week's team challenge.
  bool challengeCompleted;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SeasonResult copyWith({
    int? id,
    int? leagueId,
    DateTime? weekStart,
    _is.UuidValue? winnerUserId,
    List<_iyvw479e.LeagueStanding>? standings,
    bool? challengeCompleted,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJson()),
      'challengeCompleted': challengeCompleted,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'challengeCompleted': challengeCompleted,
      'createdAt': createdAt.toJson(),
    };
  }

  static SeasonResultInclude include() {
    return SeasonResultInclude._();
  }

  static SeasonResultIncludeList includeList({
    _is.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    SeasonResultInclude? include,
  }) {
    return SeasonResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonResultImpl extends SeasonResult {
  _SeasonResultImpl({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    _is.UuidValue? winnerUserId,
    required List<_iyvw479e.LeagueStanding> standings,
    bool? challengeCompleted,
    required DateTime createdAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         weekStart: weekStart,
         winnerUserId: winnerUserId,
         standings: standings,
         challengeCompleted: challengeCompleted,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SeasonResult copyWith({
    Object? id = _Undefined,
    int? leagueId,
    DateTime? weekStart,
    Object? winnerUserId = _Undefined,
    List<_iyvw479e.LeagueStanding>? standings,
    bool? challengeCompleted,
    DateTime? createdAt,
  }) {
    return SeasonResult(
      id: id is int? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      weekStart: weekStart ?? this.weekStart,
      winnerUserId: winnerUserId is _is.UuidValue?
          ? winnerUserId
          : this.winnerUserId,
      standings:
          standings ?? this.standings.map((e0) => e0.copyWith()).toList(),
      challengeCompleted: challengeCompleted ?? this.challengeCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SeasonResultUpdateTable extends _is.UpdateTable<SeasonResultTable> {
  SeasonResultUpdateTable(super.table);

  _is.ColumnValue<int, int> leagueId(int value) => _is.ColumnValue(
    table.leagueId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> weekStart(DateTime value) =>
      _is.ColumnValue(
        table.weekStart,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> winnerUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.winnerUserId,
    value,
  );

  _is.ColumnValue<
    List<_iyvw479e.LeagueStanding>,
    List<_iyvw479e.LeagueStanding>
  >
  standings(List<_iyvw479e.LeagueStanding> value) => _is.ColumnValue(
    table.standings,
    value,
  );

  _is.ColumnValue<bool, bool> challengeCompleted(bool value) => _is.ColumnValue(
    table.challengeCompleted,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SeasonResultTable extends _is.Table<int?> {
  SeasonResultTable({super.tableRelation}) : super(tableName: 'season_result') {
    updateTable = SeasonResultUpdateTable(this);
    leagueId = _is.ColumnInt(
      'leagueId',
      this,
    );
    weekStart = _is.ColumnDateTime(
      'weekStart',
      this,
    );
    winnerUserId = _is.ColumnUuid(
      'winnerUserId',
      this,
    );
    standings = _is.ColumnSerializable<List<_iyvw479e.LeagueStanding>>(
      'standings',
      this,
    );
    challengeCompleted = _is.ColumnBool(
      'challengeCompleted',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SeasonResultUpdateTable updateTable;

  late final _is.ColumnInt leagueId;

  /// Monday 00:00 UTC of the season's week.
  late final _is.ColumnDateTime weekStart;

  /// Null when nobody scored or the league had fewer than 2 members.
  late final _is.ColumnUuid winnerUserId;

  late final _is.ColumnSerializable<List<_iyvw479e.LeagueStanding>> standings;

  /// Whether the league met that week's team challenge.
  late final _is.ColumnBool challengeCompleted;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    leagueId,
    weekStart,
    winnerUserId,
    standings,
    challengeCompleted,
    createdAt,
  ];
}

class SeasonResultInclude extends _is.IncludeObject {
  SeasonResultInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SeasonResult.t;
}

class SeasonResultIncludeList extends _is.IncludeList {
  SeasonResultIncludeList._({
    _is.WhereExpressionBuilder<SeasonResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SeasonResult.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SeasonResult.t;
}

class SeasonResultRepository {
  const SeasonResultRepository._();

  /// Returns a list of [SeasonResult]s matching the given query parameters.
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
  Future<List<SeasonResult>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SeasonResult>(
      where: where?.call(SeasonResult.t),
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SeasonResult] matching the given query parameters.
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
  Future<SeasonResult?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonResultTable>? where,
    int? offset,
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SeasonResult>(
      where: where?.call(SeasonResult.t),
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SeasonResult] by its [id] or null if no such row exists.
  Future<SeasonResult?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SeasonResult>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SeasonResult]s in the list and returns the inserted rows.
  ///
  /// The returned [SeasonResult]s will have their `id` fields set.
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
  Future<List<SeasonResult>> insert(
    _is.DatabaseSession session,
    List<SeasonResult> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SeasonResult>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SeasonResult] and returns the inserted row.
  ///
  /// The returned [SeasonResult] will have its `id` field set.
  Future<SeasonResult> insertRow(
    _is.DatabaseSession session,
    SeasonResult row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SeasonResult>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SeasonResult]s in the list and returns the resulting rows.
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
  /// The returned [SeasonResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeasonResult>> upsert(
    _is.DatabaseSession session,
    List<SeasonResult> rows, {
    required _is.ColumnSelections<SeasonResultTable> conflictColumns,
    _is.ColumnSelections<SeasonResultTable>? updateColumns,
    _is.WhereExpressionBuilder<SeasonResultTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SeasonResult>(
      rows,
      conflictColumns: conflictColumns(SeasonResult.t),
      updateColumns: updateColumns?.call(SeasonResult.t),
      updateWhere: updateWhere?.call(SeasonResult.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SeasonResult] and returns the resulting row.
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
  /// The returned [SeasonResult] will have its `id` field set.
  Future<SeasonResult?> upsertRow(
    _is.DatabaseSession session,
    SeasonResult row, {
    required _is.ColumnSelections<SeasonResultTable> conflictColumns,
    _is.ColumnSelections<SeasonResultTable>? updateColumns,
    _is.WhereExpressionBuilder<SeasonResultTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SeasonResult>(
      row,
      conflictColumns: conflictColumns(SeasonResult.t),
      updateColumns: updateColumns?.call(SeasonResult.t),
      updateWhere: updateWhere?.call(SeasonResult.t),
      transaction: transaction,
    );
  }

  /// Updates all [SeasonResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeasonResult>> update(
    _is.DatabaseSession session,
    List<SeasonResult> rows, {
    _is.ColumnSelections<SeasonResultTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SeasonResult>(
      rows,
      columns: columns?.call(SeasonResult.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SeasonResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SeasonResult> updateRow(
    _is.DatabaseSession session,
    SeasonResult row, {
    _is.ColumnSelections<SeasonResultTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SeasonResult>(
      row,
      columns: columns?.call(SeasonResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SeasonResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SeasonResult?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SeasonResultUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SeasonResult>(
      id,
      columnValues: columnValues(SeasonResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SeasonResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeasonResult>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SeasonResultUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SeasonResultTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SeasonResult>(
      columnValues: columnValues(SeasonResult.t.updateTable),
      where: where(SeasonResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SeasonResult]s in the list and returns the deleted rows.
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
  Future<List<SeasonResult>> delete(
    _is.DatabaseSession session,
    List<SeasonResult> rows, {
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SeasonResult>(
      rows,
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SeasonResult].
  Future<SeasonResult> deleteRow(
    _is.DatabaseSession session,
    SeasonResult row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SeasonResult>(
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
  Future<List<SeasonResult>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeasonResultTable> where,
    _is.OrderByBuilder<SeasonResultTable>? orderBy,
    _is.OrderByListBuilder<SeasonResultTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SeasonResult>(
      where: where(SeasonResult.t),
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SeasonResult>(
      where: where?.call(SeasonResult.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SeasonResult] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeasonResultTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SeasonResult>(
      where: where(SeasonResult.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
