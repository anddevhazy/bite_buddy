enum BattleMove { attack, defend, special }

extension BattleMoveX on BattleMove {
  String get label => switch (this) {
    BattleMove.attack => 'Attack',
    BattleMove.defend => 'Defend',
    BattleMove.special => 'Special',
  };

  String get emoji => switch (this) {
    BattleMove.attack => '⚔️',
    BattleMove.defend => '🛡️',
    BattleMove.special => '✨',
  };

  String get hint => switch (this) {
    BattleMove.attack => 'Steady damage',
    BattleMove.defend => 'Halve damage, heal a bit',
    BattleMove.special => 'Big hit, 3-round cooldown',
  };
}
