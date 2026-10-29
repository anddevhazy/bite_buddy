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
import 'battle_move.dart' as _iz303hum;
import 'battle_round.dart' as _imrf8vtu;
import 'battle_status.dart' as _ib4xlijd;

/// A battle between the user's pet and a catalog opponent, resolved round by
/// round on the server.
abstract class Battle implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Battle._({
    this.id,
    required this.ownerId,
    required this.petId,
    required this.opponentKey,
    required this.petHp,
    required this.petMaxHp,
    required this.petAttack,
    required this.petDefense,
    required this.opponentHp,
    required this.opponentMaxHp,
    required this.round,
    required this.status,
    required this.specialCooldown,
    required this.opponentSpecialCooldown,
    this.opponentNextMove,
    this.opponentTell,
    this.lastRound,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
    required this.createdAt,
  });

  factory Battle({
    int? id,
    required _is.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petHp,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required int opponentHp,
    required int opponentMaxHp,
    required int round,
    required _ib4xlijd.BattleStatus status,
    required int specialCooldown,
    required int opponentSpecialCooldown,
    _iz303hum.BattleMove? opponentNextMove,
    _iz303hum.BattleMove? opponentTell,
    _imrf8vtu.BattleRound? lastRound,
    required int coinsEarned,
    required int xpEarned,
    required int energyChange,
    required DateTime createdAt,
  }) = _BattleImpl;

  factory Battle.fromJson(Map<String, dynamic> jsonSerialization) {
    return Battle(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      petId: jsonSerialization['petId'] as int,
      opponentKey: jsonSerialization['opponentKey'] as String,
      petHp: jsonSerialization['petHp'] as int,
      petMaxHp: jsonSerialization['petMaxHp'] as int,
      petAttack: jsonSerialization['petAttack'] as int,
      petDefense: jsonSerialization['petDefense'] as int,
      opponentHp: jsonSerialization['opponentHp'] as int,
      opponentMaxHp: jsonSerialization['opponentMaxHp'] as int,
      round: jsonSerialization['round'] as int,
      status: _ib4xlijd.BattleStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      specialCooldown: jsonSerialization['specialCooldown'] as int,
      opponentSpecialCooldown:
          jsonSerialization['opponentSpecialCooldown'] as int,
      opponentNextMove: jsonSerialization['opponentNextMove'] == null
          ? null
          : _iz303hum.BattleMove.fromJson(
              (jsonSerialization['opponentNextMove'] as String),
            ),
      opponentTell: jsonSerialization['opponentTell'] == null
          ? null
          : _iz303hum.BattleMove.fromJson(
              (jsonSerialization['opponentTell'] as String),
            ),
      lastRound: jsonSerialization['lastRound'] == null
          ? null
          : _i61ow1lb.Protocol().deserialize<_imrf8vtu.BattleRound>(
              jsonSerialization['lastRound'],
            ),
      coinsEarned: jsonSerialization['coinsEarned'] as int,
      xpEarned: jsonSerialization['xpEarned'] as int,
      energyChange: jsonSerialization['energyChange'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = BattleTable();

  static const db = BattleRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  int petId;

  String opponentKey;

  int petHp;

  int petMaxHp;

  int petAttack;

  int petDefense;

  int opponentHp;

  int opponentMaxHp;

  int round;

  _ib4xlijd.BattleStatus status;

  /// Rounds until Special can be used again; 0 means ready.
  int specialCooldown;

  int opponentSpecialCooldown;

  /// The move the opponent will make next round. Decided a round ahead so a
  /// tell can hint at it; never sent to the app.
  _iz303hum.BattleMove? opponentNextMove;

  /// What the opponent appears to be doing next (usually, not always, true).
  _iz303hum.BattleMove? opponentTell;

  _imrf8vtu.BattleRound? lastRound;

  int coinsEarned;

  int xpEarned;

  int energyChange;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Battle copyWith({
    int? id,
    _is.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petHp,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    int? opponentHp,
    int? opponentMaxHp,
    int? round,
    _ib4xlijd.BattleStatus? status,
    int? specialCooldown,
    int? opponentSpecialCooldown,
    _iz303hum.BattleMove? opponentNextMove,
    _iz303hum.BattleMove? opponentTell,
    _imrf8vtu.BattleRound? lastRound,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Battle',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petHp': petHp,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'opponentHp': opponentHp,
      'opponentMaxHp': opponentMaxHp,
      'round': round,
      'status': status.toJson(),
      'specialCooldown': specialCooldown,
      'opponentSpecialCooldown': opponentSpecialCooldown,
      if (opponentNextMove != null)
        'opponentNextMove': opponentNextMove?.toJson(),
      if (opponentTell != null) 'opponentTell': opponentTell?.toJson(),
      if (lastRound != null) 'lastRound': lastRound?.toJson(),
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Battle',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petHp': petHp,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'opponentHp': opponentHp,
      'opponentMaxHp': opponentMaxHp,
      'round': round,
      'status': status.toJson(),
      'specialCooldown': specialCooldown,
      'opponentSpecialCooldown': opponentSpecialCooldown,
      if (opponentTell != null) 'opponentTell': opponentTell?.toJson(),
      if (lastRound != null) 'lastRound': lastRound?.toJsonForProtocol(),
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
      'createdAt': createdAt.toJson(),
    };
  }

  static BattleInclude include() {
    return BattleInclude._();
  }

  static BattleIncludeList includeList({
    _is.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    BattleInclude? include,
  }) {
    return BattleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattleImpl extends Battle {
  _BattleImpl({
    int? id,
    required _is.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petHp,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required int opponentHp,
    required int opponentMaxHp,
    required int round,
    required _ib4xlijd.BattleStatus status,
    required int specialCooldown,
    required int opponentSpecialCooldown,
    _iz303hum.BattleMove? opponentNextMove,
    _iz303hum.BattleMove? opponentTell,
    _imrf8vtu.BattleRound? lastRound,
    required int coinsEarned,
    required int xpEarned,
    required int energyChange,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         petId: petId,
         opponentKey: opponentKey,
         petHp: petHp,
         petMaxHp: petMaxHp,
         petAttack: petAttack,
         petDefense: petDefense,
         opponentHp: opponentHp,
         opponentMaxHp: opponentMaxHp,
         round: round,
         status: status,
         specialCooldown: specialCooldown,
         opponentSpecialCooldown: opponentSpecialCooldown,
         opponentNextMove: opponentNextMove,
         opponentTell: opponentTell,
         lastRound: lastRound,
         coinsEarned: coinsEarned,
         xpEarned: xpEarned,
         energyChange: energyChange,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Battle copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petHp,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    int? opponentHp,
    int? opponentMaxHp,
    int? round,
    _ib4xlijd.BattleStatus? status,
    int? specialCooldown,
    int? opponentSpecialCooldown,
    Object? opponentNextMove = _Undefined,
    Object? opponentTell = _Undefined,
    Object? lastRound = _Undefined,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
    DateTime? createdAt,
  }) {
    return Battle(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      petId: petId ?? this.petId,
      opponentKey: opponentKey ?? this.opponentKey,
      petHp: petHp ?? this.petHp,
      petMaxHp: petMaxHp ?? this.petMaxHp,
      petAttack: petAttack ?? this.petAttack,
      petDefense: petDefense ?? this.petDefense,
      opponentHp: opponentHp ?? this.opponentHp,
      opponentMaxHp: opponentMaxHp ?? this.opponentMaxHp,
      round: round ?? this.round,
      status: status ?? this.status,
      specialCooldown: specialCooldown ?? this.specialCooldown,
      opponentSpecialCooldown:
          opponentSpecialCooldown ?? this.opponentSpecialCooldown,
      opponentNextMove: opponentNextMove is _iz303hum.BattleMove?
          ? opponentNextMove
          : this.opponentNextMove,
      opponentTell: opponentTell is _iz303hum.BattleMove?
          ? opponentTell
          : this.opponentTell,
      lastRound: lastRound is _imrf8vtu.BattleRound?
          ? lastRound
          : this.lastRound?.copyWith(),
      coinsEarned: coinsEarned ?? this.coinsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      energyChange: energyChange ?? this.energyChange,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BattleUpdateTable extends _is.UpdateTable<BattleTable> {
  BattleUpdateTable(super.table);

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

  _is.ColumnValue<int, int> petHp(int value) => _is.ColumnValue(
    table.petHp,
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

  _is.ColumnValue<int, int> opponentHp(int value) => _is.ColumnValue(
    table.opponentHp,
    value,
  );

  _is.ColumnValue<int, int> opponentMaxHp(int value) => _is.ColumnValue(
    table.opponentMaxHp,
    value,
  );

  _is.ColumnValue<int, int> round(int value) => _is.ColumnValue(
    table.round,
    value,
  );

  _is.ColumnValue<_ib4xlijd.BattleStatus, _ib4xlijd.BattleStatus> status(
    _ib4xlijd.BattleStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> specialCooldown(int value) => _is.ColumnValue(
    table.specialCooldown,
    value,
  );

  _is.ColumnValue<int, int> opponentSpecialCooldown(int value) =>
      _is.ColumnValue(
        table.opponentSpecialCooldown,
        value,
      );

  _is.ColumnValue<_iz303hum.BattleMove, _iz303hum.BattleMove> opponentNextMove(
    _iz303hum.BattleMove? value,
  ) => _is.ColumnValue(
    table.opponentNextMove,
    value,
  );

  _is.ColumnValue<_iz303hum.BattleMove, _iz303hum.BattleMove> opponentTell(
    _iz303hum.BattleMove? value,
  ) => _is.ColumnValue(
    table.opponentTell,
    value,
  );

  _is.ColumnValue<_imrf8vtu.BattleRound, _imrf8vtu.BattleRound> lastRound(
    _imrf8vtu.BattleRound? value,
  ) => _is.ColumnValue(
    table.lastRound,
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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BattleTable extends _is.Table<int?> {
  BattleTable({super.tableRelation}) : super(tableName: 'battle') {
    updateTable = BattleUpdateTable(this);
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
    petHp = _is.ColumnInt(
      'petHp',
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
    opponentHp = _is.ColumnInt(
      'opponentHp',
      this,
    );
    opponentMaxHp = _is.ColumnInt(
      'opponentMaxHp',
      this,
    );
    round = _is.ColumnInt(
      'round',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    specialCooldown = _is.ColumnInt(
      'specialCooldown',
      this,
    );
    opponentSpecialCooldown = _is.ColumnInt(
      'opponentSpecialCooldown',
      this,
    );
    opponentNextMove = _is.ColumnEnum(
      'opponentNextMove',
      this,
      _is.EnumSerialization.byName,
    );
    opponentTell = _is.ColumnEnum(
      'opponentTell',
      this,
      _is.EnumSerialization.byName,
    );
    lastRound = _is.ColumnSerializable<_imrf8vtu.BattleRound>(
      'lastRound',
      this,
    );
    coinsEarned = _is.ColumnInt(
      'coinsEarned',
      this,
    );
    xpEarned = _is.ColumnInt(
      'xpEarned',
      this,
    );
    energyChange = _is.ColumnInt(
      'energyChange',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final BattleUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnInt petId;

  late final _is.ColumnString opponentKey;

  late final _is.ColumnInt petHp;

  late final _is.ColumnInt petMaxHp;

  late final _is.ColumnInt petAttack;

  late final _is.ColumnInt petDefense;

  late final _is.ColumnInt opponentHp;

  late final _is.ColumnInt opponentMaxHp;

  late final _is.ColumnInt round;

  late final _is.ColumnEnum<_ib4xlijd.BattleStatus> status;

  /// Rounds until Special can be used again; 0 means ready.
  late final _is.ColumnInt specialCooldown;

  late final _is.ColumnInt opponentSpecialCooldown;

  /// The move the opponent will make next round. Decided a round ahead so a
  /// tell can hint at it; never sent to the app.
  late final _is.ColumnEnum<_iz303hum.BattleMove> opponentNextMove;

  /// What the opponent appears to be doing next (usually, not always, true).
  late final _is.ColumnEnum<_iz303hum.BattleMove> opponentTell;

  late final _is.ColumnSerializable<_imrf8vtu.BattleRound> lastRound;

  late final _is.ColumnInt coinsEarned;

  late final _is.ColumnInt xpEarned;

  late final _is.ColumnInt energyChange;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    petId,
    opponentKey,
    petHp,
    petMaxHp,
    petAttack,
    petDefense,
    opponentHp,
    opponentMaxHp,
    round,
    status,
    specialCooldown,
    opponentSpecialCooldown,
    opponentNextMove,
    opponentTell,
    lastRound,
    coinsEarned,
    xpEarned,
    energyChange,
    createdAt,
  ];
}

class BattleInclude extends _is.IncludeObject {
  BattleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Battle.t;
}

class BattleIncludeList extends _is.IncludeList {
  BattleIncludeList._({
    _is.WhereExpressionBuilder<BattleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Battle.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Battle.t;
}

class BattleRepository {
  const BattleRepository._();

  /// Returns a list of [Battle]s matching the given query parameters.
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
  Future<List<Battle>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Battle>(
      where: where?.call(Battle.t),
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Battle] matching the given query parameters.
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
  Future<Battle?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BattleTable>? where,
    int? offset,
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Battle>(
      where: where?.call(Battle.t),
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Battle] by its [id] or null if no such row exists.
  Future<Battle?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Battle>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Battle]s in the list and returns the inserted rows.
  ///
  /// The returned [Battle]s will have their `id` fields set.
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
  Future<List<Battle>> insert(
    _is.DatabaseSession session,
    List<Battle> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Battle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Battle] and returns the inserted row.
  ///
  /// The returned [Battle] will have its `id` field set.
  Future<Battle> insertRow(
    _is.DatabaseSession session,
    Battle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Battle>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Battle]s in the list and returns the resulting rows.
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
  /// The returned [Battle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Battle>> upsert(
    _is.DatabaseSession session,
    List<Battle> rows, {
    required _is.ColumnSelections<BattleTable> conflictColumns,
    _is.ColumnSelections<BattleTable>? updateColumns,
    _is.WhereExpressionBuilder<BattleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Battle>(
      rows,
      conflictColumns: conflictColumns(Battle.t),
      updateColumns: updateColumns?.call(Battle.t),
      updateWhere: updateWhere?.call(Battle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Battle] and returns the resulting row.
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
  /// The returned [Battle] will have its `id` field set.
  Future<Battle?> upsertRow(
    _is.DatabaseSession session,
    Battle row, {
    required _is.ColumnSelections<BattleTable> conflictColumns,
    _is.ColumnSelections<BattleTable>? updateColumns,
    _is.WhereExpressionBuilder<BattleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Battle>(
      row,
      conflictColumns: conflictColumns(Battle.t),
      updateColumns: updateColumns?.call(Battle.t),
      updateWhere: updateWhere?.call(Battle.t),
      transaction: transaction,
    );
  }

  /// Updates all [Battle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Battle>> update(
    _is.DatabaseSession session,
    List<Battle> rows, {
    _is.ColumnSelections<BattleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Battle>(
      rows,
      columns: columns?.call(Battle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Battle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Battle> updateRow(
    _is.DatabaseSession session,
    Battle row, {
    _is.ColumnSelections<BattleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Battle>(
      row,
      columns: columns?.call(Battle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Battle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Battle?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BattleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Battle>(
      id,
      columnValues: columnValues(Battle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Battle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Battle>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BattleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BattleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Battle>(
      columnValues: columnValues(Battle.t.updateTable),
      where: where(Battle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Battle]s in the list and returns the deleted rows.
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
  Future<List<Battle>> delete(
    _is.DatabaseSession session,
    List<Battle> rows, {
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Battle>(
      rows,
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Battle].
  Future<Battle> deleteRow(
    _is.DatabaseSession session,
    Battle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Battle>(
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
  Future<List<Battle>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BattleTable> where,
    _is.OrderByBuilder<BattleTable>? orderBy,
    _is.OrderByListBuilder<BattleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Battle>(
      where: where(Battle.t),
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Battle>(
      where: where?.call(Battle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Battle] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BattleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Battle>(
      where: where(Battle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
