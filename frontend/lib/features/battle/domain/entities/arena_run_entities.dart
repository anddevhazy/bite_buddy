import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:equatable/equatable.dart';

// The numbers a real-time fight runs on, sent by the server with every fight
class ArenaRulesEntity extends Equatable {
  final int hpMultiplier;
  // Opponents' hits are multiplied by this, so every mistake matters
  final double opponentPower;
  final double damageScale;
  final double variance;
  final double critChance;
  final double critMultiplier;
  final double counterMultiplier;
  final double specialMultiplier;
  final double blockedMultiplier;
  final int perfectBlockMs;
  final int stunMs;
  final int attackCooldownMs;
  final int dodgeCooldownMs;
  final int dodgeMs;
  final int specialMeterMax;
  final int meterPerCounter;
  final int meterPerParry;
  final int meterPerDodge;

  const ArenaRulesEntity({
    required this.hpMultiplier,
    required this.opponentPower,
    required this.damageScale,
    required this.variance,
    required this.critChance,
    required this.critMultiplier,
    required this.counterMultiplier,
    required this.specialMultiplier,
    required this.blockedMultiplier,
    required this.perfectBlockMs,
    required this.stunMs,
    required this.attackCooldownMs,
    required this.dodgeCooldownMs,
    required this.dodgeMs,
    required this.specialMeterMax,
    required this.meterPerCounter,
    required this.meterPerParry,
    required this.meterPerDodge,
  });

  @override
  List<Object?> get props => [hpMultiplier, damageScale, attackCooldownMs];
}

// Everything needed to play one fight
class ArenaRunConfigEntity extends Equatable {
  final int runId;
  final String petName;
  final String petSpeciesKey;
  final BattleStatsEntity petStats;
  final OpponentEntity opponent;
  final ArenaRulesEntity rules;
  final int seed;

  const ArenaRunConfigEntity({
    required this.runId,
    required this.petName,
    required this.petSpeciesKey,
    required this.petStats,
    required this.opponent,
    required this.rules,
    required this.seed,
  });

  @override
  List<Object?> get props => [runId];
}

// What the phone reports when a fight ends
class ArenaRunReportEntity extends Equatable {
  final bool won;
  final int durationMs;
  final int damageDealt;
  final int damageTaken;
  final int hitsLanded;

  const ArenaRunReportEntity({
    required this.won,
    required this.durationMs,
    required this.damageDealt,
    required this.damageTaken,
    required this.hitsLanded,
  });

  @override
  List<Object?> get props => [won, durationMs, damageDealt, damageTaken];
}

// The server's verdict, and the rewards
class ArenaRunResultEntity extends Equatable {
  final bool won;
  // False when a reported win couldn't be verified (counted as a loss)
  final bool verified;
  final int coinsEarned;
  final int xpEarned;
  final int energyChange;
  final bool leveledUp;

  const ArenaRunResultEntity({
    required this.won,
    required this.verified,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
    required this.leveledUp,
  });

  @override
  List<Object?> get props => [won, verified, coinsEarned, xpEarned];
}
