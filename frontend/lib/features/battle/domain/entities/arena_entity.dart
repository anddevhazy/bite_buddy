import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:equatable/equatable.dart';

// A fighter's numbers in battle
class BattleStatsEntity extends Equatable {
  final int hp;
  final int attack;
  final int defense;

  const BattleStatsEntity({
    required this.hp,
    required this.attack,
    required this.defense,
  });

  @override
  List<Object?> get props => [hp, attack, defense];
}

// The Battle Arena: your buddy's battle stats and who you can fight
class ArenaEntity extends Equatable {
  final BattleStatsEntity petStats;
  final List<OpponentEntity> opponents;

  const ArenaEntity({required this.petStats, required this.opponents});

  @override
  List<Object?> get props => [petStats, opponents];
}
