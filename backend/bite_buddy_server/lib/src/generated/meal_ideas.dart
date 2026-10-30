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
import 'meal_suggestion.dart' as _iymppxeh;

/// Today's AI meal ideas for one user, cached so the AI is asked at most
/// once a day.
abstract class MealIdeas
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MealIdeas._({
    this.id,
    required this.ownerId,
    required this.day,
    required this.ideas,
    required this.createdAt,
  });

  factory MealIdeas({
    int? id,
    required _is.UuidValue ownerId,
    required DateTime day,
    required List<_iymppxeh.MealSuggestion> ideas,
    required DateTime createdAt,
  }) = _MealIdeasImpl;

  factory MealIdeas.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealIdeas(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      ideas: _i61ow1lb.Protocol().deserialize<List<_iymppxeh.MealSuggestion>>(
        jsonSerialization['ideas'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MealIdeasTable();

  static const db = MealIdeasRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  /// The owner's local day (UTC midnight).
  DateTime day;

  List<_iymppxeh.MealSuggestion> ideas;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MealIdeas]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealIdeas copyWith({
    int? id,
    _is.UuidValue? ownerId,
    DateTime? day,
    List<_iymppxeh.MealSuggestion>? ideas,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealIdeas',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'ideas': ideas.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealIdeas',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'ideas': ideas.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  static MealIdeasInclude include() {
    return MealIdeasInclude._();
  }

  static MealIdeasIncludeList includeList({
    _is.WhereExpressionBuilder<MealIdeasTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    MealIdeasInclude? include,
  }) {
    return MealIdeasIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealIdeasImpl extends MealIdeas {
  _MealIdeasImpl({
    int? id,
    required _is.UuidValue ownerId,
    required DateTime day,
    required List<_iymppxeh.MealSuggestion> ideas,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         day: day,
         ideas: ideas,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MealIdeas]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealIdeas copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    DateTime? day,
    List<_iymppxeh.MealSuggestion>? ideas,
    DateTime? createdAt,
  }) {
    return MealIdeas(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      day: day ?? this.day,
      ideas: ideas ?? this.ideas.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MealIdeasUpdateTable extends _is.UpdateTable<MealIdeasTable> {
  MealIdeasUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> day(DateTime value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<
    List<_iymppxeh.MealSuggestion>,
    List<_iymppxeh.MealSuggestion>
  >
  ideas(List<_iymppxeh.MealSuggestion> value) => _is.ColumnValue(
    table.ideas,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MealIdeasTable extends _is.Table<int?> {
  MealIdeasTable({super.tableRelation}) : super(tableName: 'meal_ideas') {
    updateTable = MealIdeasUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    day = _is.ColumnDateTime(
      'day',
      this,
    );
    ideas = _is.ColumnSerializable<List<_iymppxeh.MealSuggestion>>(
      'ideas',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MealIdeasUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  /// The owner's local day (UTC midnight).
  late final _is.ColumnDateTime day;

  late final _is.ColumnSerializable<List<_iymppxeh.MealSuggestion>> ideas;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    day,
    ideas,
    createdAt,
  ];
}

class MealIdeasInclude extends _is.IncludeObject {
  MealIdeasInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MealIdeas.t;
}

class MealIdeasIncludeList extends _is.IncludeList {
  MealIdeasIncludeList._({
    _is.WhereExpressionBuilder<MealIdeasTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealIdeas.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MealIdeas.t;
}

class MealIdeasRepository {
  const MealIdeasRepository._();

  /// Returns a list of [MealIdeas]s matching the given query parameters.
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
  Future<List<MealIdeas>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealIdeasTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MealIdeas>(
      where: where?.call(MealIdeas.t),
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MealIdeas] matching the given query parameters.
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
  Future<MealIdeas?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealIdeasTable>? where,
    int? offset,
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MealIdeas>(
      where: where?.call(MealIdeas.t),
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MealIdeas] by its [id] or null if no such row exists.
  Future<MealIdeas?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MealIdeas>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MealIdeas]s in the list and returns the inserted rows.
  ///
  /// The returned [MealIdeas]s will have their `id` fields set.
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
  Future<List<MealIdeas>> insert(
    _is.DatabaseSession session,
    List<MealIdeas> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MealIdeas>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MealIdeas] and returns the inserted row.
  ///
  /// The returned [MealIdeas] will have its `id` field set.
  Future<MealIdeas> insertRow(
    _is.DatabaseSession session,
    MealIdeas row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealIdeas>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MealIdeas]s in the list and returns the resulting rows.
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
  /// The returned [MealIdeas]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealIdeas>> upsert(
    _is.DatabaseSession session,
    List<MealIdeas> rows, {
    required _is.ColumnSelections<MealIdeasTable> conflictColumns,
    _is.ColumnSelections<MealIdeasTable>? updateColumns,
    _is.WhereExpressionBuilder<MealIdeasTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MealIdeas>(
      rows,
      conflictColumns: conflictColumns(MealIdeas.t),
      updateColumns: updateColumns?.call(MealIdeas.t),
      updateWhere: updateWhere?.call(MealIdeas.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MealIdeas] and returns the resulting row.
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
  /// The returned [MealIdeas] will have its `id` field set.
  Future<MealIdeas?> upsertRow(
    _is.DatabaseSession session,
    MealIdeas row, {
    required _is.ColumnSelections<MealIdeasTable> conflictColumns,
    _is.ColumnSelections<MealIdeasTable>? updateColumns,
    _is.WhereExpressionBuilder<MealIdeasTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MealIdeas>(
      row,
      conflictColumns: conflictColumns(MealIdeas.t),
      updateColumns: updateColumns?.call(MealIdeas.t),
      updateWhere: updateWhere?.call(MealIdeas.t),
      transaction: transaction,
    );
  }

  /// Updates all [MealIdeas]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealIdeas>> update(
    _is.DatabaseSession session,
    List<MealIdeas> rows, {
    _is.ColumnSelections<MealIdeasTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MealIdeas>(
      rows,
      columns: columns?.call(MealIdeas.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MealIdeas]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealIdeas> updateRow(
    _is.DatabaseSession session,
    MealIdeas row, {
    _is.ColumnSelections<MealIdeasTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealIdeas>(
      row,
      columns: columns?.call(MealIdeas.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealIdeas] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MealIdeas?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MealIdeasUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MealIdeas>(
      id,
      columnValues: columnValues(MealIdeas.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MealIdeas]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MealIdeas>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MealIdeasUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MealIdeasTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MealIdeas>(
      columnValues: columnValues(MealIdeas.t.updateTable),
      where: where(MealIdeas.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MealIdeas]s in the list and returns the deleted rows.
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
  Future<List<MealIdeas>> delete(
    _is.DatabaseSession session,
    List<MealIdeas> rows, {
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MealIdeas>(
      rows,
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MealIdeas].
  Future<MealIdeas> deleteRow(
    _is.DatabaseSession session,
    MealIdeas row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealIdeas>(
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
  Future<List<MealIdeas>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealIdeasTable> where,
    _is.OrderByBuilder<MealIdeasTable>? orderBy,
    _is.OrderByListBuilder<MealIdeasTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MealIdeas>(
      where: where(MealIdeas.t),
      orderBy: orderBy?.call(MealIdeas.t),
      orderByList: orderByList?.call(MealIdeas.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealIdeasTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MealIdeas>(
      where: where?.call(MealIdeas.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MealIdeas] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealIdeasTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MealIdeas>(
      where: where(MealIdeas.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
