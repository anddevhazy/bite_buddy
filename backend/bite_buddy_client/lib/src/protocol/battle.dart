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
import 'battle_round.dart' as _imrf8vtu;
import 'battle_status.dart' as _ib4xlijd;

/// A battle between the user's pet and a catalog opponent, resolved round by
/// round on the server.
abstract class Battle
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    this.lastRound,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
    required this.createdAt,
  });

  factory Battle({
    int? id,
    required _isc.UuidValue ownerId,
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
    _imrf8vtu.BattleRound? lastRound,
    required int coinsEarned,
    required int xpEarned,
    required int energyChange,
    required DateTime createdAt,
  }) = _BattleImpl;

  factory Battle.fromJson(Map<String, dynamic> jsonSerialization) {
    return Battle(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
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
      lastRound: jsonSerialization['lastRound'] == null
          ? null
          : _i7z1njky.Protocol().deserialize<_imrf8vtu.BattleRound>(
              jsonSerialization['lastRound'],
            ),
      coinsEarned: jsonSerialization['coinsEarned'] as int,
      xpEarned: jsonSerialization['xpEarned'] as int,
      energyChange: jsonSerialization['energyChange'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue ownerId;

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

  _imrf8vtu.BattleRound? lastRound;

  int coinsEarned;

  int xpEarned;

  int energyChange;

  DateTime createdAt;

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Battle copyWith({
    int? id,
    _isc.UuidValue? ownerId,
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
      if (lastRound != null) 'lastRound': lastRound?.toJsonForProtocol(),
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattleImpl extends Battle {
  _BattleImpl({
    int? id,
    required _isc.UuidValue ownerId,
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
         lastRound: lastRound,
         coinsEarned: coinsEarned,
         xpEarned: xpEarned,
         energyChange: energyChange,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Battle copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
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
