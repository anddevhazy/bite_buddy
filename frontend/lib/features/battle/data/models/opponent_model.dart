import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class OpponentModel extends OpponentEntity {
  const OpponentModel({
    required super.key,
    required super.name,
    required super.emoji,
    required super.level,
    required super.hp,
    required super.attack,
    required super.defense,
    required super.difficulty,
    required super.coinReward,
    required super.winChance,
  });

  factory OpponentModel.fromProtocol(Opponent opponent) {
    return OpponentModel(
      key: opponent.key,
      name: opponent.name,
      emoji: opponent.emoji,
      level: opponent.level,
      hp: opponent.hp,
      attack: opponent.attack,
      defense: opponent.defense,
      difficulty: opponent.difficulty,
      coinReward: opponent.coinReward,
      winChance: opponent.winChance,
    );
  }
}
