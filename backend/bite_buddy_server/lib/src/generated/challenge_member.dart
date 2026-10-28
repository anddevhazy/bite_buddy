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

abstract class ChallengeMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ChallengeMember._({
    this.id,
    required this.challengeId,
    required this.userId,
    required this.joinedAt,
  });

  factory ChallengeMember({
    int? id,
    required int challengeId,
    required _is.UuidValue userId,
    required DateTime joinedAt,
  }) = _ChallengeMemberImpl;

  factory ChallengeMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeMember(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as int,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = ChallengeMemberTable();

  static const db = ChallengeMemberRepository._();

  @override
  int? id;

  int challengeId;

  _is.UuidValue userId;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChallengeMember copyWith({
    int? id,
    int? challengeId,
    _is.UuidValue? userId,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeMember',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeMember',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  static ChallengeMemberInclude include() {
    return ChallengeMemberInclude._();
  }

  static ChallengeMemberIncludeList includeList({
    _is.WhereExpressionBuilder<ChallengeMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    ChallengeMemberInclude? include,
  }) {
    return ChallengeMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeMemberImpl extends ChallengeMember {
  _ChallengeMemberImpl({
    int? id,
    required int challengeId,
    required _is.UuidValue userId,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         challengeId: challengeId,
         userId: userId,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [ChallengeMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChallengeMember copyWith({
    Object? id = _Undefined,
    int? challengeId,
    _is.UuidValue? userId,
    DateTime? joinedAt,
  }) {
    return ChallengeMember(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class ChallengeMemberUpdateTable extends _is.UpdateTable<ChallengeMemberTable> {
  ChallengeMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> challengeId(int value) => _is.ColumnValue(
    table.challengeId,
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

class ChallengeMemberTable extends _is.Table<int?> {
  ChallengeMemberTable({super.tableRelation})
    : super(tableName: 'challenge_member') {
    updateTable = ChallengeMemberUpdateTable(this);
    challengeId = _is.ColumnInt(
      'challengeId',
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

  late final ChallengeMemberUpdateTable updateTable;

  late final _is.ColumnInt challengeId;

  late final _is.ColumnUuid userId;

  late final _is.ColumnDateTime joinedAt;

  @override
  List<_is.Column> get columns => [
    id,
    challengeId,
    userId,
    joinedAt,
  ];
}

class ChallengeMemberInclude extends _is.IncludeObject {
  ChallengeMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ChallengeMember.t;
}

class ChallengeMemberIncludeList extends _is.IncludeList {
  ChallengeMemberIncludeList._({
    _is.WhereExpressionBuilder<ChallengeMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChallengeMember.t;
}

class ChallengeMemberRepository {
  const ChallengeMemberRepository._();

  /// Returns a list of [ChallengeMember]s matching the given query parameters.
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
  Future<List<ChallengeMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeMember>(
      where: where?.call(ChallengeMember.t),
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeMember] matching the given query parameters.
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
  Future<ChallengeMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeMember>(
      where: where?.call(ChallengeMember.t),
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeMember] by its [id] or null if no such row exists.
  Future<ChallengeMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeMember]s will have their `id` fields set.
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
  Future<List<ChallengeMember>> insert(
    _is.DatabaseSession session,
    List<ChallengeMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChallengeMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChallengeMember] and returns the inserted row.
  ///
  /// The returned [ChallengeMember] will have its `id` field set.
  Future<ChallengeMember> insertRow(
    _is.DatabaseSession session,
    ChallengeMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChallengeMember]s in the list and returns the resulting rows.
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
  /// The returned [ChallengeMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChallengeMember>> upsert(
    _is.DatabaseSession session,
    List<ChallengeMember> rows, {
    required _is.ColumnSelections<ChallengeMemberTable> conflictColumns,
    _is.ColumnSelections<ChallengeMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<ChallengeMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChallengeMember>(
      rows,
      conflictColumns: conflictColumns(ChallengeMember.t),
      updateColumns: updateColumns?.call(ChallengeMember.t),
      updateWhere: updateWhere?.call(ChallengeMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChallengeMember] and returns the resulting row.
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
  /// The returned [ChallengeMember] will have its `id` field set.
  Future<ChallengeMember?> upsertRow(
    _is.DatabaseSession session,
    ChallengeMember row, {
    required _is.ColumnSelections<ChallengeMemberTable> conflictColumns,
    _is.ColumnSelections<ChallengeMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<ChallengeMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChallengeMember>(
      row,
      conflictColumns: conflictColumns(ChallengeMember.t),
      updateColumns: updateColumns?.call(ChallengeMember.t),
      updateWhere: updateWhere?.call(ChallengeMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChallengeMember>> update(
    _is.DatabaseSession session,
    List<ChallengeMember> rows, {
    _is.ColumnSelections<ChallengeMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChallengeMember>(
      rows,
      columns: columns?.call(ChallengeMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChallengeMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeMember> updateRow(
    _is.DatabaseSession session,
    ChallengeMember row, {
    _is.ColumnSelections<ChallengeMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeMember>(
      row,
      columns: columns?.call(ChallengeMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChallengeMemberUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeMember>(
      id,
      columnValues: columnValues(ChallengeMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChallengeMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChallengeMemberUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ChallengeMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChallengeMember>(
      columnValues: columnValues(ChallengeMember.t.updateTable),
      where: where(ChallengeMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChallengeMember]s in the list and returns the deleted rows.
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
  Future<List<ChallengeMember>> delete(
    _is.DatabaseSession session,
    List<ChallengeMember> rows, {
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChallengeMember>(
      rows,
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChallengeMember].
  Future<ChallengeMember> deleteRow(
    _is.DatabaseSession session,
    ChallengeMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeMember>(
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
  Future<List<ChallengeMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChallengeMemberTable> where,
    _is.OrderByBuilder<ChallengeMemberTable>? orderBy,
    _is.OrderByListBuilder<ChallengeMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChallengeMember>(
      where: where(ChallengeMember.t),
      orderBy: orderBy?.call(ChallengeMember.t),
      orderByList: orderByList?.call(ChallengeMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChallengeMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeMember>(
      where: where?.call(ChallengeMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChallengeMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeMember>(
      where: where(ChallengeMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
