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
import '../battle_move.dart' as _iqs6dnj5;

/// One duel round as the caller sees it.
abstract class DuelRoundView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DuelRoundView._({
    required this.round,
    this.myMove,
    this.theirMove,
    required this.damageDealt,
    required this.damageTaken,
    required this.myCritical,
    required this.theirCritical,
    required this.clash,
    required this.message,
  });

  factory DuelRoundView({
    required int round,
    _iqs6dnj5.BattleMove? myMove,
    _iqs6dnj5.BattleMove? theirMove,
    required int damageDealt,
    required int damageTaken,
    required bool myCritical,
    required bool theirCritical,
    required String clash,
    required String message,
  }) = _DuelRoundViewImpl;

  factory DuelRoundView.fromJson(Map<String, dynamic> jsonSerialization) {
    return DuelRoundView(
      round: jsonSerialization['round'] as int,
      myMove: jsonSerialization['myMove'] == null
          ? null
          : _iqs6dnj5.BattleMove.fromJson(
              (jsonSerialization['myMove'] as String),
            ),
      theirMove: jsonSerialization['theirMove'] == null
          ? null
          : _iqs6dnj5.BattleMove.fromJson(
              (jsonSerialization['theirMove'] as String),
            ),
      damageDealt: jsonSerialization['damageDealt'] as int,
      damageTaken: jsonSerialization['damageTaken'] as int,
      myCritical: _is.BoolJsonExtension.fromJson(
        jsonSerialization['myCritical'],
      ),
      theirCritical: _is.BoolJsonExtension.fromJson(
        jsonSerialization['theirCritical'],
      ),
      clash: jsonSerialization['clash'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  int round;

  _iqs6dnj5.BattleMove? myMove;

  _iqs6dnj5.BattleMove? theirMove;

  int damageDealt;

  int damageTaken;

  bool myCritical;

  bool theirCritical;

  String clash;

  String message;

  /// Returns a shallow copy of this [DuelRoundView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DuelRoundView copyWith({
    int? round,
    _iqs6dnj5.BattleMove? myMove,
    _iqs6dnj5.BattleMove? theirMove,
    int? damageDealt,
    int? damageTaken,
    bool? myCritical,
    bool? theirCritical,
    String? clash,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DuelRoundView',
      'round': round,
      if (myMove != null) 'myMove': myMove?.toJson(),
      if (theirMove != null) 'theirMove': theirMove?.toJson(),
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'myCritical': myCritical,
      'theirCritical': theirCritical,
      'clash': clash,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DuelRoundView',
      'round': round,
      if (myMove != null) 'myMove': myMove?.toJson(),
      if (theirMove != null) 'theirMove': theirMove?.toJson(),
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'myCritical': myCritical,
      'theirCritical': theirCritical,
      'clash': clash,
      'message': message,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DuelRoundViewImpl extends DuelRoundView {
  _DuelRoundViewImpl({
    required int round,
    _iqs6dnj5.BattleMove? myMove,
    _iqs6dnj5.BattleMove? theirMove,
    required int damageDealt,
    required int damageTaken,
    required bool myCritical,
    required bool theirCritical,
    required String clash,
    required String message,
  }) : super._(
         round: round,
         myMove: myMove,
         theirMove: theirMove,
         damageDealt: damageDealt,
         damageTaken: damageTaken,
         myCritical: myCritical,
         theirCritical: theirCritical,
         clash: clash,
         message: message,
       );

  /// Returns a shallow copy of this [DuelRoundView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DuelRoundView copyWith({
    int? round,
    Object? myMove = _Undefined,
    Object? theirMove = _Undefined,
    int? damageDealt,
    int? damageTaken,
    bool? myCritical,
    bool? theirCritical,
    String? clash,
    String? message,
  }) {
    return DuelRoundView(
      round: round ?? this.round,
      myMove: myMove is _iqs6dnj5.BattleMove? ? myMove : this.myMove,
      theirMove: theirMove is _iqs6dnj5.BattleMove?
          ? theirMove
          : this.theirMove,
      damageDealt: damageDealt ?? this.damageDealt,
      damageTaken: damageTaken ?? this.damageTaken,
      myCritical: myCritical ?? this.myCritical,
      theirCritical: theirCritical ?? this.theirCritical,
      clash: clash ?? this.clash,
      message: message ?? this.message,
    );
  }
}
