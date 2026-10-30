import 'dart:math';

import '../generated/protocol.dart';
import 'battle_engine.dart';

// Rules for friend duels on top of the battle engine: each round both players
// pick a move in secret; a player who misses the deadline does nothing that
// round, and missing two rounds in a row forfeits.

const Duration duelTurnTime = Duration(hours: 24);
const int maxMissedInARow = 2;
const int recentMovesShown = 5;

// Resolves a round from side A's point of view. A null move is a missed
// deadline: that side does nothing and the other side's move lands unopposed.
RoundOutcome resolveDuelRound({
  required BattleMove? aMove,
  required BattleMove? bMove,
  required Fighter a,
  required Fighter b,
  required Random rng,
}) {
  if (aMove != null && bMove != null) {
    return resolveRound(
      petMove: aMove,
      opponentMove: bMove,
      pet: a,
      opponent: b,
      rng: rng,
    );
  }
  if (aMove == null && bMove == null) {
    return const RoundOutcome(
      damageToOpponent: 0,
      damageToPet: 0,
      petHeal: 0,
      opponentHeal: 0,
      petCritical: false,
      opponentCritical: false,
      clash: 'Nobody moved',
    );
  }
  final aActs = aMove != null;
  final (damage, heal, critical) = _unopposed(
    aActs ? aMove : bMove!,
    actor: aActs ? a : b,
    target: aActs ? b : a,
    rng: rng,
  );
  return RoundOutcome(
    damageToOpponent: aActs ? damage : 0,
    damageToPet: aActs ? 0 : damage,
    petHeal: aActs ? heal : 0,
    opponentHeal: aActs ? 0 : heal,
    petCritical: aActs && critical,
    opponentCritical: !aActs && critical,
    clash: 'Missed turn!',
  );
}

// A move against someone who didn't show up: attacks and specials land in
// full, a defend just recovers a little HP
(int damage, int heal, bool critical) _unopposed(
  BattleMove move, {
  required Fighter actor,
  required Fighter target,
  required Random rng,
}) {
  final hit = rollHit(actor.attack, target.defense, rng);
  return switch (move) {
    BattleMove.attack => (hit.damage, 0, hit.critical),
    BattleMove.special => ((hit.damage * 1.6).round(), 0, hit.critical),
    BattleMove.defend => (0, (actor.maxHp * 0.05).round(), false),
  };
}

// A short play-by-play of a round for the player on side [mine]
String describeDuelRound({
  required BattleMove? myMove,
  required BattleMove? theirMove,
  required int dealt,
  required int taken,
  required String theirName,
}) {
  if (myMove == null && theirMove == null) {
    return 'Neither of you moved in time.';
  }
  if (myMove == null) {
    return "You missed your turn! $theirName's "
        '${theirMove!.name} landed for $taken.';
  }
  if (theirMove == null) {
    return '$theirName missed their turn! Your ${myMove.name} landed '
        'for $dealt.';
  }
  return 'Your ${myMove.name} met their ${theirMove.name}: '
      'you dealt $dealt and took $taken.';
}
