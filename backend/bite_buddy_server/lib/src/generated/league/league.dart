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

/// A group of friends competing in weekly seasons.
abstract class League implements _is.TableRow<int?>, _is.ProtocolSerialization {
  League._({
    this.id,
    required this.name,
    required this.inviteCode,
    required this.ownerId,
    required this.createdAt,
  });

  factory League({
    int? id,
    required String name,
    required String inviteCode,
    required _is.UuidValue ownerId,
    required DateTime createdAt,
  }) = _LeagueImpl;

  factory League.fromJson(Map<String, dynamic> jsonSerialization) {
    return League(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = LeagueTable();

  static const db = LeagueRepository._();

  @override
  int? id;

  String name;

  /// Short code friends type in to join, e.g. "K7Q2MX".
  String inviteCode;

  _is.UuidValue ownerId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  League copyWith({
    int? id,
    String? name,
    String? inviteCode,
    _is.UuidValue? ownerId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static LeagueInclude include() {
    return LeagueInclude._();
  }

  static LeagueIncludeList includeList({
    _is.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    LeagueInclude? include,
  }) {
    return LeagueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueImpl extends League {
  _LeagueImpl({
    int? id,
    required String name,
    required String inviteCode,
    required _is.UuidValue ownerId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         inviteCode: inviteCode,
         ownerId: ownerId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  League copyWith({
    Object? id = _Undefined,
    String? name,
    String? inviteCode,
    _is.UuidValue? ownerId,
    DateTime? createdAt,
  }) {
    return League(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LeagueUpdateTable extends _is.UpdateTable<LeagueTable> {
  LeagueUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> inviteCode(String value) => _is.ColumnValue(
    table.inviteCode,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class LeagueTable extends _is.Table<int?> {
  LeagueTable({super.tableRelation}) : super(tableName: 'league') {
    updateTable = LeagueUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    inviteCode = _is.ColumnString(
      'inviteCode',
      this,
    );
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final LeagueUpdateTable updateTable;

  late final _is.ColumnString name;

  /// Short code friends type in to join, e.g. "K7Q2MX".
  late final _is.ColumnString inviteCode;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    inviteCode,
    ownerId,
    createdAt,
  ];
}

class LeagueInclude extends _is.IncludeObject {
  LeagueInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => League.t;
}

class LeagueIncludeList extends _is.IncludeList {
  LeagueIncludeList._({
    _is.WhereExpressionBuilder<LeagueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(League.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => League.t;
}

class LeagueRepository {
  const LeagueRepository._();

  /// Returns a list of [League]s matching the given query parameters.
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
  Future<List<League>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<League>(
      where: where?.call(League.t),
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [League] matching the given query parameters.
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
  Future<League?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueTable>? where,
    int? offset,
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<League>(
      where: where?.call(League.t),
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [League] by its [id] or null if no such row exists.
  Future<League?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<League>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [League]s in the list and returns the inserted rows.
  ///
  /// The returned [League]s will have their `id` fields set.
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
  Future<List<League>> insert(
    _is.DatabaseSession session,
    List<League> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<League>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [League] and returns the inserted row.
  ///
  /// The returned [League] will have its `id` field set.
  Future<League> insertRow(
    _is.DatabaseSession session,
    League row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<League>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [League]s in the list and returns the resulting rows.
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
  /// The returned [League]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<League>> upsert(
    _is.DatabaseSession session,
    List<League> rows, {
    required _is.ColumnSelections<LeagueTable> conflictColumns,
    _is.ColumnSelections<LeagueTable>? updateColumns,
    _is.WhereExpressionBuilder<LeagueTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<League>(
      rows,
      conflictColumns: conflictColumns(League.t),
      updateColumns: updateColumns?.call(League.t),
      updateWhere: updateWhere?.call(League.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [League] and returns the resulting row.
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
  /// The returned [League] will have its `id` field set.
  Future<League?> upsertRow(
    _is.DatabaseSession session,
    League row, {
    required _is.ColumnSelections<LeagueTable> conflictColumns,
    _is.ColumnSelections<LeagueTable>? updateColumns,
    _is.WhereExpressionBuilder<LeagueTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<League>(
      row,
      conflictColumns: conflictColumns(League.t),
      updateColumns: updateColumns?.call(League.t),
      updateWhere: updateWhere?.call(League.t),
      transaction: transaction,
    );
  }

  /// Updates all [League]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<League>> update(
    _is.DatabaseSession session,
    List<League> rows, {
    _is.ColumnSelections<LeagueTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<League>(
      rows,
      columns: columns?.call(League.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [League]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<League> updateRow(
    _is.DatabaseSession session,
    League row, {
    _is.ColumnSelections<LeagueTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<League>(
      row,
      columns: columns?.call(League.t),
      transaction: transaction,
    );
  }

  /// Updates a single [League] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<League?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LeagueUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<League>(
      id,
      columnValues: columnValues(League.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [League]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<League>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LeagueUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LeagueTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<League>(
      columnValues: columnValues(League.t.updateTable),
      where: where(League.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [League]s in the list and returns the deleted rows.
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
  Future<List<League>> delete(
    _is.DatabaseSession session,
    List<League> rows, {
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<League>(
      rows,
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [League].
  Future<League> deleteRow(
    _is.DatabaseSession session,
    League row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<League>(
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
  Future<List<League>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LeagueTable> where,
    _is.OrderByBuilder<LeagueTable>? orderBy,
    _is.OrderByListBuilder<LeagueTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<League>(
      where: where(League.t),
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<League>(
      where: where?.call(League.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [League] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LeagueTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<League>(
      where: where(League.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
