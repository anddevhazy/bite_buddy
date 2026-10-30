import 'package:bite_buddy/features/battle/data/models/opponent_model.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Converts between the generated server models and this feature's entities
class ArenaRunModels {
  static ArenaRunConfigEntity config(ArenaRunConfig c) => ArenaRunConfigEntity(
    runId: c.runId,
    petName: c.petName,
    petSpeciesKey: c.petSpeciesKey,
    petStats: BattleStatsEntity(
      hp: c.petStats.hp,
      attack: c.petStats.attack,
      defense: c.petStats.defense,
    ),
    opponent: OpponentModel.fromProtocol(c.opponent),
    rules: ArenaRulesEntity(
      hpMultiplier: c.rules.hpMultiplier,
      opponentPower: c.rules.opponentPower,
      damageScale: c.rules.damageScale,
      variance: c.rules.variance,
      critChance: c.rules.critChance,
      critMultiplier: c.rules.critMultiplier,
      counterMultiplier: c.rules.counterMultiplier,
      specialMultiplier: c.rules.specialMultiplier,
      blockedMultiplier: c.rules.blockedMultiplier,
      perfectBlockMs: c.rules.perfectBlockMs,
      stunMs: c.rules.stunMs,
      attackCooldownMs: c.rules.attackCooldownMs,
      dodgeCooldownMs: c.rules.dodgeCooldownMs,
      dodgeMs: c.rules.dodgeMs,
      specialMeterMax: c.rules.specialMeterMax,
      meterPerCounter: c.rules.meterPerCounter,
      meterPerParry: c.rules.meterPerParry,
      meterPerDodge: c.rules.meterPerDodge,
    ),
    seed: c.seed,
  );

  static ArenaRunReport report(ArenaRunReportEntity r) => ArenaRunReport(
    won: r.won,
    durationMs: r.durationMs,
    damageDealt: r.damageDealt,
    damageTaken: r.damageTaken,
    hitsLanded: r.hitsLanded,
  );

  static ArenaRunResultEntity result(ArenaRunResult r) => ArenaRunResultEntity(
    won: r.won,
    verified: r.verified,
    coinsEarned: r.coinsEarned,
    xpEarned: r.xpEarned,
    energyChange: r.energyChange,
    leveledUp: r.leveledUp,
  );
}
