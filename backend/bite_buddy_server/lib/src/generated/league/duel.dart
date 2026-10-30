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
import '../battle_move.dart' as _iqs6dnj5;
import '../league/duel_round.dart' as _i03zsgo2;
import '../league/duel_status.dart' as _i9fupah8;

/// A turn-based battle between two league friends, played asynchronously:
/// each round both pick a move in secret, and the round resolves once both
/// have (or the deadline passes). Side A challenged side B.
abstract class Duel implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Duel._({
    this.id,
    required this.leagueId,
    required this.weekStart,
    required this.aUserId,
    required this.bUserId,
    required this.aPetName,
    required this.bPetName,
    required this.aSpeciesKey,
    required this.bSpeciesKey,
    required this.aMaxHp,
    required this.bMaxHp,
    required this.aAttack,
    required this.bAttack,
    required this.aDefense,
    required this.bDefense,
    required this.aHp,
    required this.bHp,
    required this.aSpecialCooldown,
    required this.bSpecialCooldown,
    this.aMove,
    this.bMove,
    required this.aMissed,
    required this.bMissed,
    required this.aHistory,
    required this.bHistory,
    required this.round,
    required this.roundDeadline,
    required this.status,
    this.winnerUserId,
    this.endReason,
    this.lastRound,
    required this.createdAt,
    this.finishedAt,
  });

  factory Duel({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    required _is.UuidValue aUserId,
    required _is.UuidValue bUserId,
    required String aPetName,
    required String bPetName,
    required String aSpeciesKey,
    required String bSpeciesKey,
    required int aMaxHp,
    required int bMaxHp,
    required int aAttack,
    required int bAttack,
    required int aDefense,
    required int bDefense,
    required int aHp,
    required int bHp,
    required int aSpecialCooldown,
    required int bSpecialCooldown,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    required int aMissed,
    required int bMissed,
    required List<_iqs6dnj5.BattleMove?> aHistory,
    required List<_iqs6dnj5.BattleMove?> bHistory,
    required int round,
    required DateTime roundDeadline,
    required _i9fupah8.DuelStatus status,
    _is.UuidValue? winnerUserId,
    String? endReason,
    _i03zsgo2.DuelRound? lastRound,
    required DateTime createdAt,
    DateTime? finishedAt,
  }) = _DuelImpl;

  factory Duel.fromJson(Map<String, dynamic> jsonSerialization) {
    return Duel(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      weekStart: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      aUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['aUserId'],
      ),
      bUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['bUserId'],
      ),
      aPetName: jsonSerialization['aPetName'] as String,
      bPetName: jsonSerialization['bPetName'] as String,
      aSpeciesKey: jsonSerialization['aSpeciesKey'] as String,
      bSpeciesKey: jsonSerialization['bSpeciesKey'] as String,
      aMaxHp: jsonSerialization['aMaxHp'] as int,
      bMaxHp: jsonSerialization['bMaxHp'] as int,
      aAttack: jsonSerialization['aAttack'] as int,
      bAttack: jsonSerialization['bAttack'] as int,
      aDefense: jsonSerialization['aDefense'] as int,
      bDefense: jsonSerialization['bDefense'] as int,
      aHp: jsonSerialization['aHp'] as int,
      bHp: jsonSerialization['bHp'] as int,
      aSpecialCooldown: jsonSerialization['aSpecialCooldown'] as int,
      bSpecialCooldown: jsonSerialization['bSpecialCooldown'] as int,
      aMove: jsonSerialization['aMove'] == null
          ? null
          : _iqs6dnj5.BattleMove.fromJson(
              (jsonSerialization['aMove'] as String),
            ),
      bMove: jsonSerialization['bMove'] == null
          ? null
          : _iqs6dnj5.BattleMove.fromJson(
              (jsonSerialization['bMove'] as String),
            ),
      aMissed: jsonSerialization['aMissed'] as int,
      bMissed: jsonSerialization['bMissed'] as int,
      aHistory: _i61ow1lb.Protocol().deserialize<List<_iqs6dnj5.BattleMove?>>(
        jsonSerialization['aHistory'],
      ),
      bHistory: _i61ow1lb.Protocol().deserialize<List<_iqs6dnj5.BattleMove?>>(
        jsonSerialization['bHistory'],
      ),
      round: jsonSerialization['round'] as int,
      roundDeadline: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['roundDeadline'],
      ),
      status: _i9fupah8.DuelStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      winnerUserId: jsonSerialization['winnerUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['winnerUserId'],
            ),
      endReason: jsonSerialization['endReason'] as String?,
      lastRound: jsonSerialization['lastRound'] == null
          ? null
          : _i61ow1lb.Protocol().deserialize<_i03zsgo2.DuelRound>(
              jsonSerialization['lastRound'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
    );
  }

  static final t = DuelTable();

  static const db = DuelRepository._();

  @override
  int? id;

  int leagueId;

  /// Monday of the season week it was started in; its wins count there.
  DateTime weekStart;

  _is.UuidValue aUserId;

  _is.UuidValue bUserId;

  String aPetName;

  String bPetName;

  String aSpeciesKey;

  String bSpeciesKey;

  /// Fighter stats, fixed when the duel starts.
  int aMaxHp;

  int bMaxHp;

  int aAttack;

  int bAttack;

  int aDefense;

  int bDefense;

  int aHp;

  int bHp;

  int aSpecialCooldown;

  int bSpecialCooldown;

  /// This round's secret moves. Never sent to the app.
  _iqs6dnj5.BattleMove? aMove;

  _iqs6dnj5.BattleMove? bMove;

  /// Rounds each side has missed in a row; two means they forfeit.
  int aMissed;

  int bMissed;

  /// Every move each side has made, oldest first (null for a missed round).
  List<_iqs6dnj5.BattleMove?> aHistory;

  List<_iqs6dnj5.BattleMove?> bHistory;

  int round;

  DateTime roundDeadline;

  _i9fupah8.DuelStatus status;

  /// Null while ongoing, and for a draw.
  _is.UuidValue? winnerUserId;

  /// How it ended: "Knockout", "Forfeit" or "Time's up". Null while ongoing.
  String? endReason;

  _i03zsgo2.DuelRound? lastRound;

  DateTime createdAt;

  DateTime? finishedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Duel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Duel copyWith({
    int? id,
    int? leagueId,
    DateTime? weekStart,
    _is.UuidValue? aUserId,
    _is.UuidValue? bUserId,
    String? aPetName,
    String? bPetName,
    String? aSpeciesKey,
    String? bSpeciesKey,
    int? aMaxHp,
    int? bMaxHp,
    int? aAttack,
    int? bAttack,
    int? aDefense,
    int? bDefense,
    int? aHp,
    int? bHp,
    int? aSpecialCooldown,
    int? bSpecialCooldown,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    int? aMissed,
    int? bMissed,
    List<_iqs6dnj5.BattleMove?>? aHistory,
    List<_iqs6dnj5.BattleMove?>? bHistory,
    int? round,
    DateTime? roundDeadline,
    _i9fupah8.DuelStatus? status,
    _is.UuidValue? winnerUserId,
    String? endReason,
    _i03zsgo2.DuelRound? lastRound,
    DateTime? createdAt,
    DateTime? finishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Duel',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'aPetName': aPetName,
      'bPetName': bPetName,
      'aSpeciesKey': aSpeciesKey,
      'bSpeciesKey': bSpeciesKey,
      'aMaxHp': aMaxHp,
      'bMaxHp': bMaxHp,
      'aAttack': aAttack,
      'bAttack': bAttack,
      'aDefense': aDefense,
      'bDefense': bDefense,
      'aHp': aHp,
      'bHp': bHp,
      'aSpecialCooldown': aSpecialCooldown,
      'bSpecialCooldown': bSpecialCooldown,
      if (aMove != null) 'aMove': aMove?.toJson(),
      if (bMove != null) 'bMove': bMove?.toJson(),
      'aMissed': aMissed,
      'bMissed': bMissed,
      'aHistory': aHistory.toJson(valueToJson: (v) => v?.toJson()),
      'bHistory': bHistory.toJson(valueToJson: (v) => v?.toJson()),
      'round': round,
      'roundDeadline': roundDeadline.toJson(),
      'status': status.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      if (endReason != null) 'endReason': endReason,
      if (lastRound != null) 'lastRound': lastRound?.toJson(),
      'createdAt': createdAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Duel',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'aPetName': aPetName,
      'bPetName': bPetName,
      'aSpeciesKey': aSpeciesKey,
      'bSpeciesKey': bSpeciesKey,
      'aMaxHp': aMaxHp,
      'bMaxHp': bMaxHp,
      'aAttack': aAttack,
      'bAttack': bAttack,
      'aDefense': aDefense,
      'bDefense': bDefense,
      'aHp': aHp,
      'bHp': bHp,
      'aSpecialCooldown': aSpecialCooldown,
      'bSpecialCooldown': bSpecialCooldown,
      'aMissed': aMissed,
      'bMissed': bMissed,
      'aHistory': aHistory.toJson(valueToJson: (v) => v?.toJson()),
      'bHistory': bHistory.toJson(valueToJson: (v) => v?.toJson()),
      'round': round,
      'roundDeadline': roundDeadline.toJson(),
      'status': status.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      if (endReason != null) 'endReason': endReason,
      if (lastRound != null) 'lastRound': lastRound?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
    };
  }

  static DuelInclude include() {
    return DuelInclude._();
  }

  static DuelIncludeList includeList({
    _is.WhereExpressionBuilder<DuelTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    DuelInclude? include,
  }) {
    return DuelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DuelImpl extends Duel {
  _DuelImpl({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    required _is.UuidValue aUserId,
    required _is.UuidValue bUserId,
    required String aPetName,
    required String bPetName,
    required String aSpeciesKey,
    required String bSpeciesKey,
    required int aMaxHp,
    required int bMaxHp,
    required int aAttack,
    required int bAttack,
    required int aDefense,
    required int bDefense,
    required int aHp,
    required int bHp,
    required int aSpecialCooldown,
    required int bSpecialCooldown,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    required int aMissed,
    required int bMissed,
    required List<_iqs6dnj5.BattleMove?> aHistory,
    required List<_iqs6dnj5.BattleMove?> bHistory,
    required int round,
    required DateTime roundDeadline,
    required _i9fupah8.DuelStatus status,
    _is.UuidValue? winnerUserId,
    String? endReason,
    _i03zsgo2.DuelRound? lastRound,
    required DateTime createdAt,
    DateTime? finishedAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         weekStart: weekStart,
         aUserId: aUserId,
         bUserId: bUserId,
         aPetName: aPetName,
         bPetName: bPetName,
         aSpeciesKey: aSpeciesKey,
         bSpeciesKey: bSpeciesKey,
         aMaxHp: aMaxHp,
         bMaxHp: bMaxHp,
         aAttack: aAttack,
         bAttack: bAttack,
         aDefense: aDefense,
         bDefense: bDefense,
         aHp: aHp,
         bHp: bHp,
         aSpecialCooldown: aSpecialCooldown,
         bSpecialCooldown: bSpecialCooldown,
         aMove: aMove,
         bMove: bMove,
         aMissed: aMissed,
         bMissed: bMissed,
         aHistory: aHistory,
         bHistory: bHistory,
         round: round,
         roundDeadline: roundDeadline,
         status: status,
         winnerUserId: winnerUserId,
         endReason: endReason,
         lastRound: lastRound,
         createdAt: createdAt,
         finishedAt: finishedAt,
       );

  /// Returns a shallow copy of this [Duel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Duel copyWith({
    Object? id = _Undefined,
    int? leagueId,
    DateTime? weekStart,
    _is.UuidValue? aUserId,
    _is.UuidValue? bUserId,
    String? aPetName,
    String? bPetName,
    String? aSpeciesKey,
    String? bSpeciesKey,
    int? aMaxHp,
    int? bMaxHp,
    int? aAttack,
    int? bAttack,
    int? aDefense,
    int? bDefense,
    int? aHp,
    int? bHp,
    int? aSpecialCooldown,
    int? bSpecialCooldown,
    Object? aMove = _Undefined,
    Object? bMove = _Undefined,
    int? aMissed,
    int? bMissed,
    List<_iqs6dnj5.BattleMove?>? aHistory,
    List<_iqs6dnj5.BattleMove?>? bHistory,
    int? round,
    DateTime? roundDeadline,
    _i9fupah8.DuelStatus? status,
    Object? winnerUserId = _Undefined,
    Object? endReason = _Undefined,
    Object? lastRound = _Undefined,
    DateTime? createdAt,
    Object? finishedAt = _Undefined,
  }) {
    return Duel(
      id: id is int? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      weekStart: weekStart ?? this.weekStart,
      aUserId: aUserId ?? this.aUserId,
      bUserId: bUserId ?? this.bUserId,
      aPetName: aPetName ?? this.aPetName,
      bPetName: bPetName ?? this.bPetName,
      aSpeciesKey: aSpeciesKey ?? this.aSpeciesKey,
      bSpeciesKey: bSpeciesKey ?? this.bSpeciesKey,
      aMaxHp: aMaxHp ?? this.aMaxHp,
      bMaxHp: bMaxHp ?? this.bMaxHp,
      aAttack: aAttack ?? this.aAttack,
      bAttack: bAttack ?? this.bAttack,
      aDefense: aDefense ?? this.aDefense,
      bDefense: bDefense ?? this.bDefense,
      aHp: aHp ?? this.aHp,
      bHp: bHp ?? this.bHp,
      aSpecialCooldown: aSpecialCooldown ?? this.aSpecialCooldown,
      bSpecialCooldown: bSpecialCooldown ?? this.bSpecialCooldown,
      aMove: aMove is _iqs6dnj5.BattleMove? ? aMove : this.aMove,
      bMove: bMove is _iqs6dnj5.BattleMove? ? bMove : this.bMove,
      aMissed: aMissed ?? this.aMissed,
      bMissed: bMissed ?? this.bMissed,
      aHistory: aHistory ?? this.aHistory.map((e0) => e0).toList(),
      bHistory: bHistory ?? this.bHistory.map((e0) => e0).toList(),
      round: round ?? this.round,
      roundDeadline: roundDeadline ?? this.roundDeadline,
      status: status ?? this.status,
      winnerUserId: winnerUserId is _is.UuidValue?
          ? winnerUserId
          : this.winnerUserId,
      endReason: endReason is String? ? endReason : this.endReason,
      lastRound: lastRound is _i03zsgo2.DuelRound?
          ? lastRound
          : this.lastRound?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
    );
  }
}

class DuelUpdateTable extends _is.UpdateTable<DuelTable> {
  DuelUpdateTable(super.table);

  _is.ColumnValue<int, int> leagueId(int value) => _is.ColumnValue(
    table.leagueId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> weekStart(DateTime value) =>
      _is.ColumnValue(
        table.weekStart,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> aUserId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.aUserId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> bUserId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.bUserId,
        value,
      );

  _is.ColumnValue<String, String> aPetName(String value) => _is.ColumnValue(
    table.aPetName,
    value,
  );

  _is.ColumnValue<String, String> bPetName(String value) => _is.ColumnValue(
    table.bPetName,
    value,
  );

  _is.ColumnValue<String, String> aSpeciesKey(String value) => _is.ColumnValue(
    table.aSpeciesKey,
    value,
  );

  _is.ColumnValue<String, String> bSpeciesKey(String value) => _is.ColumnValue(
    table.bSpeciesKey,
    value,
  );

  _is.ColumnValue<int, int> aMaxHp(int value) => _is.ColumnValue(
    table.aMaxHp,
    value,
  );

  _is.ColumnValue<int, int> bMaxHp(int value) => _is.ColumnValue(
    table.bMaxHp,
    value,
  );

  _is.ColumnValue<int, int> aAttack(int value) => _is.ColumnValue(
    table.aAttack,
    value,
  );

  _is.ColumnValue<int, int> bAttack(int value) => _is.ColumnValue(
    table.bAttack,
    value,
  );

  _is.ColumnValue<int, int> aDefense(int value) => _is.ColumnValue(
    table.aDefense,
    value,
  );

  _is.ColumnValue<int, int> bDefense(int value) => _is.ColumnValue(
    table.bDefense,
    value,
  );

  _is.ColumnValue<int, int> aHp(int value) => _is.ColumnValue(
    table.aHp,
    value,
  );

  _is.ColumnValue<int, int> bHp(int value) => _is.ColumnValue(
    table.bHp,
    value,
  );

  _is.ColumnValue<int, int> aSpecialCooldown(int value) => _is.ColumnValue(
    table.aSpecialCooldown,
    value,
  );

  _is.ColumnValue<int, int> bSpecialCooldown(int value) => _is.ColumnValue(
    table.bSpecialCooldown,
    value,
  );

  _is.ColumnValue<_iqs6dnj5.BattleMove, _iqs6dnj5.BattleMove> aMove(
    _iqs6dnj5.BattleMove? value,
  ) => _is.ColumnValue(
    table.aMove,
    value,
  );

  _is.ColumnValue<_iqs6dnj5.BattleMove, _iqs6dnj5.BattleMove> bMove(
    _iqs6dnj5.BattleMove? value,
  ) => _is.ColumnValue(
    table.bMove,
    value,
  );

  _is.ColumnValue<int, int> aMissed(int value) => _is.ColumnValue(
    table.aMissed,
    value,
  );

  _is.ColumnValue<int, int> bMissed(int value) => _is.ColumnValue(
    table.bMissed,
    value,
  );

  _is.ColumnValue<List<_iqs6dnj5.BattleMove?>, List<_iqs6dnj5.BattleMove?>>
  aHistory(List<_iqs6dnj5.BattleMove?> value) => _is.ColumnValue(
    table.aHistory,
    value,
  );

  _is.ColumnValue<List<_iqs6dnj5.BattleMove?>, List<_iqs6dnj5.BattleMove?>>
  bHistory(List<_iqs6dnj5.BattleMove?> value) => _is.ColumnValue(
    table.bHistory,
    value,
  );

  _is.ColumnValue<int, int> round(int value) => _is.ColumnValue(
    table.round,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> roundDeadline(DateTime value) =>
      _is.ColumnValue(
        table.roundDeadline,
        value,
      );

  _is.ColumnValue<_i9fupah8.DuelStatus, _i9fupah8.DuelStatus> status(
    _i9fupah8.DuelStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> winnerUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.winnerUserId,
    value,
  );

  _is.ColumnValue<String, String> endReason(String? value) => _is.ColumnValue(
    table.endReason,
    value,
  );

  _is.ColumnValue<_i03zsgo2.DuelRound, _i03zsgo2.DuelRound> lastRound(
    _i03zsgo2.DuelRound? value,
  ) => _is.ColumnValue(
    table.lastRound,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> finishedAt(DateTime? value) =>
      _is.ColumnValue(
        table.finishedAt,
        value,
      );
}

class DuelTable extends _is.Table<int?> {
  DuelTable({super.tableRelation}) : super(tableName: 'duel') {
    updateTable = DuelUpdateTable(this);
    leagueId = _is.ColumnInt(
      'leagueId',
      this,
    );
    weekStart = _is.ColumnDateTime(
      'weekStart',
      this,
    );
    aUserId = _is.ColumnUuid(
      'aUserId',
      this,
    );
    bUserId = _is.ColumnUuid(
      'bUserId',
      this,
    );
    aPetName = _is.ColumnString(
      'aPetName',
      this,
    );
    bPetName = _is.ColumnString(
      'bPetName',
      this,
    );
    aSpeciesKey = _is.ColumnString(
      'aSpeciesKey',
      this,
    );
    bSpeciesKey = _is.ColumnString(
      'bSpeciesKey',
      this,
    );
    aMaxHp = _is.ColumnInt(
      'aMaxHp',
      this,
    );
    bMaxHp = _is.ColumnInt(
      'bMaxHp',
      this,
    );
    aAttack = _is.ColumnInt(
      'aAttack',
      this,
    );
    bAttack = _is.ColumnInt(
      'bAttack',
      this,
    );
    aDefense = _is.ColumnInt(
      'aDefense',
      this,
    );
    bDefense = _is.ColumnInt(
      'bDefense',
      this,
    );
    aHp = _is.ColumnInt(
      'aHp',
      this,
    );
    bHp = _is.ColumnInt(
      'bHp',
      this,
    );
    aSpecialCooldown = _is.ColumnInt(
      'aSpecialCooldown',
      this,
    );
    bSpecialCooldown = _is.ColumnInt(
      'bSpecialCooldown',
      this,
    );
    aMove = _is.ColumnEnum(
      'aMove',
      this,
      _is.EnumSerialization.byName,
    );
    bMove = _is.ColumnEnum(
      'bMove',
      this,
      _is.EnumSerialization.byName,
    );
    aMissed = _is.ColumnInt(
      'aMissed',
      this,
    );
    bMissed = _is.ColumnInt(
      'bMissed',
      this,
    );
    aHistory = _is.ColumnSerializable<List<_iqs6dnj5.BattleMove?>>(
      'aHistory',
      this,
    );
    bHistory = _is.ColumnSerializable<List<_iqs6dnj5.BattleMove?>>(
      'bHistory',
      this,
    );
    round = _is.ColumnInt(
      'round',
      this,
    );
    roundDeadline = _is.ColumnDateTime(
      'roundDeadline',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    winnerUserId = _is.ColumnUuid(
      'winnerUserId',
      this,
    );
    endReason = _is.ColumnString(
      'endReason',
      this,
    );
    lastRound = _is.ColumnSerializable<_i03zsgo2.DuelRound>(
      'lastRound',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    finishedAt = _is.ColumnDateTime(
      'finishedAt',
      this,
    );
  }

  late final DuelUpdateTable updateTable;

  late final _is.ColumnInt leagueId;

  /// Monday of the season week it was started in; its wins count there.
  late final _is.ColumnDateTime weekStart;

  late final _is.ColumnUuid aUserId;

  late final _is.ColumnUuid bUserId;

  late final _is.ColumnString aPetName;

  late final _is.ColumnString bPetName;

  late final _is.ColumnString aSpeciesKey;

  late final _is.ColumnString bSpeciesKey;

  /// Fighter stats, fixed when the duel starts.
  late final _is.ColumnInt aMaxHp;

  late final _is.ColumnInt bMaxHp;

  late final _is.ColumnInt aAttack;

  late final _is.ColumnInt bAttack;

  late final _is.ColumnInt aDefense;

  late final _is.ColumnInt bDefense;

  late final _is.ColumnInt aHp;

  late final _is.ColumnInt bHp;

  late final _is.ColumnInt aSpecialCooldown;

  late final _is.ColumnInt bSpecialCooldown;

  /// This round's secret moves. Never sent to the app.
  late final _is.ColumnEnum<_iqs6dnj5.BattleMove> aMove;

  late final _is.ColumnEnum<_iqs6dnj5.BattleMove> bMove;

  /// Rounds each side has missed in a row; two means they forfeit.
  late final _is.ColumnInt aMissed;

  late final _is.ColumnInt bMissed;

  /// Every move each side has made, oldest first (null for a missed round).
  late final _is.ColumnSerializable<List<_iqs6dnj5.BattleMove?>> aHistory;

  late final _is.ColumnSerializable<List<_iqs6dnj5.BattleMove?>> bHistory;

  late final _is.ColumnInt round;

  late final _is.ColumnDateTime roundDeadline;

  late final _is.ColumnEnum<_i9fupah8.DuelStatus> status;

  /// Null while ongoing, and for a draw.
  late final _is.ColumnUuid winnerUserId;

  /// How it ended: "Knockout", "Forfeit" or "Time's up". Null while ongoing.
  late final _is.ColumnString endReason;

  late final _is.ColumnSerializable<_i03zsgo2.DuelRound> lastRound;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime finishedAt;

  @override
  List<_is.Column> get columns => [
    id,
    leagueId,
    weekStart,
    aUserId,
    bUserId,
    aPetName,
    bPetName,
    aSpeciesKey,
    bSpeciesKey,
    aMaxHp,
    bMaxHp,
    aAttack,
    bAttack,
    aDefense,
    bDefense,
    aHp,
    bHp,
    aSpecialCooldown,
    bSpecialCooldown,
    aMove,
    bMove,
    aMissed,
    bMissed,
    aHistory,
    bHistory,
    round,
    roundDeadline,
    status,
    winnerUserId,
    endReason,
    lastRound,
    createdAt,
    finishedAt,
  ];
}

class DuelInclude extends _is.IncludeObject {
  DuelInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Duel.t;
}

class DuelIncludeList extends _is.IncludeList {
  DuelIncludeList._({
    _is.WhereExpressionBuilder<DuelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Duel.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Duel.t;
}

class DuelRepository {
  const DuelRepository._();

  /// Returns a list of [Duel]s matching the given query parameters.
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
  Future<List<Duel>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DuelTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Duel>(
      where: where?.call(Duel.t),
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Duel] matching the given query parameters.
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
  Future<Duel?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DuelTable>? where,
    int? offset,
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Duel>(
      where: where?.call(Duel.t),
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Duel] by its [id] or null if no such row exists.
  Future<Duel?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Duel>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Duel]s in the list and returns the inserted rows.
  ///
  /// The returned [Duel]s will have their `id` fields set.
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
  Future<List<Duel>> insert(
    _is.DatabaseSession session,
    List<Duel> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Duel>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Duel] and returns the inserted row.
  ///
  /// The returned [Duel] will have its `id` field set.
  Future<Duel> insertRow(
    _is.DatabaseSession session,
    Duel row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Duel>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Duel]s in the list and returns the resulting rows.
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
  /// The returned [Duel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Duel>> upsert(
    _is.DatabaseSession session,
    List<Duel> rows, {
    required _is.ColumnSelections<DuelTable> conflictColumns,
    _is.ColumnSelections<DuelTable>? updateColumns,
    _is.WhereExpressionBuilder<DuelTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Duel>(
      rows,
      conflictColumns: conflictColumns(Duel.t),
      updateColumns: updateColumns?.call(Duel.t),
      updateWhere: updateWhere?.call(Duel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Duel] and returns the resulting row.
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
  /// The returned [Duel] will have its `id` field set.
  Future<Duel?> upsertRow(
    _is.DatabaseSession session,
    Duel row, {
    required _is.ColumnSelections<DuelTable> conflictColumns,
    _is.ColumnSelections<DuelTable>? updateColumns,
    _is.WhereExpressionBuilder<DuelTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Duel>(
      row,
      conflictColumns: conflictColumns(Duel.t),
      updateColumns: updateColumns?.call(Duel.t),
      updateWhere: updateWhere?.call(Duel.t),
      transaction: transaction,
    );
  }

  /// Updates all [Duel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Duel>> update(
    _is.DatabaseSession session,
    List<Duel> rows, {
    _is.ColumnSelections<DuelTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Duel>(
      rows,
      columns: columns?.call(Duel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Duel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Duel> updateRow(
    _is.DatabaseSession session,
    Duel row, {
    _is.ColumnSelections<DuelTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Duel>(
      row,
      columns: columns?.call(Duel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Duel] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Duel?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DuelUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Duel>(
      id,
      columnValues: columnValues(Duel.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Duel]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Duel>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DuelUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DuelTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Duel>(
      columnValues: columnValues(Duel.t.updateTable),
      where: where(Duel.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Duel]s in the list and returns the deleted rows.
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
  Future<List<Duel>> delete(
    _is.DatabaseSession session,
    List<Duel> rows, {
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Duel>(
      rows,
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Duel].
  Future<Duel> deleteRow(
    _is.DatabaseSession session,
    Duel row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Duel>(
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
  Future<List<Duel>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DuelTable> where,
    _is.OrderByBuilder<DuelTable>? orderBy,
    _is.OrderByListBuilder<DuelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Duel>(
      where: where(Duel.t),
      orderBy: orderBy?.call(Duel.t),
      orderByList: orderByList?.call(Duel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DuelTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Duel>(
      where: where?.call(Duel.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Duel] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DuelTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Duel>(
      where: where(Duel.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
