import 'package:bite_buddy/features/battle/data/models/opponent_model.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class ArenaModel extends ArenaEntity {
  const ArenaModel({required super.petStats, required super.opponents});

  factory ArenaModel.fromProtocol(Arena arena) => ArenaModel(
    petStats: BattleStatsEntity(
      hp: arena.petStats.hp,
      attack: arena.petStats.attack,
      defense: arena.petStats.defense,
    ),
    opponents: arena.opponents.map(OpponentModel.fromProtocol).toList(),
  );
}
