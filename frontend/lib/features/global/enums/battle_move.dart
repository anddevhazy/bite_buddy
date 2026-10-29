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

  // Each move beats one other: Attack > Special > Defend > Attack
  String get hint => switch (this) {
    BattleMove.attack => 'Beats Special: interrupts it',
    BattleMove.defend => 'Beats Attack: block and counter',
    BattleMove.special => 'Beats Defend: smashes the guard',
  };

  // How the opponent looks when it's about to make this move
  String tellFor(String opponentName) => switch (this) {
    BattleMove.attack => '$opponentName is baring its teeth…',
    BattleMove.defend => '$opponentName is raising its guard…',
    BattleMove.special => '$opponentName is gathering power…',
  };
}
