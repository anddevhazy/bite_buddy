import 'dart:math';

import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/battle_engine.dart';
import 'package:test/test.dart';

void main() {
  const pet = Fighter(maxHp: 120, attack: 30, defense: 20);
  const rival = Fighter(maxHp: 120, attack: 30, defense: 20);

  RoundOutcome play(BattleMove mine, BattleMove theirs) => resolveRound(
    petMove: mine,
    opponentMove: theirs,
    pet: pet,
    opponent: rival,
    rng: Random(1),
  );

  group('counters', () {
    test('attack interrupts special: only the attacker does damage', () {
      final o = play(BattleMove.attack, BattleMove.special);
      expect(o.damageToOpponent, greaterThan(0));
      expect(o.damageToPet, 0);
      expect(o.clash, 'Interrupted!');
    });

    test('special breaks defend: only the special does damage', () {
      final o = play(BattleMove.special, BattleMove.defend);
      expect(o.damageToOpponent, greaterThan(0));
      expect(o.damageToPet, 0);
      expect(o.clash, 'Guard broken!');
    });

    test('defend beats attack: the blocker takes little and counters', () {
      final o = play(BattleMove.defend, BattleMove.attack);
      expect(o.damageToOpponent, greaterThan(o.damageToPet));
      expect(o.clash, 'Blocked & countered!');
    });

    test('both defending heals both and deals no damage', () {
      final o = play(BattleMove.defend, BattleMove.defend);
      expect(o.damageToOpponent + o.damageToPet, 0);
      expect(o.petHeal, greaterThan(0));
      expect(o.opponentHeal, greaterThan(0));
    });
  });
}
