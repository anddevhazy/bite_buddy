import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/battle_engine.dart';
import '../utils/duel_rules.dart';
import '../utils/pet_stats.dart' as stats;
import '../utils/season.dart';
import 'pet_service.dart';

// Async turn-based battles between league friends. Deadlines are enforced
// lazily: whenever a duel is read or played, any rounds whose deadline has
// passed are resolved first, so no background job is needed.
class DuelService {
  final PetService pets;
  final Random _rng;

  DuelService({required this.pets, Random? rng}) : _rng = rng ?? Random();

  Future<DuelView> challenge(
    Session session,
    UuidValue userId,
    int leagueId,
    int opponentMemberId,
  ) async {
    return session.db.transaction((transaction) async {
      final me = await LeagueMember.db.findFirstRow(
        session,
        where: (t) => t.leagueId.equals(leagueId) & t.userId.equals(userId),
        transaction: transaction,
      );
      final them = await LeagueMember.db.findById(
        session,
        opponentMemberId,
        transaction: transaction,
      );
      if (me == null || them == null || them.leagueId != leagueId) {
        throw notFoundError('League member');
      }
      if (them.userId == userId) {
        throw invalidInputError("You can't battle yourself.");
      }

      final existing = await Duel.db.findFirstRow(
        session,
        where: (t) =>
            t.leagueId.equals(leagueId) &
            t.status.equals(DuelStatus.ongoing) &
            ((t.aUserId.equals(userId) & t.bUserId.equals(them.userId)) |
                (t.aUserId.equals(them.userId) & t.bUserId.equals(userId))),
        transaction: transaction,
      );
      if (existing != null) {
        throw conflictError(
          'DUEL_EXISTS',
          'You already have a battle going with this friend.',
        );
      }

      final myPet = await pets.requireMine(
        session,
        userId,
        transaction: transaction,
      );
      final theirPet = await pets.findMine(
        session,
        them.userId,
        transaction: transaction,
      );
      if (theirPet == null) {
        throw conflictError(
          'NO_PET',
          "Your friend hasn't adopted a buddy yet.",
        );
      }

      final a = stats.petFighter(myPet);
      final b = stats.petFighter(theirPet);
      final now = DateTime.now().toUtc();
      final duel = await Duel.db.insertRow(
        session,
        Duel(
          leagueId: leagueId,
          weekStart: weekStart(now),
          aUserId: userId,
          bUserId: them.userId,
          aPetName: myPet.name,
          bPetName: theirPet.name,
          aSpeciesKey: myPet.speciesKey,
          bSpeciesKey: theirPet.speciesKey,
          aPortraitId: myPet.portraitId,
          bPortraitId: theirPet.portraitId,
          aMaxHp: a.maxHp,
          bMaxHp: b.maxHp,
          aAttack: a.attack,
          bAttack: b.attack,
          aDefense: a.defense,
          bDefense: b.defense,
          aHp: a.maxHp,
          bHp: b.maxHp,
          aSpecialCooldown: 0,
          bSpecialCooldown: 0,
          aMissed: 0,
          bMissed: 0,
          aHistory: [],
          bHistory: [],
          round: 0,
          roundDeadline: now.add(duelTurnTime),
          status: DuelStatus.ongoing,
          createdAt: now,
        ),
        transaction: transaction,
      );
      return viewFor(duel, userId);
    });
  }

  Future<DuelView> get(Session session, UuidValue userId, int duelId) async {
    return session.db.transaction((transaction) async {
      final duel = await _load(session, userId, duelId, transaction);
      return viewFor(
        await catchUp(session, duel, transaction: transaction),
        userId,
      );
    });
  }

  Future<DuelView> move(
    Session session,
    UuidValue userId,
    int duelId,
    BattleMove move,
  ) async {
    return session.db.transaction((transaction) async {
      var duel = await catchUp(
        session,
        await _load(session, userId, duelId, transaction),
        transaction: transaction,
      );
      if (duel.status != DuelStatus.ongoing) {
        throw conflictError('BATTLE_OVER', 'This battle is already over.');
      }

      final isA = duel.aUserId == userId;
      if ((isA ? duel.aMove : duel.bMove) != null) {
        throw conflictError(
          'ALREADY_MOVED',
          "You've already picked your move this round.",
        );
      }
      final cooldown = isA ? duel.aSpecialCooldown : duel.bSpecialCooldown;
      if (move == BattleMove.special && cooldown > 0) {
        throw invalidInputError('Special is still recharging.');
      }

      duel = isA ? duel.copyWith(aMove: move) : duel.copyWith(bMove: move);
      if (duel.aMove != null && duel.bMove != null) {
        duel = _resolve(duel, DateTime.now().toUtc().add(duelTurnTime));
      }
      final saved = await Duel.db.updateRow(
        session,
        duel,
        transaction: transaction,
      );
      return viewFor(saved, userId);
    });
  }

  // The caller's duels in a league: ongoing first, then recent finished ones.
  // Overdue rounds are resolved on the way.
  Future<List<DuelView>> forLeague(
    Session session,
    UuidValue userId,
    int leagueId,
  ) async {
    final duels = await Duel.db.find(
      session,
      where: (t) =>
          t.leagueId.equals(leagueId) &
          (t.aUserId.equals(userId) | t.bUserId.equals(userId)),
      orderByList: (t) => [t.createdAt.desc()],
      limit: 30,
    );
    final views = <DuelView>[];
    for (final duel in duels) {
      final current = duel.status == DuelStatus.ongoing
          ? await session.db.transaction(
              (tx) => catchUp(session, duel, transaction: tx),
            )
          : duel;
      views.add(viewFor(current, userId));
    }
    final ongoing = views.where((d) => d.status == DuelStatus.ongoing);
    final finished = views
        .where((d) => d.status == DuelStatus.finished)
        .take(5);
    return [...ongoing, ...finished];
  }

  // Resolves every round whose deadline has passed and saves the duel
  Future<Duel> catchUp(
    Session session,
    Duel duel, {
    required Transaction transaction,
  }) async {
    final now = DateTime.now().toUtc();
    var current = duel;
    var changed = false;
    while (current.status == DuelStatus.ongoing &&
        !now.isBefore(current.roundDeadline)) {
      current = _resolve(
        current,
        current.roundDeadline.add(duelTurnTime),
        timedOut: true,
      );
      changed = true;
    }
    if (!changed) return duel;
    return Duel.db.updateRow(session, current, transaction: transaction);
  }

  // Plays out the current round with whatever moves are in (a missing move
  // means that player missed the deadline), then checks for an ending
  Duel _resolve(Duel d, DateTime nextDeadline, {bool timedOut = false}) {
    final outcome = resolveDuelRound(
      aMove: d.aMove,
      bMove: d.bMove,
      a: Fighter(maxHp: d.aMaxHp, attack: d.aAttack, defense: d.aDefense),
      b: Fighter(maxHp: d.bMaxHp, attack: d.bAttack, defense: d.bDefense),
      rng: _rng,
    );
    final aHp = (d.aHp - outcome.damageToPet + outcome.petHeal).clamp(
      0,
      d.aMaxHp,
    );
    final bHp = (d.bHp - outcome.damageToOpponent + outcome.opponentHeal).clamp(
      0,
      d.bMaxHp,
    );
    int cooldown(BattleMove? move, int current) => move == BattleMove.special
        ? specialCooldownRounds
        : max(0, current - 1);

    final aMissed = d.aMove == null ? d.aMissed + 1 : 0;
    final bMissed = d.bMove == null ? d.bMissed + 1 : 0;
    final round = d.round + 1;

    var next = d.copyWith(
      round: round,
      aHp: aHp,
      bHp: bHp,
      aSpecialCooldown: cooldown(d.aMove, d.aSpecialCooldown),
      bSpecialCooldown: cooldown(d.bMove, d.bSpecialCooldown),
      aMissed: aMissed,
      bMissed: bMissed,
      aHistory: [...d.aHistory, d.aMove],
      bHistory: [...d.bHistory, d.bMove],
      lastRound: DuelRound(
        round: round,
        aMove: d.aMove,
        bMove: d.bMove,
        damageToA: outcome.damageToPet,
        damageToB: outcome.damageToOpponent,
        aCritical: outcome.petCritical,
        bCritical: outcome.opponentCritical,
        clash: outcome.clash,
      ),
      roundDeadline: nextDeadline,
    );
    // copyWith can't clear nullable fields, so reset the secret moves directly
    next.aMove = null;
    next.bMove = null;

    final aOut = aHp == 0 || aMissed >= maxMissedInARow;
    final bOut = bHp == 0 || bMissed >= maxMissedInARow;
    final knockout = aHp == 0 || bHp == 0;
    if (aOut || bOut) {
      final UuidValue? winner;
      if (aOut && bOut) {
        winner = knockout && aHp != bHp
            ? (aHp > bHp ? d.aUserId : d.bUserId)
            : null; // both forfeited, or a true double knockout: a draw
      } else {
        winner = aOut ? d.bUserId : d.aUserId;
      }
      return _finish(next, winner, knockout ? 'Knockout' : 'Forfeit');
    }
    if (round >= maxRounds) {
      final aWins = petWinsTie(aHp, d.aMaxHp, bHp, d.bMaxHp);
      final even = aHp / d.aMaxHp == bHp / d.bMaxHp;
      return _finish(
        next,
        even ? null : (aWins ? d.aUserId : d.bUserId),
        "Time's up",
      );
    }
    return next;
  }

  Duel _finish(Duel d, UuidValue? winner, String reason) {
    final finished = d.copyWith(
      status: DuelStatus.finished,
      endReason: reason,
      finishedAt: DateTime.now().toUtc(),
    );
    finished.winnerUserId = winner;
    return finished;
  }

  Future<Duel> _load(
    Session session,
    UuidValue userId,
    int duelId,
    Transaction transaction,
  ) async {
    final duel = await Duel.db.findById(
      session,
      duelId,
      transaction: transaction,
    );
    if (duel == null || (duel.aUserId != userId && duel.bUserId != userId)) {
      throw notFoundError('Battle');
    }
    return duel;
  }

  // The duel from the caller's side. The other player's pending move is
  // never included, only whether they've made one.
  DuelView viewFor(Duel d, UuidValue userId) {
    final isA = d.aUserId == userId;
    final myMove = isA ? d.aMove : d.bMove;
    final theirMove = isA ? d.bMove : d.aMove;
    final theirHistory = isA ? d.bHistory : d.aHistory;
    final theirName = isA ? d.bPetName : d.aPetName;

    DuelRoundView? lastRound;
    final r = d.lastRound;
    if (r != null) {
      final mine = isA ? r.aMove : r.bMove;
      final theirs = isA ? r.bMove : r.aMove;
      final dealt = isA ? r.damageToB : r.damageToA;
      final taken = isA ? r.damageToA : r.damageToB;
      lastRound = DuelRoundView(
        round: r.round,
        myMove: mine,
        theirMove: theirs,
        damageDealt: dealt,
        damageTaken: taken,
        myCritical: isA ? r.aCritical : r.bCritical,
        theirCritical: isA ? r.bCritical : r.aCritical,
        clash: r.clash,
        message: describeDuelRound(
          myMove: mine,
          theirMove: theirs,
          dealt: dealt,
          taken: taken,
          theirName: theirName,
        ),
      );
    }

    final ongoing = d.status == DuelStatus.ongoing;
    return DuelView(
      id: d.id!,
      leagueId: d.leagueId,
      myPetName: isA ? d.aPetName : d.bPetName,
      mySpeciesKey: isA ? d.aSpeciesKey : d.bSpeciesKey,
      myPortraitId: isA ? d.aPortraitId : d.bPortraitId,
      theirPetName: theirName,
      theirSpeciesKey: isA ? d.bSpeciesKey : d.aSpeciesKey,
      theirPortraitId: isA ? d.bPortraitId : d.aPortraitId,
      myHp: isA ? d.aHp : d.bHp,
      myMaxHp: isA ? d.aMaxHp : d.bMaxHp,
      theirHp: isA ? d.bHp : d.aHp,
      theirMaxHp: isA ? d.bMaxHp : d.aMaxHp,
      myAttack: isA ? d.aAttack : d.bAttack,
      myDefense: isA ? d.aDefense : d.bDefense,
      theirAttack: isA ? d.bAttack : d.aAttack,
      theirDefense: isA ? d.bDefense : d.aDefense,
      mySpecialCooldown: isA ? d.aSpecialCooldown : d.bSpecialCooldown,
      round: d.round,
      roundDeadline: d.roundDeadline,
      yourTurn: ongoing && myMove == null,
      theyHaveMoved: ongoing && theirMove != null,
      youMissed: isA ? d.aMissed : d.bMissed,
      theirRecentMoves: theirHistory.length <= recentMovesShown
          ? theirHistory
          : theirHistory.sublist(theirHistory.length - recentMovesShown),
      lastRound: lastRound,
      status: d.status,
      result: ongoing
          ? null
          : d.winnerUserId == null
          ? 'draw'
          : d.winnerUserId == userId
          ? 'won'
          : 'lost',
      endReason: d.endReason,
    );
  }
}
