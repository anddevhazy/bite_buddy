import 'package:equatable/equatable.dart';

class OpponentEntity extends Equatable {
  final String key;
  final String name;
  final String emoji;
  final int level;
  final int hp;
  final int attack;
  final int defense;
  final String difficulty;
  final int coinReward;
  // How often its tells are true, 0-100. Tougher opponents bluff more.
  final int tellReliability;
  // Chance of winning if you read the tells, 0-100 (simulated on the server)
  final int winChance;

  const OpponentEntity({
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

  String get bluffs => tellReliability >= 80
      ? 'Rarely bluffs'
      : tellReliability >= 70
      ? 'Sometimes bluffs'
      : 'Often bluffs';

  @override
  List<Object?> get props => [key, winChance];
}
