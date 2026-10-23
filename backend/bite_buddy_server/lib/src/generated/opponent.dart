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

/// A battle opponent from the catalog in utils/catalog.dart.
abstract class Opponent
    implements _is.SerializableModel, _is.ProtocolSerialization {
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

  /// Rough chance the caller's pet wins, 0-100.
  int winChance;

  /// Returns a shallow copy of this [Opponent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
      'winChance': winChance,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
         winChance: winChance,
       );

  /// Returns a shallow copy of this [Opponent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
      winChance: winChance ?? this.winChance,
    );
  }
}
