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
  // How it fights in the real-time arena
  final int windupMs;
  final int recoveryMs;
  final int attackIntervalMs;
  final int heavyChance;
  final int feintChance;
  // Percent of jabs followed straight up by a quick second jab
  final int comboChance;
  final int blockChance;

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
    required this.windupMs,
    required this.recoveryMs,
    required this.attackIntervalMs,
    required this.heavyChance,
    required this.feintChance,
    required this.comboChance,
    required this.blockChance,
  });

  // "0.75s": how long you have to react to an attack
  String get reactionTime => '${(windupMs / 1000).toStringAsFixed(2)}s';

  String get fakes => feintChance == 0
      ? 'Never fakes'
      : feintChance < 15
      ? 'Rarely fakes'
      : feintChance < 25
      ? 'Sometimes fakes'
      : 'Often fakes';

  @override
  List<Object?> get props => [key];
}
