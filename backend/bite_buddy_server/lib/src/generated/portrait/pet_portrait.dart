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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;

/// A picture of the user's real pet, redrawn as their buddy. Drafts that were
/// never used are cleaned up after a day; used ones are kept because old
/// friend battles still show them.
abstract class PetPortrait
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PetPortrait._({
    this.id,
    required this.ownerId,
    required this.image,
    required this.animal,
    required this.used,
    required this.createdAt,
  });

  factory PetPortrait({
    int? id,
    required _is.UuidValue ownerId,
    required _idt.ByteData image,
    required String animal,
    required bool used,
    required DateTime createdAt,
  }) = _PetPortraitImpl;

  factory PetPortrait.fromJson(Map<String, dynamic> jsonSerialization) {
    return PetPortrait(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      image: _is.ByteDataJsonExtension.fromJson(jsonSerialization['image']),
      animal: jsonSerialization['animal'] as String,
      used: _is.BoolJsonExtension.fromJson(jsonSerialization['used']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PetPortraitTable();

  static const db = PetPortraitRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  /// PNG or JPEG bytes.
  _idt.ByteData image;

  /// What the AI saw, e.g. "dog", "cat", "rabbit".
  String animal;

  /// True once it has been put on the owner's pet.
  bool used;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PetPortrait]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PetPortrait copyWith({
    int? id,
    _is.UuidValue? ownerId,
    _idt.ByteData? image,
    String? animal,
    bool? used,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PetPortrait',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'image': image.toJson(),
      'animal': animal,
      'used': used,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PetPortrait',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'image': image.toJson(),
      'animal': animal,
      'used': used,
      'createdAt': createdAt.toJson(),
    };
  }

  static PetPortraitInclude include() {
    return PetPortraitInclude._();
  }

  static PetPortraitIncludeList includeList({
    _is.WhereExpressionBuilder<PetPortraitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    PetPortraitInclude? include,
  }) {
    return PetPortraitIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PetPortraitImpl extends PetPortrait {
  _PetPortraitImpl({
    int? id,
    required _is.UuidValue ownerId,
    required _idt.ByteData image,
    required String animal,
    required bool used,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         image: image,
         animal: animal,
         used: used,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PetPortrait]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PetPortrait copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    _idt.ByteData? image,
    String? animal,
    bool? used,
    DateTime? createdAt,
  }) {
    return PetPortrait(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      image: image ?? this.image.clone(),
      animal: animal ?? this.animal,
      used: used ?? this.used,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PetPortraitUpdateTable extends _is.UpdateTable<PetPortraitTable> {
  PetPortraitUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_idt.ByteData, _idt.ByteData> image(_idt.ByteData value) =>
      _is.ColumnValue(
        table.image,
        value,
      );

  _is.ColumnValue<String, String> animal(String value) => _is.ColumnValue(
    table.animal,
    value,
  );

  _is.ColumnValue<bool, bool> used(bool value) => _is.ColumnValue(
    table.used,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PetPortraitTable extends _is.Table<int?> {
  PetPortraitTable({super.tableRelation}) : super(tableName: 'pet_portrait') {
    updateTable = PetPortraitUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    image = _is.ColumnByteData(
      'image',
      this,
    );
    animal = _is.ColumnString(
      'animal',
      this,
    );
    used = _is.ColumnBool(
      'used',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PetPortraitUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  /// PNG or JPEG bytes.
  late final _is.ColumnByteData image;

  /// What the AI saw, e.g. "dog", "cat", "rabbit".
  late final _is.ColumnString animal;

  /// True once it has been put on the owner's pet.
  late final _is.ColumnBool used;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    image,
    animal,
    used,
    createdAt,
  ];
}

class PetPortraitInclude extends _is.IncludeObject {
  PetPortraitInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PetPortrait.t;
}

class PetPortraitIncludeList extends _is.IncludeList {
  PetPortraitIncludeList._({
    _is.WhereExpressionBuilder<PetPortraitTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PetPortrait.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PetPortrait.t;
}

class PetPortraitRepository {
  const PetPortraitRepository._();

  /// Returns a list of [PetPortrait]s matching the given query parameters.
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
  Future<List<PetPortrait>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetPortraitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PetPortrait>(
      where: where?.call(PetPortrait.t),
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PetPortrait] matching the given query parameters.
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
  Future<PetPortrait?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetPortraitTable>? where,
    int? offset,
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PetPortrait>(
      where: where?.call(PetPortrait.t),
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PetPortrait] by its [id] or null if no such row exists.
  Future<PetPortrait?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PetPortrait>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PetPortrait]s in the list and returns the inserted rows.
  ///
  /// The returned [PetPortrait]s will have their `id` fields set.
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
  Future<List<PetPortrait>> insert(
    _is.DatabaseSession session,
    List<PetPortrait> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PetPortrait>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PetPortrait] and returns the inserted row.
  ///
  /// The returned [PetPortrait] will have its `id` field set.
  Future<PetPortrait> insertRow(
    _is.DatabaseSession session,
    PetPortrait row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PetPortrait>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PetPortrait]s in the list and returns the resulting rows.
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
  /// The returned [PetPortrait]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PetPortrait>> upsert(
    _is.DatabaseSession session,
    List<PetPortrait> rows, {
    required _is.ColumnSelections<PetPortraitTable> conflictColumns,
    _is.ColumnSelections<PetPortraitTable>? updateColumns,
    _is.WhereExpressionBuilder<PetPortraitTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PetPortrait>(
      rows,
      conflictColumns: conflictColumns(PetPortrait.t),
      updateColumns: updateColumns?.call(PetPortrait.t),
      updateWhere: updateWhere?.call(PetPortrait.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PetPortrait] and returns the resulting row.
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
  /// The returned [PetPortrait] will have its `id` field set.
  Future<PetPortrait?> upsertRow(
    _is.DatabaseSession session,
    PetPortrait row, {
    required _is.ColumnSelections<PetPortraitTable> conflictColumns,
    _is.ColumnSelections<PetPortraitTable>? updateColumns,
    _is.WhereExpressionBuilder<PetPortraitTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PetPortrait>(
      row,
      conflictColumns: conflictColumns(PetPortrait.t),
      updateColumns: updateColumns?.call(PetPortrait.t),
      updateWhere: updateWhere?.call(PetPortrait.t),
      transaction: transaction,
    );
  }

  /// Updates all [PetPortrait]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PetPortrait>> update(
    _is.DatabaseSession session,
    List<PetPortrait> rows, {
    _is.ColumnSelections<PetPortraitTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PetPortrait>(
      rows,
      columns: columns?.call(PetPortrait.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PetPortrait]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PetPortrait> updateRow(
    _is.DatabaseSession session,
    PetPortrait row, {
    _is.ColumnSelections<PetPortraitTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PetPortrait>(
      row,
      columns: columns?.call(PetPortrait.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PetPortrait] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PetPortrait?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PetPortraitUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PetPortrait>(
      id,
      columnValues: columnValues(PetPortrait.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PetPortrait]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PetPortrait>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PetPortraitUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PetPortraitTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PetPortrait>(
      columnValues: columnValues(PetPortrait.t.updateTable),
      where: where(PetPortrait.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PetPortrait]s in the list and returns the deleted rows.
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
  Future<List<PetPortrait>> delete(
    _is.DatabaseSession session,
    List<PetPortrait> rows, {
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PetPortrait>(
      rows,
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PetPortrait].
  Future<PetPortrait> deleteRow(
    _is.DatabaseSession session,
    PetPortrait row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PetPortrait>(
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
  Future<List<PetPortrait>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PetPortraitTable> where,
    _is.OrderByBuilder<PetPortraitTable>? orderBy,
    _is.OrderByListBuilder<PetPortraitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PetPortrait>(
      where: where(PetPortrait.t),
      orderBy: orderBy?.call(PetPortrait.t),
      orderByList: orderByList?.call(PetPortrait.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetPortraitTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PetPortrait>(
      where: where?.call(PetPortrait.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PetPortrait] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PetPortraitTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PetPortrait>(
      where: where(PetPortrait.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
