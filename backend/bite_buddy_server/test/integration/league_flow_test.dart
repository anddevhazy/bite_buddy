import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/season.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Two friends in a league: joining, the season table, a friend battle played
// round by round (including missed deadlines) and a season paying out once.
void main() {
  withServerpod('Leagues and friend battles', (sessionBuilder, endpoints) {
    late UuidValue aliceId, bobId;
    late TestSessionBuilder alice, bob;

    TestSessionBuilder signIn(UuidValue id) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        id.toString(),
        {},
      ),
    );

    setUp(() async {
      aliceId = const Uuid().v4obj();
      bobId = const Uuid().v4obj();
      alice = signIn(aliceId);
      bob = signIn(bobId);
      final key = (await endpoints.pet.listSpecies(alice)).first.key;
      await endpoints.pet.adopt(alice, key, 'Fluffy');
      await endpoints.pet.adopt(bob, key, 'Rex');
    });

    Future<void> feedMeal(UuidValue owner, int score, DateTime at) async {
      await Meal.db.insertRow(
        alice.build(),
        Meal(
          ownerId: owner,
          name: 'Salad',
          description: '',
          calories: 300,
          proteinPct: 20,
          carbsPct: 20,
          fatsPct: 10,
          vitaminsPct: 40,
          mineralsPct: 30,
          fiberPct: 40,
          healthScore: score,
          grade: 'A',
          imageHash: const Uuid().v4(),
          fed: true,
          createdAt: at,
        ),
      );
    }

    Future<(LeagueDetail, int bobMemberId)> leagueOfTwo() async {
      final created = await endpoints.league.create(alice, 'Lunch Crew');
      expect(created.inviteCode, hasLength(6));
      final joined = await endpoints.league.join(
        bob,
        created.inviteCode.toLowerCase(),
      );
      final bobRow = joined.standings.singleWhere((s) => s.isYou);
      return (joined, bobRow.memberId);
    }

    test('friends join with the invite code and see a shared table', () async {
      final (league, _) = await leagueOfTwo();
      expect(league.standings, hasLength(2));

      final mine = await endpoints.league.myLeagues(alice);
      expect(mine.single.name, 'Lunch Crew');
      expect(mine.single.memberCount, 2);

      // Joining twice is harmless; a wrong code is not found
      await endpoints.league.join(bob, league.inviteCode);
      await expectLater(
        endpoints.league.join(bob, 'NOPE00'),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test('eating well this week puts you on top', () async {
      final (league, _) = await leagueOfTwo();
      await feedMeal(aliceId, 90, DateTime.now().toUtc());
      await feedMeal(bobId, 40, DateTime.now().toUtc());

      final table = (await endpoints.league.detail(alice, league.id)).standings;
      expect(table.first.isYou, isTrue);
      expect(table.first.averageMealScore, 90);
      expect(table.first.totalScore, greaterThan(table.last.totalScore));
    });

    test('a friend battle plays out round by round', () async {
      final (league, bobMemberId) = await leagueOfTwo();
      var duel = await endpoints.duel.challenge(alice, league.id, bobMemberId);
      expect(duel.yourTurn, isTrue);

      // A second challenge to the same friend is refused while this one runs
      await expectLater(
        endpoints.duel.challenge(alice, league.id, bobMemberId),
        throwsA(isA<BiteBuddyException>()),
      );

      // Alice moves first: Bob sees that she moved, but not what she picked
      duel = await endpoints.duel.move(alice, duel.id, BattleMove.attack);
      expect(duel.yourTurn, isFalse);
      final bobView = await endpoints.duel.get(bob, duel.id);
      expect(bobView.yourTurn, isTrue);
      expect(bobView.theyHaveMoved, isTrue);
      expect(bobView.lastRound, isNull);

      // Once Bob moves, the round resolves for both of them
      final afterBob = await endpoints.duel.move(
        bob,
        duel.id,
        BattleMove.defend,
      );
      expect(afterBob.round, 1);
      expect(afterBob.lastRound!.myMove, BattleMove.defend);
      expect(afterBob.lastRound!.theirMove, BattleMove.attack);
      expect(afterBob.lastRound!.clash, 'Blocked & countered!');

      final aliceView = await endpoints.duel.get(alice, duel.id);
      expect(aliceView.theirRecentMoves, [BattleMove.defend]);

      // Moving twice in a round is refused
      await endpoints.duel.move(alice, duel.id, BattleMove.attack);
      await expectLater(
        endpoints.duel.move(alice, duel.id, BattleMove.attack),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test('missing two deadlines in a row forfeits the battle', () async {
      final (league, bobMemberId) = await leagueOfTwo();
      final duel = await endpoints.duel.challenge(
        alice,
        league.id,
        bobMemberId,
      );
      await endpoints.duel.move(alice, duel.id, BattleMove.defend);

      // Bob never moves. Wind the deadline back two days.
      final row = (await Duel.db.findById(alice.build(), duel.id))!;
      await Duel.db.updateRow(
        alice.build(),
        row.copyWith(
          roundDeadline: DateTime.now().toUtc().subtract(
            const Duration(days: 2),
          ),
        ),
      );

      // Round 1: Bob missed it. Round 2's deadline passed too, with nobody
      // moving. Bob's second miss in a row forfeits; Alice only missed one.
      final bobView = await endpoints.duel.get(bob, duel.id);
      expect(bobView.status, DuelStatus.finished);
      expect(bobView.result, 'lost');
      expect(bobView.endReason, 'Forfeit');
      expect(bobView.youMissed, 2);
      expect((await endpoints.duel.get(alice, duel.id)).result, 'won');

      final table = (await endpoints.league.detail(alice, league.id)).standings;
      final aliceRow = table.singleWhere((s) => s.isYou);
      expect(aliceRow.wins, 1);
      expect(aliceRow.battleScore, pointsPerWin);
    });

    test('a finished season pays the winner exactly once', () async {
      final (league, _) = await leagueOfTwo();

      // Move the league back a week and give Alice last week's best meals
      final lastWeek = weekStart(
        DateTime.now().toUtc(),
      ).subtract(const Duration(days: 7));
      final row = (await League.db.findById(alice.build(), league.id))!;
      await League.db.updateRow(
        alice.build(),
        row.copyWith(createdAt: lastWeek),
      );
      await feedMeal(aliceId, 95, lastWeek.add(const Duration(days: 1)));
      await feedMeal(bobId, 50, lastWeek.add(const Duration(days: 1)));

      final coinsBefore = (await endpoints.pet.getMyPet(alice))!.coins;

      // Both open the league; only the first settles the season (opening at
      // the same moment is covered by the concurrency group below)
      final views = [
        await endpoints.league.detail(alice, league.id),
        await endpoints.league.detail(bob, league.id),
      ];
      expect(views[0].lastSeasonWinner, 'Fluffy');
      expect(views[0].lastSeasonYourRank, 1);
      expect(views[1].lastSeasonYourRank, 2);

      await endpoints.league.detail(alice, league.id);
      final coinsAfter = (await endpoints.pet.getMyPet(alice))!.coins;
      expect(coinsAfter, coinsBefore + seasonWinnerCoins);

      final trophies = await endpoints.league.trophies(alice);
      expect(trophies.single.leagueName, 'Lunch Crew');
      expect(await endpoints.league.trophies(bob), isEmpty);
    });

    test(
      'leaving forfeits ongoing battles and hands over the league',
      () async {
        final (league, bobMemberId) = await leagueOfTwo();
        final duel = await endpoints.duel.challenge(
          alice,
          league.id,
          bobMemberId,
        );

        await endpoints.league.leave(alice, league.id);

        final bobView = await endpoints.duel.get(bob, duel.id);
        expect(bobView.result, 'won');
        final bobLeague = await endpoints.league.detail(bob, league.id);
        expect(bobLeague.isOwner, isTrue);
        expect(bobLeague.standings, hasLength(1));
        expect(await endpoints.league.myLeagues(alice), isEmpty);
      },
    );
  });

  // Real transactions, so several requests can settle a season at the same
  // moment. The unique index on SeasonResult must stop a second payout.
  withServerpod('Season payouts under concurrency', (
    sessionBuilder,
    endpoints,
  ) {
    test('people opening the league at once pay out once', () async {
      final aliceId = const Uuid().v4obj();
      final bobId = const Uuid().v4obj();
      TestSessionBuilder signIn(UuidValue id) => sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          id.toString(),
          {},
        ),
      );
      final alice = signIn(aliceId);
      final bob = signIn(bobId);
      final key = (await endpoints.pet.listSpecies(alice)).first.key;
      await endpoints.pet.adopt(alice, key, 'Fluffy');
      await endpoints.pet.adopt(bob, key, 'Rex');
      final league = await endpoints.league.create(alice, 'Race Crew');
      await endpoints.league.join(bob, league.inviteCode);

      final lastWeek = weekStart(
        DateTime.now().toUtc(),
      ).subtract(const Duration(days: 7));
      final row = (await League.db.findById(alice.build(), league.id))!;
      await League.db.updateRow(
        alice.build(),
        row.copyWith(createdAt: lastWeek),
      );
      await Meal.db.insertRow(
        alice.build(),
        Meal(
          ownerId: aliceId,
          name: 'Salad',
          description: '',
          calories: 300,
          proteinPct: 20,
          carbsPct: 20,
          fatsPct: 10,
          vitaminsPct: 40,
          mineralsPct: 30,
          fiberPct: 40,
          healthScore: 90,
          grade: 'A',
          imageHash: const Uuid().v4(),
          fed: true,
          createdAt: lastWeek.add(const Duration(days: 1)),
        ),
      );
      final before = (await endpoints.pet.getMyPet(alice))!.coins;

      await Future.wait([
        for (var i = 0; i < 4; i++)
          endpoints.league.detail(i.isEven ? alice : bob, league.id),
      ]);

      final after = (await endpoints.pet.getMyPet(alice))!.coins;
      expect(after, before + seasonWinnerCoins);
      expect(await endpoints.league.trophies(alice), hasLength(1));
    });
  }, rollbackDatabase: RollbackDatabase.disabled);
}
