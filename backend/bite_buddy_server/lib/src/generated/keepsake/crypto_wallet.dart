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

/// A player's wallet on Base, where their keepsakes are minted.
abstract class CryptoWallet
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CryptoWallet._({
    this.id,
    required this.ownerId,
    required this.address,
    required this.isTest,
    required this.showPetPhoto,
    required this.createdAt,
  });

  factory CryptoWallet({
    int? id,
    required _is.UuidValue ownerId,
    required String address,
    required bool isTest,
    required bool showPetPhoto,
    required DateTime createdAt,
  }) = _CryptoWalletImpl;

  factory CryptoWallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return CryptoWallet(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      address: jsonSerialization['address'] as String,
      isTest: _is.BoolJsonExtension.fromJson(jsonSerialization['isTest']),
      showPetPhoto: _is.BoolJsonExtension.fromJson(
        jsonSerialization['showPetPhoto'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CryptoWalletTable();

  static const db = CryptoWalletRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  /// 0x-prefixed, lowercase.
  String address;

  /// True for a stand-in wallet made while no wallet provider is set up:
  /// nothing minted to it is on a real blockchain.
  bool isTest;

  /// Whether their own pet's photo ("My own pet") may appear on their
  /// keepsakes, which are public. Otherwise a paw card is used.
  bool showPetPhoto;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CryptoWallet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CryptoWallet copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? address,
    bool? isTest,
    bool? showPetPhoto,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CryptoWallet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'address': address,
      'isTest': isTest,
      'showPetPhoto': showPetPhoto,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CryptoWallet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'address': address,
      'isTest': isTest,
      'showPetPhoto': showPetPhoto,
      'createdAt': createdAt.toJson(),
    };
  }

  static CryptoWalletInclude include() {
    return CryptoWalletInclude._();
  }

  static CryptoWalletIncludeList includeList({
    _is.WhereExpressionBuilder<CryptoWalletTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    CryptoWalletInclude? include,
  }) {
    return CryptoWalletIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CryptoWalletImpl extends CryptoWallet {
  _CryptoWalletImpl({
    int? id,
    required _is.UuidValue ownerId,
    required String address,
    required bool isTest,
    required bool showPetPhoto,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         address: address,
         isTest: isTest,
         showPetPhoto: showPetPhoto,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CryptoWallet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CryptoWallet copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    String? address,
    bool? isTest,
    bool? showPetPhoto,
    DateTime? createdAt,
  }) {
    return CryptoWallet(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      address: address ?? this.address,
      isTest: isTest ?? this.isTest,
      showPetPhoto: showPetPhoto ?? this.showPetPhoto,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CryptoWalletUpdateTable extends _is.UpdateTable<CryptoWalletTable> {
  CryptoWalletUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<bool, bool> isTest(bool value) => _is.ColumnValue(
    table.isTest,
    value,
  );

  _is.ColumnValue<bool, bool> showPetPhoto(bool value) => _is.ColumnValue(
    table.showPetPhoto,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CryptoWalletTable extends _is.Table<int?> {
  CryptoWalletTable({super.tableRelation}) : super(tableName: 'crypto_wallet') {
    updateTable = CryptoWalletUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    isTest = _is.ColumnBool(
      'isTest',
      this,
    );
    showPetPhoto = _is.ColumnBool(
      'showPetPhoto',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CryptoWalletUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  /// 0x-prefixed, lowercase.
  late final _is.ColumnString address;

  /// True for a stand-in wallet made while no wallet provider is set up:
  /// nothing minted to it is on a real blockchain.
  late final _is.ColumnBool isTest;

  /// Whether their own pet's photo ("My own pet") may appear on their
  /// keepsakes, which are public. Otherwise a paw card is used.
  late final _is.ColumnBool showPetPhoto;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    address,
    isTest,
    showPetPhoto,
    createdAt,
  ];
}

class CryptoWalletInclude extends _is.IncludeObject {
  CryptoWalletInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CryptoWallet.t;
}

class CryptoWalletIncludeList extends _is.IncludeList {
  CryptoWalletIncludeList._({
    _is.WhereExpressionBuilder<CryptoWalletTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CryptoWallet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CryptoWallet.t;
}

class CryptoWalletRepository {
  const CryptoWalletRepository._();

  /// Returns a list of [CryptoWallet]s matching the given query parameters.
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
  Future<List<CryptoWallet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CryptoWalletTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CryptoWallet>(
      where: where?.call(CryptoWallet.t),
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CryptoWallet] matching the given query parameters.
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
  Future<CryptoWallet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CryptoWalletTable>? where,
    int? offset,
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CryptoWallet>(
      where: where?.call(CryptoWallet.t),
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CryptoWallet] by its [id] or null if no such row exists.
  Future<CryptoWallet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CryptoWallet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CryptoWallet]s in the list and returns the inserted rows.
  ///
  /// The returned [CryptoWallet]s will have their `id` fields set.
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
  Future<List<CryptoWallet>> insert(
    _is.DatabaseSession session,
    List<CryptoWallet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CryptoWallet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CryptoWallet] and returns the inserted row.
  ///
  /// The returned [CryptoWallet] will have its `id` field set.
  Future<CryptoWallet> insertRow(
    _is.DatabaseSession session,
    CryptoWallet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CryptoWallet>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CryptoWallet]s in the list and returns the resulting rows.
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
  /// The returned [CryptoWallet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CryptoWallet>> upsert(
    _is.DatabaseSession session,
    List<CryptoWallet> rows, {
    required _is.ColumnSelections<CryptoWalletTable> conflictColumns,
    _is.ColumnSelections<CryptoWalletTable>? updateColumns,
    _is.WhereExpressionBuilder<CryptoWalletTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CryptoWallet>(
      rows,
      conflictColumns: conflictColumns(CryptoWallet.t),
      updateColumns: updateColumns?.call(CryptoWallet.t),
      updateWhere: updateWhere?.call(CryptoWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CryptoWallet] and returns the resulting row.
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
  /// The returned [CryptoWallet] will have its `id` field set.
  Future<CryptoWallet?> upsertRow(
    _is.DatabaseSession session,
    CryptoWallet row, {
    required _is.ColumnSelections<CryptoWalletTable> conflictColumns,
    _is.ColumnSelections<CryptoWalletTable>? updateColumns,
    _is.WhereExpressionBuilder<CryptoWalletTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CryptoWallet>(
      row,
      conflictColumns: conflictColumns(CryptoWallet.t),
      updateColumns: updateColumns?.call(CryptoWallet.t),
      updateWhere: updateWhere?.call(CryptoWallet.t),
      transaction: transaction,
    );
  }

  /// Updates all [CryptoWallet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CryptoWallet>> update(
    _is.DatabaseSession session,
    List<CryptoWallet> rows, {
    _is.ColumnSelections<CryptoWalletTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CryptoWallet>(
      rows,
      columns: columns?.call(CryptoWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CryptoWallet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CryptoWallet> updateRow(
    _is.DatabaseSession session,
    CryptoWallet row, {
    _is.ColumnSelections<CryptoWalletTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CryptoWallet>(
      row,
      columns: columns?.call(CryptoWallet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CryptoWallet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CryptoWallet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CryptoWalletUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CryptoWallet>(
      id,
      columnValues: columnValues(CryptoWallet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CryptoWallet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CryptoWallet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CryptoWalletUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CryptoWalletTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CryptoWallet>(
      columnValues: columnValues(CryptoWallet.t.updateTable),
      where: where(CryptoWallet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CryptoWallet]s in the list and returns the deleted rows.
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
  Future<List<CryptoWallet>> delete(
    _is.DatabaseSession session,
    List<CryptoWallet> rows, {
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CryptoWallet>(
      rows,
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CryptoWallet].
  Future<CryptoWallet> deleteRow(
    _is.DatabaseSession session,
    CryptoWallet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CryptoWallet>(
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
  Future<List<CryptoWallet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CryptoWalletTable> where,
    _is.OrderByBuilder<CryptoWalletTable>? orderBy,
    _is.OrderByListBuilder<CryptoWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CryptoWallet>(
      where: where(CryptoWallet.t),
      orderBy: orderBy?.call(CryptoWallet.t),
      orderByList: orderByList?.call(CryptoWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CryptoWalletTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CryptoWallet>(
      where: where?.call(CryptoWallet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CryptoWallet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CryptoWalletTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CryptoWallet>(
      where: where(CryptoWallet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
