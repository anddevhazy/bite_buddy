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

/// What happened in one round of a duel, from side A's point of view. Stored
/// on the duel; turned into the caller's point of view by DuelView.
abstract class DuelRound
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DuelRound._({
    required this.round,
    this.aMove,
    this.bMove,
    required this.damageToA,
    required this.damageToB,
    required this.aCritical,
    required this.bCritical,
    required this.clash,
  });

  factory DuelRound({
    required int round,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    required int damageToA,
    required int damageToB,
    required bool aCritical,
    required bool bCritical,
    required String clash,
  }) = _DuelRoundImpl;

  factory DuelRound.fromJson(Map<String, dynamic> jsonSerialization) {
    return DuelRound(
      round: jsonSerialization['round'] as int,
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
      damageToA: jsonSerialization['damageToA'] as int,
      damageToB: jsonSerialization['damageToB'] as int,
      aCritical: _is.BoolJsonExtension.fromJson(jsonSerialization['aCritical']),
      bCritical: _is.BoolJsonExtension.fromJson(jsonSerialization['bCritical']),
      clash: jsonSerialization['clash'] as String,
    );
  }

  int round;

  /// Null when that side missed the deadline.
  _iqs6dnj5.BattleMove? aMove;

  _iqs6dnj5.BattleMove? bMove;

  int damageToA;

  int damageToB;

  bool aCritical;

  bool bCritical;

  String clash;

  /// Returns a shallow copy of this [DuelRound]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DuelRound copyWith({
    int? round,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    int? damageToA,
    int? damageToB,
    bool? aCritical,
    bool? bCritical,
    String? clash,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DuelRound',
      'round': round,
      if (aMove != null) 'aMove': aMove?.toJson(),
      if (bMove != null) 'bMove': bMove?.toJson(),
      'damageToA': damageToA,
      'damageToB': damageToB,
      'aCritical': aCritical,
      'bCritical': bCritical,
      'clash': clash,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DuelRound',
      'round': round,
      if (aMove != null) 'aMove': aMove?.toJson(),
      if (bMove != null) 'bMove': bMove?.toJson(),
      'damageToA': damageToA,
      'damageToB': damageToB,
      'aCritical': aCritical,
      'bCritical': bCritical,
      'clash': clash,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DuelRoundImpl extends DuelRound {
  _DuelRoundImpl({
    required int round,
    _iqs6dnj5.BattleMove? aMove,
    _iqs6dnj5.BattleMove? bMove,
    required int damageToA,
    required int damageToB,
    required bool aCritical,
    required bool bCritical,
    required String clash,
  }) : super._(
         round: round,
         aMove: aMove,
         bMove: bMove,
         damageToA: damageToA,
         damageToB: damageToB,
         aCritical: aCritical,
         bCritical: bCritical,
         clash: clash,
       );

  /// Returns a shallow copy of this [DuelRound]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DuelRound copyWith({
    int? round,
    Object? aMove = _Undefined,
    Object? bMove = _Undefined,
    int? damageToA,
    int? damageToB,
    bool? aCritical,
    bool? bCritical,
    String? clash,
  }) {
    return DuelRound(
      round: round ?? this.round,
      aMove: aMove is _iqs6dnj5.BattleMove? ? aMove : this.aMove,
      bMove: bMove is _iqs6dnj5.BattleMove? ? bMove : this.bMove,
      damageToA: damageToA ?? this.damageToA,
      damageToB: damageToB ?? this.damageToB,
      aCritical: aCritical ?? this.aCritical,
      bCritical: bCritical ?? this.bCritical,
      clash: clash ?? this.clash,
    );
  }
}
