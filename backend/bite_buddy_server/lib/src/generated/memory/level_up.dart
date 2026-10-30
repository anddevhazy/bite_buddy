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

/// When a pet reached a level, for the memory book's level journey.
abstract class LevelUp
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LevelUp._({
    this.id,
    required this.ownerId,
    required this.level,
    required this.reachedAt,
  });

  factory LevelUp({
    int? id,
    required _is.UuidValue ownerId,
    required int level,
    required DateTime reachedAt,
  }) = _LevelUpImpl;

  factory LevelUp.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUp(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      level: jsonSerialization['level'] as int,
      reachedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['reachedAt'],
      ),
    );
  }

  static final t = LevelUpTable();

  static const db = LevelUpRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  int level;

  DateTime reachedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LevelUp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LevelUp copyWith({
    int? id,
    _is.UuidValue? ownerId,
    int? level,
    DateTime? reachedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelUp',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelUp',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  static LevelUpInclude include() {
    return LevelUpInclude._();
  }

  static LevelUpIncludeList includeList({
    _is.WhereExpressionBuilder<LevelUpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    LevelUpInclude? include,
  }) {
    return LevelUpIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpImpl extends LevelUp {
  _LevelUpImpl({
    int? id,
    required _is.UuidValue ownerId,
    required int level,
    required DateTime reachedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         level: level,
         reachedAt: reachedAt,
       );

  /// Returns a shallow copy of this [LevelUp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LevelUp copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    int? level,
    DateTime? reachedAt,
  }) {
    return LevelUp(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      level: level ?? this.level,
      reachedAt: reachedAt ?? this.reachedAt,
    );
  }
}

class LevelUpUpdateTable extends _is.UpdateTable<LevelUpTable> {
  LevelUpUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<int, int> level(int value) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> reachedAt(DateTime value) =>
      _is.ColumnValue(
        table.reachedAt,
        value,
      );
}

class LevelUpTable extends _is.Table<int?> {
  LevelUpTable({super.tableRelation}) : super(tableName: 'level_up') {
    updateTable = LevelUpUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    level = _is.ColumnInt(
      'level',
      this,
    );
    reachedAt = _is.ColumnDateTime(
      'reachedAt',
      this,
    );
  }

  late final LevelUpUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnInt level;

  late final _is.ColumnDateTime reachedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    level,
    reachedAt,
  ];
}

class LevelUpInclude extends _is.IncludeObject {
  LevelUpInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LevelUp.t;
}

class LevelUpIncludeList extends _is.IncludeList {
  LevelUpIncludeList._({
    _is.WhereExpressionBuilder<LevelUpTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LevelUp.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LevelUp.t;
}

class LevelUpRepository {
  const LevelUpRepository._();

  /// Returns a list of [LevelUp]s matching the given query parameters.
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
  Future<List<LevelUp>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LevelUpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LevelUp>(
      where: where?.call(LevelUp.t),
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LevelUp] matching the given query parameters.
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
  Future<LevelUp?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LevelUpTable>? where,
    int? offset,
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LevelUp>(
      where: where?.call(LevelUp.t),
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LevelUp] by its [id] or null if no such row exists.
  Future<LevelUp?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LevelUp>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LevelUp]s in the list and returns the inserted rows.
  ///
  /// The returned [LevelUp]s will have their `id` fields set.
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
  Future<List<LevelUp>> insert(
    _is.DatabaseSession session,
    List<LevelUp> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LevelUp>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LevelUp] and returns the inserted row.
  ///
  /// The returned [LevelUp] will have its `id` field set.
  Future<LevelUp> insertRow(
    _is.DatabaseSession session,
    LevelUp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LevelUp>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LevelUp]s in the list and returns the resulting rows.
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
  /// The returned [LevelUp]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LevelUp>> upsert(
    _is.DatabaseSession session,
    List<LevelUp> rows, {
    required _is.ColumnSelections<LevelUpTable> conflictColumns,
    _is.ColumnSelections<LevelUpTable>? updateColumns,
    _is.WhereExpressionBuilder<LevelUpTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LevelUp>(
      rows,
      conflictColumns: conflictColumns(LevelUp.t),
      updateColumns: updateColumns?.call(LevelUp.t),
      updateWhere: updateWhere?.call(LevelUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LevelUp] and returns the resulting row.
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
  /// The returned [LevelUp] will have its `id` field set.
  Future<LevelUp?> upsertRow(
    _is.DatabaseSession session,
    LevelUp row, {
    required _is.ColumnSelections<LevelUpTable> conflictColumns,
    _is.ColumnSelections<LevelUpTable>? updateColumns,
    _is.WhereExpressionBuilder<LevelUpTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LevelUp>(
      row,
      conflictColumns: conflictColumns(LevelUp.t),
      updateColumns: updateColumns?.call(LevelUp.t),
      updateWhere: updateWhere?.call(LevelUp.t),
      transaction: transaction,
    );
  }

  /// Updates all [LevelUp]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LevelUp>> update(
    _is.DatabaseSession session,
    List<LevelUp> rows, {
    _is.ColumnSelections<LevelUpTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LevelUp>(
      rows,
      columns: columns?.call(LevelUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LevelUp]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LevelUp> updateRow(
    _is.DatabaseSession session,
    LevelUp row, {
    _is.ColumnSelections<LevelUpTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LevelUp>(
      row,
      columns: columns?.call(LevelUp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LevelUp] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LevelUp?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LevelUpUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LevelUp>(
      id,
      columnValues: columnValues(LevelUp.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LevelUp]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LevelUp>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LevelUpUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LevelUpTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LevelUp>(
      columnValues: columnValues(LevelUp.t.updateTable),
      where: where(LevelUp.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LevelUp]s in the list and returns the deleted rows.
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
  Future<List<LevelUp>> delete(
    _is.DatabaseSession session,
    List<LevelUp> rows, {
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LevelUp>(
      rows,
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LevelUp].
  Future<LevelUp> deleteRow(
    _is.DatabaseSession session,
    LevelUp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LevelUp>(
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
  Future<List<LevelUp>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LevelUpTable> where,
    _is.OrderByBuilder<LevelUpTable>? orderBy,
    _is.OrderByListBuilder<LevelUpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LevelUp>(
      where: where(LevelUp.t),
      orderBy: orderBy?.call(LevelUp.t),
      orderByList: orderByList?.call(LevelUp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LevelUpTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LevelUp>(
      where: where?.call(LevelUp.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LevelUp] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LevelUpTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LevelUp>(
      where: where(LevelUp.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
