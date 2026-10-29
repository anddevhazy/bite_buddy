import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:equatable/equatable.dart';

enum BattleStatus { ongoing, won, lost }

class BattleRoundEntity extends Equatable {
  final int round;
  final BattleMove playerMove;
  final BattleMove opponentMove;
  final int damageDealt;
  final int damageTaken;
  final bool playerCritical;
  final bool opponentCritical;
  // How the moves met, e.g. "Guard broken!"; empty when they were the same
  final String clash;
  final String message;

  const BattleRoundEntity({
    required this.round,
    required this.playerMove,
    required this.opponentMove,
    required this.damageDealt,
    required this.damageTaken,
    required this.playerCritical,
    required this.opponentCritical,
    required this.clash,
    required this.message,
  });

  @override
  List<Object?> get props => [round];
}

class BattleEntity extends Equatable {
  final int id;
  final OpponentEntity opponent;
  final String petName;
  final String petSpeciesKey;
  final int petHp;
  final int petMaxHp;
  final int opponentHp;
  final int opponentMaxHp;
  final int round;
  final BattleStatus status;
  // Rounds until Special can be used again; 0 means ready
  final int specialCooldown;
  // What the opponent seems to be about to do. Usually true, sometimes a bluff.
  final BattleMove? opponentTell;
  final BattleRoundEntity? lastRound;
  final int coinsEarned;
  final int xpEarned;
  final int energyChange;

  const BattleEntity({
    required this.id,
    required this.opponent,
    required this.petName,
    required this.petSpeciesKey,
    required this.petHp,
    required this.petMaxHp,
    required this.opponentHp,
    required this.opponentMaxHp,
    required this.round,
    required this.status,
    required this.specialCooldown,
    this.opponentTell,
    this.lastRound,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
  });

  bool get isOver => status != BattleStatus.ongoing;

  @override
  List<Object?> get props => [id, round, status, petHp, opponentHp];
}
