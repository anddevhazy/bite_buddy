import 'package:bite_buddy/features/battle/data/models/opponent_model.dart';
import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart' as app;
import 'package:bite_buddy_client/bite_buddy_client.dart';

class BattleModel extends BattleEntity {
  const BattleModel({
    required super.id,
    required super.opponent,
    required super.petName,
    required super.petSpeciesKey,
    required super.petHp,
    required super.petMaxHp,
    required super.opponentHp,
    required super.opponentMaxHp,
    required super.round,
    required super.status,
    required super.specialCooldown,
    super.lastRound,
    required super.coinsEarned,
    required super.xpEarned,
    required super.energyChange,
  });

  factory BattleModel.fromProtocol(BattleState state) {
    final b = state.battle;
    final last = b.lastRound;
    return BattleModel(
      id: b.id!,
      opponent: OpponentModel.fromProtocol(state.opponent),
      petName: state.petName,
      petSpeciesKey: state.petSpeciesKey,
      petHp: b.petHp,
      petMaxHp: b.petMaxHp,
      opponentHp: b.opponentHp,
      opponentMaxHp: b.opponentMaxHp,
      round: b.round,
      status: BattleStatus.values.byName(b.status.name),
      specialCooldown: b.specialCooldown,
      lastRound:
          last == null
              ? null
              : BattleRoundEntity(
                round: last.round,
                playerMove: toAppMove(last.playerMove),
                opponentMove: toAppMove(last.opponentMove),
                damageDealt: last.damageDealt,
                damageTaken: last.damageTaken,
                message: last.message,
              ),
      coinsEarned: b.coinsEarned,
      xpEarned: b.xpEarned,
      energyChange: b.energyChange,
    );
  }

  // The app keeps its own BattleMove enum so the domain layer doesn't depend
  // on the generated client; both enums share the same value names.
  static app.BattleMove toAppMove(BattleMove move) =>
      app.BattleMove.values.byName(move.name);

  static BattleMove toProtocolMove(app.BattleMove move) =>
      BattleMove.values.byName(move.name);
}
