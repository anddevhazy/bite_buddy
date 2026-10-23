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
  final String message;

  const BattleRoundEntity({
    required this.round,
    required this.playerMove,
    required this.opponentMove,
    required this.damageDealt,
    required this.damageTaken,
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
    this.lastRound,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
  });

  bool get isOver => status != BattleStatus.ongoing;

  @override
  List<Object?> get props => [id, round, status, petHp, opponentHp];
}
