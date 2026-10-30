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
import 'arena_run_status.dart' as _ic5j8p21;

/// One real-time fight against a computer opponent. The fight itself runs on
/// the phone; the server fixes the fighters when it starts and checks the
/// reported result is possible before paying out.
abstract class ArenaRun
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ArenaRun._({
    this.id,
    required this.ownerId,
    required this.petId,
    required this.opponentKey,
    required this.petMaxHp,
    required this.petAttack,
    required this.petDefense,
    required this.startedAt,
    required this.status,
    this.finishedAt,
    this.durationMs,
    this.damageDealt,
    this.damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) : verified = verified ?? true,
       coinsEarned = coinsEarned ?? 0,
       xpEarned = xpEarned ?? 0,
       energyChange = energyChange ?? 0;

  factory ArenaRun({
    int? id,
    required _is.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required DateTime startedAt,
    required _ic5j8p21.ArenaRunStatus status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) = _ArenaRunImpl;

  factory ArenaRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRun(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      petId: jsonSerialization['petId'] as int,
      opponentKey: jsonSerialization['opponentKey'] as String,
      petMaxHp: jsonSerialization['petMaxHp'] as int,
      petAttack: jsonSerialization['petAttack'] as int,
      petDefense: jsonSerialization['petDefense'] as int,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      status: _ic5j8p21.ArenaRunStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
      durationMs: jsonSerialization['durationMs'] as int?,
      damageDealt: jsonSerialization['damageDealt'] as int?,
      damageTaken: jsonSerialization['damageTaken'] as int?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      coinsEarned: jsonSerialization['coinsEarned'] as int?,
      xpEarned: jsonSerialization['xpEarned'] as int?,
      energyChange: jsonSerialization['energyChange'] as int?,
    );
  }

  static final t = ArenaRunTable();

  static const db = ArenaRunRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  int petId;

  String opponentKey;

  int petMaxHp;

  int petAttack;

  int petDefense;

  DateTime startedAt;

  _ic5j8p21.ArenaRunStatus status;

  DateTime? finishedAt;

  int? durationMs;

  int? damageDealt;

  int? damageTaken;

  /// False when a reported win failed the plausibility check (counted as a
  /// loss).
  bool verified;

  int coinsEarned;

  int xpEarned;

  int energyChange;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ArenaRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArenaRun copyWith({
    int? id,
    _is.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    DateTime? startedAt,
    _ic5j8p21.ArenaRunStatus? status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRun',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'startedAt': startedAt.toJson(),
      'status': status.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      if (durationMs != null) 'durationMs': durationMs,
      if (damageDealt != null) 'damageDealt': damageDealt,
      if (damageTaken != null) 'damageTaken': damageTaken,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRun',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'startedAt': startedAt.toJson(),
      'status': status.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      if (durationMs != null) 'durationMs': durationMs,
      if (damageDealt != null) 'damageDealt': damageDealt,
      if (damageTaken != null) 'damageTaken': damageTaken,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
    };
  }

  static ArenaRunInclude include() {
    return ArenaRunInclude._();
  }

  static ArenaRunIncludeList includeList({
    _is.WhereExpressionBuilder<ArenaRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    ArenaRunInclude? include,
  }) {
    return ArenaRunIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArenaRunImpl extends ArenaRun {
  _ArenaRunImpl({
    int? id,
    required _is.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required DateTime startedAt,
    required _ic5j8p21.ArenaRunStatus status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) : super._(
         id: id,
         ownerId: ownerId,
         petId: petId,
         opponentKey: opponentKey,
         petMaxHp: petMaxHp,
         petAttack: petAttack,
         petDefense: petDefense,
         startedAt: startedAt,
         status: status,
         finishedAt: finishedAt,
         durationMs: durationMs,
         damageDealt: damageDealt,
         damageTaken: damageTaken,
         verified: verified,
         coinsEarned: coinsEarned,
         xpEarned: xpEarned,
         energyChange: energyChange,
       );

  /// Returns a shallow copy of this [ArenaRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArenaRun copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    DateTime? startedAt,
    _ic5j8p21.ArenaRunStatus? status,
    Object? finishedAt = _Undefined,
    Object? durationMs = _Undefined,
    Object? damageDealt = _Undefined,
    Object? damageTaken = _Undefined,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) {
    return ArenaRun(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      petId: petId ?? this.petId,
      opponentKey: opponentKey ?? this.opponentKey,
      petMaxHp: petMaxHp ?? this.petMaxHp,
      petAttack: petAttack ?? this.petAttack,
      petDefense: petDefense ?? this.petDefense,
      startedAt: startedAt ?? this.startedAt,
      status: status ?? this.status,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
      durationMs: durationMs is int? ? durationMs : this.durationMs,
      damageDealt: damageDealt is int? ? damageDealt : this.damageDealt,
      damageTaken: damageTaken is int? ? damageTaken : this.damageTaken,
      verified: verified ?? this.verified,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      energyChange: energyChange ?? this.energyChange,
    );
  }
}

class ArenaRunUpdateTable extends _is.UpdateTable<ArenaRunTable> {
  ArenaRunUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<int, int> petId(int value) => _is.ColumnValue(
    table.petId,
    value,
  );

  _is.ColumnValue<String, String> opponentKey(String value) => _is.ColumnValue(
    table.opponentKey,
    value,
  );

  _is.ColumnValue<int, int> petMaxHp(int value) => _is.ColumnValue(
    table.petMaxHp,
    value,
  );

  _is.ColumnValue<int, int> petAttack(int value) => _is.ColumnValue(
    table.petAttack,
    value,
  );

  _is.ColumnValue<int, int> petDefense(int value) => _is.ColumnValue(
    table.petDefense,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<_ic5j8p21.ArenaRunStatus, _ic5j8p21.ArenaRunStatus> status(
    _ic5j8p21.ArenaRunStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> finishedAt(DateTime? value) =>
      _is.ColumnValue(
        table.finishedAt,
        value,
      );

  _is.ColumnValue<int, int> durationMs(int? value) => _is.ColumnValue(
    table.durationMs,
    value,
  );

  _is.ColumnValue<int, int> damageDealt(int? value) => _is.ColumnValue(
    table.damageDealt,
    value,
  );

  _is.ColumnValue<int, int> damageTaken(int? value) => _is.ColumnValue(
    table.damageTaken,
    value,
  );

  _is.ColumnValue<bool, bool> verified(bool value) => _is.ColumnValue(
    table.verified,
    value,
  );

  _is.ColumnValue<int, int> coinsEarned(int value) => _is.ColumnValue(
    table.coinsEarned,
    value,
  );

  _is.ColumnValue<int, int> xpEarned(int value) => _is.ColumnValue(
    table.xpEarned,
    value,
  );

  _is.ColumnValue<int, int> energyChange(int value) => _is.ColumnValue(
    table.energyChange,
    value,
  );
}

class ArenaRunTable extends _is.Table<int?> {
  ArenaRunTable({super.tableRelation}) : super(tableName: 'arena_run') {
    updateTable = ArenaRunUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    petId = _is.ColumnInt(
      'petId',
      this,
    );
    opponentKey = _is.ColumnString(
      'opponentKey',
      this,
    );
    petMaxHp = _is.ColumnInt(
      'petMaxHp',
      this,
    );
    petAttack = _is.ColumnInt(
      'petAttack',
      this,
    );
    petDefense = _is.ColumnInt(
      'petDefense',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    finishedAt = _is.ColumnDateTime(
      'finishedAt',
      this,
    );
    durationMs = _is.ColumnInt(
      'durationMs',
      this,
    );
    damageDealt = _is.ColumnInt(
      'damageDealt',
      this,
    );
    damageTaken = _is.ColumnInt(
      'damageTaken',
      this,
    );
    verified = _is.ColumnBool(
      'verified',
      this,
      hasDefault: true,
    );
    coinsEarned = _is.ColumnInt(
      'coinsEarned',
      this,
      hasDefault: true,
    );
    xpEarned = _is.ColumnInt(
      'xpEarned',
      this,
      hasDefault: true,
    );
    energyChange = _is.ColumnInt(
      'energyChange',
      this,
      hasDefault: true,
    );
  }

  late final ArenaRunUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnInt petId;

  late final _is.ColumnString opponentKey;

  late final _is.ColumnInt petMaxHp;

  late final _is.ColumnInt petAttack;

  late final _is.ColumnInt petDefense;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnEnum<_ic5j8p21.ArenaRunStatus> status;

  late final _is.ColumnDateTime finishedAt;

  late final _is.ColumnInt durationMs;

  late final _is.ColumnInt damageDealt;

  late final _is.ColumnInt damageTaken;

  /// False when a reported win failed the plausibility check (counted as a
  /// loss).
  late final _is.ColumnBool verified;

  late final _is.ColumnInt coinsEarned;

  late final _is.ColumnInt xpEarned;

  late final _is.ColumnInt energyChange;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    petId,
    opponentKey,
    petMaxHp,
    petAttack,
    petDefense,
    startedAt,
    status,
    finishedAt,
    durationMs,
    damageDealt,
    damageTaken,
    verified,
    coinsEarned,
    xpEarned,
    energyChange,
  ];
}

class ArenaRunInclude extends _is.IncludeObject {
  ArenaRunInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ArenaRun.t;
}

class ArenaRunIncludeList extends _is.IncludeList {
  ArenaRunIncludeList._({
    _is.WhereExpressionBuilder<ArenaRunTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArenaRun.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ArenaRun.t;
}

class ArenaRunRepository {
  const ArenaRunRepository._();

  /// Returns a list of [ArenaRun]s matching the given query parameters.
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
  Future<List<ArenaRun>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArenaRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ArenaRun>(
      where: where?.call(ArenaRun.t),
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ArenaRun] matching the given query parameters.
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
  Future<ArenaRun?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArenaRunTable>? where,
    int? offset,
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ArenaRun>(
      where: where?.call(ArenaRun.t),
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ArenaRun] by its [id] or null if no such row exists.
  Future<ArenaRun?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ArenaRun>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ArenaRun]s in the list and returns the inserted rows.
  ///
  /// The returned [ArenaRun]s will have their `id` fields set.
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
  Future<List<ArenaRun>> insert(
    _is.DatabaseSession session,
    List<ArenaRun> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ArenaRun>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ArenaRun] and returns the inserted row.
  ///
  /// The returned [ArenaRun] will have its `id` field set.
  Future<ArenaRun> insertRow(
    _is.DatabaseSession session,
    ArenaRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArenaRun>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ArenaRun]s in the list and returns the resulting rows.
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
  /// The returned [ArenaRun]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArenaRun>> upsert(
    _is.DatabaseSession session,
    List<ArenaRun> rows, {
    required _is.ColumnSelections<ArenaRunTable> conflictColumns,
    _is.ColumnSelections<ArenaRunTable>? updateColumns,
    _is.WhereExpressionBuilder<ArenaRunTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ArenaRun>(
      rows,
      conflictColumns: conflictColumns(ArenaRun.t),
      updateColumns: updateColumns?.call(ArenaRun.t),
      updateWhere: updateWhere?.call(ArenaRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ArenaRun] and returns the resulting row.
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
  /// The returned [ArenaRun] will have its `id` field set.
  Future<ArenaRun?> upsertRow(
    _is.DatabaseSession session,
    ArenaRun row, {
    required _is.ColumnSelections<ArenaRunTable> conflictColumns,
    _is.ColumnSelections<ArenaRunTable>? updateColumns,
    _is.WhereExpressionBuilder<ArenaRunTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ArenaRun>(
      row,
      conflictColumns: conflictColumns(ArenaRun.t),
      updateColumns: updateColumns?.call(ArenaRun.t),
      updateWhere: updateWhere?.call(ArenaRun.t),
      transaction: transaction,
    );
  }

  /// Updates all [ArenaRun]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArenaRun>> update(
    _is.DatabaseSession session,
    List<ArenaRun> rows, {
    _is.ColumnSelections<ArenaRunTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ArenaRun>(
      rows,
      columns: columns?.call(ArenaRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ArenaRun]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArenaRun> updateRow(
    _is.DatabaseSession session,
    ArenaRun row, {
    _is.ColumnSelections<ArenaRunTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArenaRun>(
      row,
      columns: columns?.call(ArenaRun.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArenaRun] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ArenaRun?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ArenaRunUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ArenaRun>(
      id,
      columnValues: columnValues(ArenaRun.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ArenaRun]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArenaRun>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ArenaRunUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ArenaRunTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ArenaRun>(
      columnValues: columnValues(ArenaRun.t.updateTable),
      where: where(ArenaRun.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ArenaRun]s in the list and returns the deleted rows.
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
  Future<List<ArenaRun>> delete(
    _is.DatabaseSession session,
    List<ArenaRun> rows, {
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ArenaRun>(
      rows,
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ArenaRun].
  Future<ArenaRun> deleteRow(
    _is.DatabaseSession session,
    ArenaRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArenaRun>(
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
  Future<List<ArenaRun>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArenaRunTable> where,
    _is.OrderByBuilder<ArenaRunTable>? orderBy,
    _is.OrderByListBuilder<ArenaRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ArenaRun>(
      where: where(ArenaRun.t),
      orderBy: orderBy?.call(ArenaRun.t),
      orderByList: orderByList?.call(ArenaRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArenaRunTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ArenaRun>(
      where: where?.call(ArenaRun.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ArenaRun] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArenaRunTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ArenaRun>(
      where: where(ArenaRun.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
