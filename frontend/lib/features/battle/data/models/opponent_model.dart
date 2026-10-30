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
    required super.windupMs,
    required super.recoveryMs,
    required super.attackIntervalMs,
    required super.heavyChance,
    required super.feintChance,
    required super.comboChance,
    required super.blockChance,
  });

  factory OpponentModel.fromProtocol(Opponent o) => OpponentModel(
    key: o.key,
    name: o.name,
    emoji: o.emoji,
    level: o.level,
    hp: o.hp,
    attack: o.attack,
    defense: o.defense,
    difficulty: o.difficulty,
    coinReward: o.coinReward,
    windupMs: o.windupMs,
    recoveryMs: o.recoveryMs,
    attackIntervalMs: o.attackIntervalMs,
    heavyChance: o.heavyChance,
    feintChance: o.feintChance,
    comboChance: o.comboChance,
    blockChance: o.blockChance,
  );
}
