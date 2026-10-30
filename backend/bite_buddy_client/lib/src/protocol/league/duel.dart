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
import 'package:bite_buddy_client/src/protocol/protocol.dart' as _i7z1njky;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../battle_move.dart' as _iqs6dnj5;
import '../league/duel_round.dart' as _i03zsgo2;
import '../league/duel_status.dart' as _i9fupah8;

/// A turn-based battle between two league friends, played asynchronously:
/// each round both pick a move in secret, and the round resolves once both
/// have (or the deadline passes). Side A challenged side B.
abstract class Duel
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    this.aPortraitId,
    this.bPortraitId,
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
    required _isc.UuidValue aUserId,
    required _isc.UuidValue bUserId,
    required String aPetName,
    required String bPetName,
    required String aSpeciesKey,
    required String bSpeciesKey,
    int? aPortraitId,
    int? bPortraitId,
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
    required int aMissed,
    required int bMissed,
    required List<_iqs6dnj5.BattleMove?> aHistory,
    required List<_iqs6dnj5.BattleMove?> bHistory,
    required int round,
    required DateTime roundDeadline,
    required _i9fupah8.DuelStatus status,
    _isc.UuidValue? winnerUserId,
    String? endReason,
    _i03zsgo2.DuelRound? lastRound,
    required DateTime createdAt,
    DateTime? finishedAt,
  }) = _DuelImpl;

  factory Duel.fromJson(Map<String, dynamic> jsonSerialization) {
    return Duel(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      weekStart: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      aUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['aUserId'],
      ),
      bUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['bUserId'],
      ),
      aPetName: jsonSerialization['aPetName'] as String,
      bPetName: jsonSerialization['bPetName'] as String,
      aSpeciesKey: jsonSerialization['aSpeciesKey'] as String,
      bSpeciesKey: jsonSerialization['bSpeciesKey'] as String,
      aPortraitId: jsonSerialization['aPortraitId'] as int?,
      bPortraitId: jsonSerialization['bPortraitId'] as int?,
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
      aMissed: jsonSerialization['aMissed'] as int,
      bMissed: jsonSerialization['bMissed'] as int,
      aHistory: _i7z1njky.Protocol().deserialize<List<_iqs6dnj5.BattleMove?>>(
        jsonSerialization['aHistory'],
      ),
      bHistory: _i7z1njky.Protocol().deserialize<List<_iqs6dnj5.BattleMove?>>(
        jsonSerialization['bHistory'],
      ),
      round: jsonSerialization['round'] as int,
      roundDeadline: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['roundDeadline'],
      ),
      status: _i9fupah8.DuelStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      winnerUserId: jsonSerialization['winnerUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['winnerUserId'],
            ),
      endReason: jsonSerialization['endReason'] as String?,
      lastRound: jsonSerialization['lastRound'] == null
          ? null
          : _i7z1njky.Protocol().deserialize<_i03zsgo2.DuelRound>(
              jsonSerialization['lastRound'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['finishedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int leagueId;

  /// Monday of the season week it was started in; its wins count there.
  DateTime weekStart;

  _isc.UuidValue aUserId;

  _isc.UuidValue bUserId;

  String aPetName;

  String bPetName;

  String aSpeciesKey;

  String bSpeciesKey;

  int? aPortraitId;

  int? bPortraitId;

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
  _isc.UuidValue? winnerUserId;

  /// How it ended: "Knockout", "Forfeit" or "Time's up". Null while ongoing.
  String? endReason;

  _i03zsgo2.DuelRound? lastRound;

  DateTime createdAt;

  DateTime? finishedAt;

  /// Returns a shallow copy of this [Duel]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Duel copyWith({
    int? id,
    int? leagueId,
    DateTime? weekStart,
    _isc.UuidValue? aUserId,
    _isc.UuidValue? bUserId,
    String? aPetName,
    String? bPetName,
    String? aSpeciesKey,
    String? bSpeciesKey,
    int? aPortraitId,
    int? bPortraitId,
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
    int? aMissed,
    int? bMissed,
    List<_iqs6dnj5.BattleMove?>? aHistory,
    List<_iqs6dnj5.BattleMove?>? bHistory,
    int? round,
    DateTime? roundDeadline,
    _i9fupah8.DuelStatus? status,
    _isc.UuidValue? winnerUserId,
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
      if (aPortraitId != null) 'aPortraitId': aPortraitId,
      if (bPortraitId != null) 'bPortraitId': bPortraitId,
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
      if (aPortraitId != null) 'aPortraitId': aPortraitId,
      if (bPortraitId != null) 'bPortraitId': bPortraitId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DuelImpl extends Duel {
  _DuelImpl({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    required _isc.UuidValue aUserId,
    required _isc.UuidValue bUserId,
    required String aPetName,
    required String bPetName,
    required String aSpeciesKey,
    required String bSpeciesKey,
    int? aPortraitId,
    int? bPortraitId,
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
    required int aMissed,
    required int bMissed,
    required List<_iqs6dnj5.BattleMove?> aHistory,
    required List<_iqs6dnj5.BattleMove?> bHistory,
    required int round,
    required DateTime roundDeadline,
    required _i9fupah8.DuelStatus status,
    _isc.UuidValue? winnerUserId,
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
         aPortraitId: aPortraitId,
         bPortraitId: bPortraitId,
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
  @_isc.useResult
  @override
  Duel copyWith({
    Object? id = _Undefined,
    int? leagueId,
    DateTime? weekStart,
    _isc.UuidValue? aUserId,
    _isc.UuidValue? bUserId,
    String? aPetName,
    String? bPetName,
    String? aSpeciesKey,
    String? bSpeciesKey,
    Object? aPortraitId = _Undefined,
    Object? bPortraitId = _Undefined,
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
      aPortraitId: aPortraitId is int? ? aPortraitId : this.aPortraitId,
      bPortraitId: bPortraitId is int? ? bPortraitId : this.bPortraitId,
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
      aMissed: aMissed ?? this.aMissed,
      bMissed: bMissed ?? this.bMissed,
      aHistory: aHistory ?? this.aHistory.map((e0) => e0).toList(),
      bHistory: bHistory ?? this.bHistory.map((e0) => e0).toList(),
      round: round ?? this.round,
      roundDeadline: roundDeadline ?? this.roundDeadline,
      status: status ?? this.status,
      winnerUserId: winnerUserId is _isc.UuidValue?
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
