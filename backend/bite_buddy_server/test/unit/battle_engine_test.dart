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

  test('counterTo picks the move that beats the tell', () {
    expect(counterTo(BattleMove.attack, specialCooldown: 0), BattleMove.defend);
    expect(
      counterTo(BattleMove.special, specialCooldown: 0),
      BattleMove.attack,
    );
    expect(
      counterTo(BattleMove.defend, specialCooldown: 0),
      BattleMove.special,
    );
    // Special not ready: wait it out behind a guard
    expect(counterTo(BattleMove.defend, specialCooldown: 1), BattleMove.defend);
  });

  test('tells are true about as often as the reliability says', () {
    final rng = Random(3);
    var truthful = 0;
    for (var i = 0; i < 4000; i++) {
      final tell = tellFor(
        move: BattleMove.attack,
        reliability: 70,
        specialCooldown: 0,
        rng: rng,
      );
      if (tell == BattleMove.attack) truthful++;
    }
    expect(truthful / 4000, closeTo(0.70, 0.03));
  });

  test('the opponent never picks special while it is recharging', () {
    final rng = Random(5);
    for (var i = 0; i < 1000; i++) {
      final move = pickOpponentMove(
        hp: 100,
        maxHp: 100,
        specialCooldown: 1,
        rng: rng,
      );
      expect(move, isNot(BattleMove.special));
    }
  });

  group('win chance', () {
    int chance(Fighter a, Fighter b) =>
        simulateWinChance(a, b, tellReliability: 75, seed: 42);

    test('is the same every time for the same matchup', () {
      expect(chance(pet, rival), chance(pet, rival));
    });

    // The % assumes a player who counters every tell; against equal stats
    // that's a big edge, so the arena labels it "if you read the tells"
    test('reading the tells wins most even matches', () {
      expect(chance(pet, rival), greaterThan(75));
    });

    test(
      'a much stronger pet nearly always wins, a much weaker one rarely',
      () {
        const strong = Fighter(maxHp: 200, attack: 60, defense: 40);
        const weak = Fighter(maxHp: 80, attack: 12, defense: 8);
        expect(chance(strong, rival), greaterThan(90));
        expect(chance(weak, rival), lessThan(10));
      },
    );
  });
}
