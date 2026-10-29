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

/// A battle opponent from the catalog in utils/catalog.dart.
abstract class Opponent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Opponent._({
    required this.key,
    required this.name,
    required this.emoji,
    required this.level,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.difficulty,
    required this.coinReward,
    required this.tellReliability,
    required this.winChance,
  });

  factory Opponent({
    required String key,
    required String name,
    required String emoji,
    required int level,
    required int hp,
    required int attack,
    required int defense,
    required String difficulty,
    required int coinReward,
    required int tellReliability,
    required int winChance,
  }) = _OpponentImpl;

  factory Opponent.fromJson(Map<String, dynamic> jsonSerialization) {
    return Opponent(
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String,
      emoji: jsonSerialization['emoji'] as String,
      level: jsonSerialization['level'] as int,
      hp: jsonSerialization['hp'] as int,
      attack: jsonSerialization['attack'] as int,
      defense: jsonSerialization['defense'] as int,
      difficulty: jsonSerialization['difficulty'] as String,
      coinReward: jsonSerialization['coinReward'] as int,
      tellReliability: jsonSerialization['tellReliability'] as int,
      winChance: jsonSerialization['winChance'] as int,
    );
  }

  String key;

  String name;

  String emoji;

  int level;

  int hp;

  int attack;

  int defense;

  String difficulty;

  int coinReward;

  /// How often its tells are true, 0-100. Tougher opponents bluff more.
  int tellReliability;

  /// Chance the caller's pet wins, 0-100, from simulating the matchup with a
  /// player who reads the tells (see utils/battle_engine.dart).
  int winChance;

  /// Returns a shallow copy of this [Opponent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Opponent copyWith({
    String? key,
    String? name,
    String? emoji,
    int? level,
    int? hp,
    int? attack,
    int? defense,
    String? difficulty,
    int? coinReward,
    int? tellReliability,
    int? winChance,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Opponent',
      'key': key,
      'name': name,
      'emoji': emoji,
      'level': level,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'difficulty': difficulty,
      'coinReward': coinReward,
      'tellReliability': tellReliability,
      'winChance': winChance,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Opponent',
      'key': key,
      'name': name,
      'emoji': emoji,
      'level': level,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'difficulty': difficulty,
      'coinReward': coinReward,
      'tellReliability': tellReliability,
      'winChance': winChance,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OpponentImpl extends Opponent {
  _OpponentImpl({
    required String key,
    required String name,
    required String emoji,
    required int level,
    required int hp,
    required int attack,
    required int defense,
    required String difficulty,
    required int coinReward,
    required int tellReliability,
    required int winChance,
  }) : super._(
         key: key,
         name: name,
         emoji: emoji,
         level: level,
         hp: hp,
         attack: attack,
         defense: defense,
         difficulty: difficulty,
         coinReward: coinReward,
         tellReliability: tellReliability,
         winChance: winChance,
       );

  /// Returns a shallow copy of this [Opponent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Opponent copyWith({
    String? key,
    String? name,
    String? emoji,
    int? level,
    int? hp,
    int? attack,
    int? defense,
    String? difficulty,
    int? coinReward,
    int? tellReliability,
    int? winChance,
  }) {
    return Opponent(
      key: key ?? this.key,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      level: level ?? this.level,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      difficulty: difficulty ?? this.difficulty,
      coinReward: coinReward ?? this.coinReward,
      tellReliability: tellReliability ?? this.tellReliability,
      winChance: winChance ?? this.winChance,
    );
  }
}
