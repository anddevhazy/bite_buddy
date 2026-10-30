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

/// A minted keepsake NFT. Its id is the token id on the contract.
abstract class Keepsake
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Keepsake._({
    this.id,
    required this.ownerId,
    required this.key,
    required this.editionGroup,
    required this.edition,
    required this.title,
    required this.emoji,
    required this.petName,
    required this.speciesKey,
    this.portraitId,
    bool? showPaw,
    this.stat,
    required this.earnedAt,
    required this.walletAddress,
    this.txHash,
    required this.chainId,
    required this.mintedAt,
  }) : showPaw = showPaw ?? false;

  factory Keepsake({
    int? id,
    required _is.UuidValue ownerId,
    required String key,
    required String editionGroup,
    required int edition,
    required String title,
    required String emoji,
    required String petName,
    required String speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    required DateTime earnedAt,
    required String walletAddress,
    String? txHash,
    required int chainId,
    required DateTime mintedAt,
  }) = _KeepsakeImpl;

  factory Keepsake.fromJson(Map<String, dynamic> jsonSerialization) {
    return Keepsake(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      key: jsonSerialization['key'] as String,
      editionGroup: jsonSerialization['editionGroup'] as String,
      edition: jsonSerialization['edition'] as int,
      title: jsonSerialization['title'] as String,
      emoji: jsonSerialization['emoji'] as String,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
      showPaw: jsonSerialization['showPaw'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['showPaw']),
      stat: jsonSerialization['stat'] as String?,
      earnedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['earnedAt'],
      ),
      walletAddress: jsonSerialization['walletAddress'] as String,
      txHash: jsonSerialization['txHash'] as String?,
      chainId: jsonSerialization['chainId'] as int,
      mintedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['mintedAt'],
      ),
    );
  }

  static final t = KeepsakeTable();

  static const db = KeepsakeRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  /// What it's for: certificate, streak_30, level_10, meals_100, trophy_...
  String key;

  /// Keepsakes of the same kind are numbered in the order they're minted,
  /// e.g. every 30-day streak shares one count.
  String editionGroup;

  int edition;

  String title;

  String emoji;

  String petName;

  String speciesKey;

  /// The pet's photo at mint time, only if the owner allowed it.
  int? portraitId;

  /// A paw instead of a picture: the buddy is the owner's own pet and they
  /// chose not to show its photo.
  bool showPaw;

  /// One line about that moment, e.g. "Avg meal score 82 that month".
  String? stat;

  DateTime earnedAt;

  String walletAddress;

  /// Null while the mint is being sent.
  String? txHash;

  /// 8453 for Base, 84532 for Base Sepolia, 0 for test mode.
  int chainId;

  DateTime mintedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Keepsake]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Keepsake copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? key,
    String? editionGroup,
    int? edition,
    String? title,
    String? emoji,
    String? petName,
    String? speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    DateTime? earnedAt,
    String? walletAddress,
    String? txHash,
    int? chainId,
    DateTime? mintedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Keepsake',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'key': key,
      'editionGroup': editionGroup,
      'edition': edition,
      'title': title,
      'emoji': emoji,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (stat != null) 'stat': stat,
      'earnedAt': earnedAt.toJson(),
      'walletAddress': walletAddress,
      if (txHash != null) 'txHash': txHash,
      'chainId': chainId,
      'mintedAt': mintedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Keepsake',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'key': key,
      'editionGroup': editionGroup,
      'edition': edition,
      'title': title,
      'emoji': emoji,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (stat != null) 'stat': stat,
      'earnedAt': earnedAt.toJson(),
      'walletAddress': walletAddress,
      if (txHash != null) 'txHash': txHash,
      'chainId': chainId,
      'mintedAt': mintedAt.toJson(),
    };
  }

  static KeepsakeInclude include() {
    return KeepsakeInclude._();
  }

  static KeepsakeIncludeList includeList({
    _is.WhereExpressionBuilder<KeepsakeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    KeepsakeInclude? include,
  }) {
    return KeepsakeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KeepsakeImpl extends Keepsake {
  _KeepsakeImpl({
    int? id,
    required _is.UuidValue ownerId,
    required String key,
    required String editionGroup,
    required int edition,
    required String title,
    required String emoji,
    required String petName,
    required String speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    required DateTime earnedAt,
    required String walletAddress,
    String? txHash,
    required int chainId,
    required DateTime mintedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         key: key,
         editionGroup: editionGroup,
         edition: edition,
         title: title,
         emoji: emoji,
         petName: petName,
         speciesKey: speciesKey,
         portraitId: portraitId,
         showPaw: showPaw,
         stat: stat,
         earnedAt: earnedAt,
         walletAddress: walletAddress,
         txHash: txHash,
         chainId: chainId,
         mintedAt: mintedAt,
       );

  /// Returns a shallow copy of this [Keepsake]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Keepsake copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    String? key,
    String? editionGroup,
    int? edition,
    String? title,
    String? emoji,
    String? petName,
    String? speciesKey,
    Object? portraitId = _Undefined,
    bool? showPaw,
    Object? stat = _Undefined,
    DateTime? earnedAt,
    String? walletAddress,
    Object? txHash = _Undefined,
    int? chainId,
    DateTime? mintedAt,
  }) {
    return Keepsake(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      key: key ?? this.key,
      editionGroup: editionGroup ?? this.editionGroup,
      edition: edition ?? this.edition,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
      showPaw: showPaw ?? this.showPaw,
      stat: stat is String? ? stat : this.stat,
      earnedAt: earnedAt ?? this.earnedAt,
      walletAddress: walletAddress ?? this.walletAddress,
      txHash: txHash is String? ? txHash : this.txHash,
      chainId: chainId ?? this.chainId,
      mintedAt: mintedAt ?? this.mintedAt,
    );
  }
}

class KeepsakeUpdateTable extends _is.UpdateTable<KeepsakeTable> {
  KeepsakeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<String, String> editionGroup(String value) => _is.ColumnValue(
    table.editionGroup,
    value,
  );

  _is.ColumnValue<int, int> edition(int value) => _is.ColumnValue(
    table.edition,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> emoji(String value) => _is.ColumnValue(
    table.emoji,
    value,
  );

  _is.ColumnValue<String, String> petName(String value) => _is.ColumnValue(
    table.petName,
    value,
  );

  _is.ColumnValue<String, String> speciesKey(String value) => _is.ColumnValue(
    table.speciesKey,
    value,
  );

  _is.ColumnValue<int, int> portraitId(int? value) => _is.ColumnValue(
    table.portraitId,
    value,
  );

  _is.ColumnValue<bool, bool> showPaw(bool value) => _is.ColumnValue(
    table.showPaw,
    value,
  );

  _is.ColumnValue<String, String> stat(String? value) => _is.ColumnValue(
    table.stat,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> earnedAt(DateTime value) =>
      _is.ColumnValue(
        table.earnedAt,
        value,
      );

  _is.ColumnValue<String, String> walletAddress(String value) =>
      _is.ColumnValue(
        table.walletAddress,
        value,
      );

  _is.ColumnValue<String, String> txHash(String? value) => _is.ColumnValue(
    table.txHash,
    value,
  );

  _is.ColumnValue<int, int> chainId(int value) => _is.ColumnValue(
    table.chainId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> mintedAt(DateTime value) =>
      _is.ColumnValue(
        table.mintedAt,
        value,
      );
}

class KeepsakeTable extends _is.Table<int?> {
  KeepsakeTable({super.tableRelation}) : super(tableName: 'keepsake') {
    updateTable = KeepsakeUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    key = _is.ColumnString(
      'key',
      this,
    );
    editionGroup = _is.ColumnString(
      'editionGroup',
      this,
    );
    edition = _is.ColumnInt(
      'edition',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    emoji = _is.ColumnString(
      'emoji',
      this,
    );
    petName = _is.ColumnString(
      'petName',
      this,
    );
    speciesKey = _is.ColumnString(
      'speciesKey',
      this,
    );
    portraitId = _is.ColumnInt(
      'portraitId',
      this,
    );
    showPaw = _is.ColumnBool(
      'showPaw',
      this,
      hasDefault: true,
    );
    stat = _is.ColumnString(
      'stat',
      this,
    );
    earnedAt = _is.ColumnDateTime(
      'earnedAt',
      this,
    );
    walletAddress = _is.ColumnString(
      'walletAddress',
      this,
    );
    txHash = _is.ColumnString(
      'txHash',
      this,
    );
    chainId = _is.ColumnInt(
      'chainId',
      this,
    );
    mintedAt = _is.ColumnDateTime(
      'mintedAt',
      this,
    );
  }

  late final KeepsakeUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  /// What it's for: certificate, streak_30, level_10, meals_100, trophy_...
  late final _is.ColumnString key;

  /// Keepsakes of the same kind are numbered in the order they're minted,
  /// e.g. every 30-day streak shares one count.
  late final _is.ColumnString editionGroup;

  late final _is.ColumnInt edition;

  late final _is.ColumnString title;

  late final _is.ColumnString emoji;

  late final _is.ColumnString petName;

  late final _is.ColumnString speciesKey;

  /// The pet's photo at mint time, only if the owner allowed it.
  late final _is.ColumnInt portraitId;

  /// A paw instead of a picture: the buddy is the owner's own pet and they
  /// chose not to show its photo.
  late final _is.ColumnBool showPaw;

  /// One line about that moment, e.g. "Avg meal score 82 that month".
  late final _is.ColumnString stat;

  late final _is.ColumnDateTime earnedAt;

  late final _is.ColumnString walletAddress;

  /// Null while the mint is being sent.
  late final _is.ColumnString txHash;

  /// 8453 for Base, 84532 for Base Sepolia, 0 for test mode.
  late final _is.ColumnInt chainId;

  late final _is.ColumnDateTime mintedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    key,
    editionGroup,
    edition,
    title,
    emoji,
    petName,
    speciesKey,
    portraitId,
    showPaw,
    stat,
    earnedAt,
    walletAddress,
    txHash,
    chainId,
    mintedAt,
  ];
}

class KeepsakeInclude extends _is.IncludeObject {
  KeepsakeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Keepsake.t;
}

class KeepsakeIncludeList extends _is.IncludeList {
  KeepsakeIncludeList._({
    _is.WhereExpressionBuilder<KeepsakeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Keepsake.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Keepsake.t;
}

class KeepsakeRepository {
  const KeepsakeRepository._();

  /// Returns a list of [Keepsake]s matching the given query parameters.
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
  Future<List<Keepsake>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<KeepsakeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Keepsake>(
      where: where?.call(Keepsake.t),
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Keepsake] matching the given query parameters.
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
  Future<Keepsake?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<KeepsakeTable>? where,
    int? offset,
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Keepsake>(
      where: where?.call(Keepsake.t),
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Keepsake] by its [id] or null if no such row exists.
  Future<Keepsake?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Keepsake>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Keepsake]s in the list and returns the inserted rows.
  ///
  /// The returned [Keepsake]s will have their `id` fields set.
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
  Future<List<Keepsake>> insert(
    _is.DatabaseSession session,
    List<Keepsake> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Keepsake>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Keepsake] and returns the inserted row.
  ///
  /// The returned [Keepsake] will have its `id` field set.
  Future<Keepsake> insertRow(
    _is.DatabaseSession session,
    Keepsake row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Keepsake>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Keepsake]s in the list and returns the resulting rows.
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
  /// The returned [Keepsake]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Keepsake>> upsert(
    _is.DatabaseSession session,
    List<Keepsake> rows, {
    required _is.ColumnSelections<KeepsakeTable> conflictColumns,
    _is.ColumnSelections<KeepsakeTable>? updateColumns,
    _is.WhereExpressionBuilder<KeepsakeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Keepsake>(
      rows,
      conflictColumns: conflictColumns(Keepsake.t),
      updateColumns: updateColumns?.call(Keepsake.t),
      updateWhere: updateWhere?.call(Keepsake.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Keepsake] and returns the resulting row.
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
  /// The returned [Keepsake] will have its `id` field set.
  Future<Keepsake?> upsertRow(
    _is.DatabaseSession session,
    Keepsake row, {
    required _is.ColumnSelections<KeepsakeTable> conflictColumns,
    _is.ColumnSelections<KeepsakeTable>? updateColumns,
    _is.WhereExpressionBuilder<KeepsakeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Keepsake>(
      row,
      conflictColumns: conflictColumns(Keepsake.t),
      updateColumns: updateColumns?.call(Keepsake.t),
      updateWhere: updateWhere?.call(Keepsake.t),
      transaction: transaction,
    );
  }

  /// Updates all [Keepsake]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Keepsake>> update(
    _is.DatabaseSession session,
    List<Keepsake> rows, {
    _is.ColumnSelections<KeepsakeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Keepsake>(
      rows,
      columns: columns?.call(Keepsake.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Keepsake]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Keepsake> updateRow(
    _is.DatabaseSession session,
    Keepsake row, {
    _is.ColumnSelections<KeepsakeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Keepsake>(
      row,
      columns: columns?.call(Keepsake.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Keepsake] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Keepsake?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<KeepsakeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Keepsake>(
      id,
      columnValues: columnValues(Keepsake.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Keepsake]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Keepsake>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<KeepsakeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<KeepsakeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Keepsake>(
      columnValues: columnValues(Keepsake.t.updateTable),
      where: where(Keepsake.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Keepsake]s in the list and returns the deleted rows.
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
  Future<List<Keepsake>> delete(
    _is.DatabaseSession session,
    List<Keepsake> rows, {
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Keepsake>(
      rows,
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Keepsake].
  Future<Keepsake> deleteRow(
    _is.DatabaseSession session,
    Keepsake row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Keepsake>(
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
  Future<List<Keepsake>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<KeepsakeTable> where,
    _is.OrderByBuilder<KeepsakeTable>? orderBy,
    _is.OrderByListBuilder<KeepsakeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Keepsake>(
      where: where(Keepsake.t),
      orderBy: orderBy?.call(Keepsake.t),
      orderByList: orderByList?.call(Keepsake.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<KeepsakeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Keepsake>(
      where: where?.call(Keepsake.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Keepsake] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<KeepsakeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Keepsake>(
      where: where(Keepsake.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
