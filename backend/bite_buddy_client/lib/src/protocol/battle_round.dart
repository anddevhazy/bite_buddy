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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'battle_move.dart' as _iz303hum;

/// What happened in one round of a battle. Stored as JSON on the battle row.
abstract class BattleRound
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BattleRound._({
    required this.round,
    required this.playerMove,
    required this.opponentMove,
    required this.damageDealt,
    required this.damageTaken,
    required this.playerCritical,
    required this.opponentCritical,
    required this.clash,
    required this.message,
  });

  factory BattleRound({
    required int round,
    required _iz303hum.BattleMove playerMove,
    required _iz303hum.BattleMove opponentMove,
    required int damageDealt,
    required int damageTaken,
    required bool playerCritical,
    required bool opponentCritical,
    required String clash,
    required String message,
  }) = _BattleRoundImpl;

  factory BattleRound.fromJson(Map<String, dynamic> jsonSerialization) {
    return BattleRound(
      round: jsonSerialization['round'] as int,
      playerMove: _iz303hum.BattleMove.fromJson(
        (jsonSerialization['playerMove'] as String),
      ),
      opponentMove: _iz303hum.BattleMove.fromJson(
        (jsonSerialization['opponentMove'] as String),
      ),
      damageDealt: jsonSerialization['damageDealt'] as int,
      damageTaken: jsonSerialization['damageTaken'] as int,
      playerCritical: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['playerCritical'],
      ),
      opponentCritical: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['opponentCritical'],
      ),
      clash: jsonSerialization['clash'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  int round;

  _iz303hum.BattleMove playerMove;

  _iz303hum.BattleMove opponentMove;

  int damageDealt;

  int damageTaken;

  /// Whether either side landed a critical hit this round.
  bool playerCritical;

  bool opponentCritical;

  /// Short label for how the moves met, e.g. "Guard broken!"; empty when the
  /// moves were the same.
  String clash;

  String message;

  /// Returns a shallow copy of this [BattleRound]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BattleRound copyWith({
    int? round,
    _iz303hum.BattleMove? playerMove,
    _iz303hum.BattleMove? opponentMove,
    int? damageDealt,
    int? damageTaken,
    bool? playerCritical,
    bool? opponentCritical,
    String? clash,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BattleRound',
      'round': round,
      'playerMove': playerMove.toJson(),
      'opponentMove': opponentMove.toJson(),
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'playerCritical': playerCritical,
      'opponentCritical': opponentCritical,
      'clash': clash,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BattleRound',
      'round': round,
      'playerMove': playerMove.toJson(),
      'opponentMove': opponentMove.toJson(),
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'playerCritical': playerCritical,
      'opponentCritical': opponentCritical,
      'clash': clash,
      'message': message,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BattleRoundImpl extends BattleRound {
  _BattleRoundImpl({
    required int round,
    required _iz303hum.BattleMove playerMove,
    required _iz303hum.BattleMove opponentMove,
    required int damageDealt,
    required int damageTaken,
    required bool playerCritical,
    required bool opponentCritical,
    required String clash,
    required String message,
  }) : super._(
         round: round,
         playerMove: playerMove,
         opponentMove: opponentMove,
         damageDealt: damageDealt,
         damageTaken: damageTaken,
         playerCritical: playerCritical,
         opponentCritical: opponentCritical,
         clash: clash,
         message: message,
       );

  /// Returns a shallow copy of this [BattleRound]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BattleRound copyWith({
    int? round,
    _iz303hum.BattleMove? playerMove,
    _iz303hum.BattleMove? opponentMove,
    int? damageDealt,
    int? damageTaken,
    bool? playerCritical,
    bool? opponentCritical,
    String? clash,
    String? message,
  }) {
    return BattleRound(
      round: round ?? this.round,
      playerMove: playerMove ?? this.playerMove,
      opponentMove: opponentMove ?? this.opponentMove,
      damageDealt: damageDealt ?? this.damageDealt,
      damageTaken: damageTaken ?? this.damageTaken,
      playerCritical: playerCritical ?? this.playerCritical,
      opponentCritical: opponentCritical ?? this.opponentCritical,
      clash: clash ?? this.clash,
      message: message ?? this.message,
    );
  }
}
