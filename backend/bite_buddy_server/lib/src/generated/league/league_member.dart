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

/// One user's membership of a league.
abstract class LeagueMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LeagueMember._({
    this.id,
    required this.leagueId,
    required this.userId,
    required this.joinedAt,
  });

  factory LeagueMember({
    int? id,
    required int leagueId,
    required _is.UuidValue userId,
    required DateTime joinedAt,
  }) = _LeagueMemberImpl;

  factory LeagueMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueMember(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = LeagueMemberTable();

  static const db = LeagueMemberRepository._();

  @override
  int? id;

  int leagueId;

  _is.UuidValue userId;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LeagueMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeagueMember copyWith({
    int? id,
    int? leagueId,
    _is.UuidValue? userId,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueMember',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueMember',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  static LeagueMemberInclude include() {
    return LeagueMemberInclude._();
  }

  static LeagueMemberIncludeList includeList({
    _is.WhereExpressionBuilder<LeagueMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    LeagueMemberInclude? include,
  }) {
    return LeagueMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueMemberImpl extends LeagueMember {
  _LeagueMemberImpl({
    int? id,
    required int leagueId,
    required _is.UuidValue userId,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         userId: userId,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [LeagueMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeagueMember copyWith({
    Object? id = _Undefined,
    int? leagueId,
    _is.UuidValue? userId,
    DateTime? joinedAt,
  }) {
    return LeagueMember(
      id: id is int? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class LeagueMemberUpdateTable extends _is.UpdateTable<LeagueMemberTable> {
  LeagueMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> leagueId(int value) => _is.ColumnValue(
    table.leagueId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class LeagueMemberTable extends _is.Table<int?> {
  LeagueMemberTable({super.tableRelation}) : super(tableName: 'league_member') {
    updateTable = LeagueMemberUpdateTable(this);
    leagueId = _is.ColumnInt(
      'leagueId',
      this,
    );
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
    );
  }

  late final LeagueMemberUpdateTable updateTable;

  late final _is.ColumnInt leagueId;

  late final _is.ColumnUuid userId;

  late final _is.ColumnDateTime joinedAt;

  @override
  List<_is.Column> get columns => [
    id,
    leagueId,
    userId,
    joinedAt,
  ];
}

class LeagueMemberInclude extends _is.IncludeObject {
  LeagueMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LeagueMember.t;
}

class LeagueMemberIncludeList extends _is.IncludeList {
  LeagueMemberIncludeList._({
    _is.WhereExpressionBuilder<LeagueMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LeagueMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LeagueMember.t;
}

class LeagueMemberRepository {
  const LeagueMemberRepository._();

  /// Returns a list of [LeagueMember]s matching the given query parameters.
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
  Future<List<LeagueMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LeagueMember>(
      where: where?.call(LeagueMember.t),
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LeagueMember] matching the given query parameters.
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
  Future<LeagueMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LeagueMember>(
      where: where?.call(LeagueMember.t),
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LeagueMember] by its [id] or null if no such row exists.
  Future<LeagueMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LeagueMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LeagueMember]s in the list and returns the inserted rows.
  ///
  /// The returned [LeagueMember]s will have their `id` fields set.
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
  Future<List<LeagueMember>> insert(
    _is.DatabaseSession session,
    List<LeagueMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LeagueMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LeagueMember] and returns the inserted row.
  ///
  /// The returned [LeagueMember] will have its `id` field set.
  Future<LeagueMember> insertRow(
    _is.DatabaseSession session,
    LeagueMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LeagueMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LeagueMember]s in the list and returns the resulting rows.
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
  /// The returned [LeagueMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LeagueMember>> upsert(
    _is.DatabaseSession session,
    List<LeagueMember> rows, {
    required _is.ColumnSelections<LeagueMemberTable> conflictColumns,
    _is.ColumnSelections<LeagueMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<LeagueMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LeagueMember>(
      rows,
      conflictColumns: conflictColumns(LeagueMember.t),
      updateColumns: updateColumns?.call(LeagueMember.t),
      updateWhere: updateWhere?.call(LeagueMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LeagueMember] and returns the resulting row.
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
  /// The returned [LeagueMember] will have its `id` field set.
  Future<LeagueMember?> upsertRow(
    _is.DatabaseSession session,
    LeagueMember row, {
    required _is.ColumnSelections<LeagueMemberTable> conflictColumns,
    _is.ColumnSelections<LeagueMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<LeagueMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LeagueMember>(
      row,
      conflictColumns: conflictColumns(LeagueMember.t),
      updateColumns: updateColumns?.call(LeagueMember.t),
      updateWhere: updateWhere?.call(LeagueMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [LeagueMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LeagueMember>> update(
    _is.DatabaseSession session,
    List<LeagueMember> rows, {
    _is.ColumnSelections<LeagueMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LeagueMember>(
      rows,
      columns: columns?.call(LeagueMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LeagueMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LeagueMember> updateRow(
    _is.DatabaseSession session,
    LeagueMember row, {
    _is.ColumnSelections<LeagueMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LeagueMember>(
      row,
      columns: columns?.call(LeagueMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LeagueMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LeagueMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LeagueMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LeagueMember>(
      id,
      columnValues: columnValues(LeagueMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LeagueMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LeagueMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LeagueMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LeagueMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LeagueMember>(
      columnValues: columnValues(LeagueMember.t.updateTable),
      where: where(LeagueMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LeagueMember]s in the list and returns the deleted rows.
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
  Future<List<LeagueMember>> delete(
    _is.DatabaseSession session,
    List<LeagueMember> rows, {
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LeagueMember>(
      rows,
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LeagueMember].
  Future<LeagueMember> deleteRow(
    _is.DatabaseSession session,
    LeagueMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LeagueMember>(
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
  Future<List<LeagueMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LeagueMemberTable> where,
    _is.OrderByBuilder<LeagueMemberTable>? orderBy,
    _is.OrderByListBuilder<LeagueMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LeagueMember>(
      where: where(LeagueMember.t),
      orderBy: orderBy?.call(LeagueMember.t),
      orderByList: orderByList?.call(LeagueMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LeagueMember>(
      where: where?.call(LeagueMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LeagueMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LeagueMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LeagueMember>(
      where: where(LeagueMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
