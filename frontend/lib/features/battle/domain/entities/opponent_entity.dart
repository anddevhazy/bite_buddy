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
  // Rough chance of winning against this opponent, 0-100
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
    required this.winChance,
  });

  int get power => ((attack + defense + hp / 5)).round();

  // A friend's pet, played by the computer (same key format as the server)
  bool get isFriend => key.startsWith('friend:');

  @override
  List<Object?> get props => [key, winChance];
}
