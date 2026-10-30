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
import '../league/duel_round_view.dart' as _ii30ukys;
import '../league/duel_status.dart' as _i9fupah8;

/// A duel as one of its two players sees it: "my" side and "their" side.
abstract class DuelView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DuelView._({
    required this.id,
    required this.leagueId,
    required this.myPetName,
    required this.mySpeciesKey,
    this.myPortraitId,
    required this.theirPetName,
    required this.theirSpeciesKey,
    this.theirPortraitId,
    required this.myHp,
    required this.myMaxHp,
    required this.theirHp,
    required this.theirMaxHp,
    required this.myAttack,
    required this.myDefense,
    required this.theirAttack,
    required this.theirDefense,
    required this.mySpecialCooldown,
    required this.round,
    required this.roundDeadline,
    required this.yourTurn,
    required this.theyHaveMoved,
    required this.youMissed,
    required this.theirRecentMoves,
    this.lastRound,
    required this.status,
    this.result,
    this.endReason,
  });

  factory DuelView({
    required int id,
    required int leagueId,
    required String myPetName,
    required String mySpeciesKey,
    int? myPortraitId,
    required String theirPetName,
    required String theirSpeciesKey,
    int? theirPortraitId,
    required int myHp,
    required int myMaxHp,
    required int theirHp,
    required int theirMaxHp,
    required int myAttack,
    required int myDefense,
    required int theirAttack,
    required int theirDefense,
    required int mySpecialCooldown,
    required int round,
    required DateTime roundDeadline,
    required bool yourTurn,
    required bool theyHaveMoved,
    required int youMissed,
    required List<_iqs6dnj5.BattleMove?> theirRecentMoves,
    _ii30ukys.DuelRoundView? lastRound,
    required _i9fupah8.DuelStatus status,
    String? result,
    String? endReason,
  }) = _DuelViewImpl;

  factory DuelView.fromJson(Map<String, dynamic> jsonSerialization) {
    return DuelView(
      id: jsonSerialization['id'] as int,
      leagueId: jsonSerialization['leagueId'] as int,
      myPetName: jsonSerialization['myPetName'] as String,
      mySpeciesKey: jsonSerialization['mySpeciesKey'] as String,
      myPortraitId: jsonSerialization['myPortraitId'] as int?,
      theirPetName: jsonSerialization['theirPetName'] as String,
      theirSpeciesKey: jsonSerialization['theirSpeciesKey'] as String,
      theirPortraitId: jsonSerialization['theirPortraitId'] as int?,
      myHp: jsonSerialization['myHp'] as int,
      myMaxHp: jsonSerialization['myMaxHp'] as int,
      theirHp: jsonSerialization['theirHp'] as int,
      theirMaxHp: jsonSerialization['theirMaxHp'] as int,
      myAttack: jsonSerialization['myAttack'] as int,
      myDefense: jsonSerialization['myDefense'] as int,
      theirAttack: jsonSerialization['theirAttack'] as int,
      theirDefense: jsonSerialization['theirDefense'] as int,
      mySpecialCooldown: jsonSerialization['mySpecialCooldown'] as int,
      round: jsonSerialization['round'] as int,
      roundDeadline: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['roundDeadline'],
      ),
      yourTurn: _isc.BoolJsonExtension.fromJson(jsonSerialization['yourTurn']),
      theyHaveMoved: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['theyHaveMoved'],
      ),
      youMissed: jsonSerialization['youMissed'] as int,
      theirRecentMoves: _i7z1njky.Protocol()
          .deserialize<List<_iqs6dnj5.BattleMove?>>(
            jsonSerialization['theirRecentMoves'],
          ),
      lastRound: jsonSerialization['lastRound'] == null
          ? null
          : _i7z1njky.Protocol().deserialize<_ii30ukys.DuelRoundView>(
              jsonSerialization['lastRound'],
            ),
      status: _i9fupah8.DuelStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      result: jsonSerialization['result'] as String?,
      endReason: jsonSerialization['endReason'] as String?,
    );
  }

  int id;

  int leagueId;

  String myPetName;

  String mySpeciesKey;

  int? myPortraitId;

  String theirPetName;

  String theirSpeciesKey;

  int? theirPortraitId;

  int myHp;

  int myMaxHp;

  int theirHp;

  int theirMaxHp;

  int myAttack;

  int myDefense;

  int theirAttack;

  int theirDefense;

  int mySpecialCooldown;

  int round;

  DateTime roundDeadline;

  /// True if the caller still has to pick a move this round.
  bool yourTurn;

  /// True if the other player has already picked theirs.
  bool theyHaveMoved;

  /// Rounds the caller has missed in a row (two means a forfeit).
  int youMissed;

  /// The other player's last few moves, newest last (null = missed).
  List<_iqs6dnj5.BattleMove?> theirRecentMoves;

  _ii30ukys.DuelRoundView? lastRound;

  _i9fupah8.DuelStatus status;

  /// Set when finished: won, lost or draw.
  String? result;

  /// Set when finished: how it ended, e.g. "Knockout" or "Forfeit".
  String? endReason;

  /// Returns a shallow copy of this [DuelView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DuelView copyWith({
    int? id,
    int? leagueId,
    String? myPetName,
    String? mySpeciesKey,
    int? myPortraitId,
    String? theirPetName,
    String? theirSpeciesKey,
    int? theirPortraitId,
    int? myHp,
    int? myMaxHp,
    int? theirHp,
    int? theirMaxHp,
    int? myAttack,
    int? myDefense,
    int? theirAttack,
    int? theirDefense,
    int? mySpecialCooldown,
    int? round,
    DateTime? roundDeadline,
    bool? yourTurn,
    bool? theyHaveMoved,
    int? youMissed,
    List<_iqs6dnj5.BattleMove?>? theirRecentMoves,
    _ii30ukys.DuelRoundView? lastRound,
    _i9fupah8.DuelStatus? status,
    String? result,
    String? endReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DuelView',
      'id': id,
      'leagueId': leagueId,
      'myPetName': myPetName,
      'mySpeciesKey': mySpeciesKey,
      if (myPortraitId != null) 'myPortraitId': myPortraitId,
      'theirPetName': theirPetName,
      'theirSpeciesKey': theirSpeciesKey,
      if (theirPortraitId != null) 'theirPortraitId': theirPortraitId,
      'myHp': myHp,
      'myMaxHp': myMaxHp,
      'theirHp': theirHp,
      'theirMaxHp': theirMaxHp,
      'myAttack': myAttack,
      'myDefense': myDefense,
      'theirAttack': theirAttack,
      'theirDefense': theirDefense,
      'mySpecialCooldown': mySpecialCooldown,
      'round': round,
      'roundDeadline': roundDeadline.toJson(),
      'yourTurn': yourTurn,
      'theyHaveMoved': theyHaveMoved,
      'youMissed': youMissed,
      'theirRecentMoves': theirRecentMoves.toJson(
        valueToJson: (v) => v?.toJson(),
      ),
      if (lastRound != null) 'lastRound': lastRound?.toJson(),
      'status': status.toJson(),
      if (result != null) 'result': result,
      if (endReason != null) 'endReason': endReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DuelView',
      'id': id,
      'leagueId': leagueId,
      'myPetName': myPetName,
      'mySpeciesKey': mySpeciesKey,
      if (myPortraitId != null) 'myPortraitId': myPortraitId,
      'theirPetName': theirPetName,
      'theirSpeciesKey': theirSpeciesKey,
      if (theirPortraitId != null) 'theirPortraitId': theirPortraitId,
      'myHp': myHp,
      'myMaxHp': myMaxHp,
      'theirHp': theirHp,
      'theirMaxHp': theirMaxHp,
      'myAttack': myAttack,
      'myDefense': myDefense,
      'theirAttack': theirAttack,
      'theirDefense': theirDefense,
      'mySpecialCooldown': mySpecialCooldown,
      'round': round,
      'roundDeadline': roundDeadline.toJson(),
      'yourTurn': yourTurn,
      'theyHaveMoved': theyHaveMoved,
      'youMissed': youMissed,
      'theirRecentMoves': theirRecentMoves.toJson(
        valueToJson: (v) => v?.toJson(),
      ),
      if (lastRound != null) 'lastRound': lastRound?.toJsonForProtocol(),
      'status': status.toJson(),
      if (result != null) 'result': result,
      if (endReason != null) 'endReason': endReason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DuelViewImpl extends DuelView {
  _DuelViewImpl({
    required int id,
    required int leagueId,
    required String myPetName,
    required String mySpeciesKey,
    int? myPortraitId,
    required String theirPetName,
    required String theirSpeciesKey,
    int? theirPortraitId,
    required int myHp,
    required int myMaxHp,
    required int theirHp,
    required int theirMaxHp,
    required int myAttack,
    required int myDefense,
    required int theirAttack,
    required int theirDefense,
    required int mySpecialCooldown,
    required int round,
    required DateTime roundDeadline,
    required bool yourTurn,
    required bool theyHaveMoved,
    required int youMissed,
    required List<_iqs6dnj5.BattleMove?> theirRecentMoves,
    _ii30ukys.DuelRoundView? lastRound,
    required _i9fupah8.DuelStatus status,
    String? result,
    String? endReason,
  }) : super._(
         id: id,
         leagueId: leagueId,
         myPetName: myPetName,
         mySpeciesKey: mySpeciesKey,
         myPortraitId: myPortraitId,
         theirPetName: theirPetName,
         theirSpeciesKey: theirSpeciesKey,
         theirPortraitId: theirPortraitId,
         myHp: myHp,
         myMaxHp: myMaxHp,
         theirHp: theirHp,
         theirMaxHp: theirMaxHp,
         myAttack: myAttack,
         myDefense: myDefense,
         theirAttack: theirAttack,
         theirDefense: theirDefense,
         mySpecialCooldown: mySpecialCooldown,
         round: round,
         roundDeadline: roundDeadline,
         yourTurn: yourTurn,
         theyHaveMoved: theyHaveMoved,
         youMissed: youMissed,
         theirRecentMoves: theirRecentMoves,
         lastRound: lastRound,
         status: status,
         result: result,
         endReason: endReason,
       );

  /// Returns a shallow copy of this [DuelView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DuelView copyWith({
    int? id,
    int? leagueId,
    String? myPetName,
    String? mySpeciesKey,
    Object? myPortraitId = _Undefined,
    String? theirPetName,
    String? theirSpeciesKey,
    Object? theirPortraitId = _Undefined,
    int? myHp,
    int? myMaxHp,
    int? theirHp,
    int? theirMaxHp,
    int? myAttack,
    int? myDefense,
    int? theirAttack,
    int? theirDefense,
    int? mySpecialCooldown,
    int? round,
    DateTime? roundDeadline,
    bool? yourTurn,
    bool? theyHaveMoved,
    int? youMissed,
    List<_iqs6dnj5.BattleMove?>? theirRecentMoves,
    Object? lastRound = _Undefined,
    _i9fupah8.DuelStatus? status,
    Object? result = _Undefined,
    Object? endReason = _Undefined,
  }) {
    return DuelView(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      myPetName: myPetName ?? this.myPetName,
      mySpeciesKey: mySpeciesKey ?? this.mySpeciesKey,
      myPortraitId: myPortraitId is int? ? myPortraitId : this.myPortraitId,
      theirPetName: theirPetName ?? this.theirPetName,
      theirSpeciesKey: theirSpeciesKey ?? this.theirSpeciesKey,
      theirPortraitId: theirPortraitId is int?
          ? theirPortraitId
          : this.theirPortraitId,
      myHp: myHp ?? this.myHp,
      myMaxHp: myMaxHp ?? this.myMaxHp,
      theirHp: theirHp ?? this.theirHp,
      theirMaxHp: theirMaxHp ?? this.theirMaxHp,
      myAttack: myAttack ?? this.myAttack,
      myDefense: myDefense ?? this.myDefense,
      theirAttack: theirAttack ?? this.theirAttack,
      theirDefense: theirDefense ?? this.theirDefense,
      mySpecialCooldown: mySpecialCooldown ?? this.mySpecialCooldown,
      round: round ?? this.round,
      roundDeadline: roundDeadline ?? this.roundDeadline,
      yourTurn: yourTurn ?? this.yourTurn,
      theyHaveMoved: theyHaveMoved ?? this.theyHaveMoved,
      youMissed: youMissed ?? this.youMissed,
      theirRecentMoves:
          theirRecentMoves ?? this.theirRecentMoves.map((e0) => e0).toList(),
      lastRound: lastRound is _ii30ukys.DuelRoundView?
          ? lastRound
          : this.lastRound?.copyWith(),
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      endReason: endReason is String? ? endReason : this.endReason,
    );
  }
}
