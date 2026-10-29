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

/// A fighter's numbers in battle.
abstract class BattleStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BattleStats._({
    required this.hp,
    required this.attack,
    required this.defense,
  });

  factory BattleStats({
    required int hp,
    required int attack,
    required int defense,
  }) = _BattleStatsImpl;

  factory BattleStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return BattleStats(
      hp: jsonSerialization['hp'] as int,
      attack: jsonSerialization['attack'] as int,
      defense: jsonSerialization['defense'] as int,
    );
  }

  int hp;

  int attack;

  int defense;

  /// Returns a shallow copy of this [BattleStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BattleStats copyWith({
    int? hp,
    int? attack,
    int? defense,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BattleStats',
      'hp': hp,
      'attack': attack,
      'defense': defense,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BattleStats',
      'hp': hp,
      'attack': attack,
      'defense': defense,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BattleStatsImpl extends BattleStats {
  _BattleStatsImpl({
    required int hp,
    required int attack,
    required int defense,
  }) : super._(
         hp: hp,
         attack: attack,
         defense: defense,
       );

  /// Returns a shallow copy of this [BattleStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BattleStats copyWith({
    int? hp,
    int? attack,
    int? defense,
  }) {
    return BattleStats(
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
    );
  }
}
