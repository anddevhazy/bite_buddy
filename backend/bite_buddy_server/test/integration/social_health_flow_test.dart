import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/activity_rules.dart';
import 'package:bite_buddy_server/src/utils/pet_stats.dart';
import 'package:bite_buddy_server/src/utils/shared_streak.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Shared streaks between league friends, health syncs, and cached meal
// ideas. The AI isn't called: meal ideas are tested from the cache.
void main() {
  withServerpod('Shared streaks, activity and meal ideas', (
    sessionBuilder,
    endpoints,
  ) {
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

    Future<Meal> scanned(UuidValue owner) => Meal.db.insertRow(
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
        healthScore: 80,
        grade: 'A',
        imageHash: const Uuid().v4(),
        fed: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );

    Future<void> beFriends() async {
      final league = await endpoints.league.create(alice, 'Lunch Crew');
      await endpoints.league.join(bob, league.inviteCode);
    }

    test('only league friends can be invited to a shared streak', () async {
      await expectLater(
        endpoints.streak.invite(alice, bobId),
        throwsA(isA<BiteBuddyException>()),
      );
      expect(await endpoints.streak.candidates(alice), isEmpty);

      await beFriends();
      final candidates = await endpoints.streak.candidates(alice);
      expect(candidates.single.petName, 'Rex');
    });

    test(
      'a shared streak grows when both friends feed, and pays both',
      () async {
        await beFriends();
        final invite = await endpoints.streak.invite(alice, bobId);
        expect(invite.status, StreakBuddyStatus.invited);
        expect(
          (await endpoints.streak.mine(bob)).single.status,
          StreakBuddyStatus.incoming,
        );
        await expectLater(
          endpoints.streak.invite(bob, aliceId),
          throwsA(isA<BiteBuddyException>()),
        );
        // Only the invited friend can accept
        await expectLater(
          endpoints.streak.accept(alice, invite.id),
          throwsA(isA<BiteBuddyException>()),
        );
        await endpoints.streak.accept(bob, invite.id);
        expect(await endpoints.streak.candidates(alice), isEmpty);

        final aliceFed = await endpoints.meal.feed(
          alice,
          (await scanned(aliceId)).id!,
          0,
        );
        expect(aliceFed.sharedStreaksGrown, 0);
        var view = (await endpoints.streak.mine(bob)).single;
        expect(view.friendFedToday, isTrue);
        expect(view.youFedToday, isFalse);
        expect(view.streak, 0);

        final bobCoinsBefore = (await endpoints.pet.getMyPet(bob))!.coins;
        final aliceCoinsBefore = (await endpoints.pet.getMyPet(alice))!.coins;
        final bobFed = await endpoints.meal.feed(
          bob,
          (await scanned(bobId)).id!,
          0,
        );
        expect(bobFed.sharedStreaksGrown, 1);
        expect(
          bobFed.pet.coins,
          greaterThanOrEqualTo(bobCoinsBefore + sharedStreakCoins),
        );
        expect(
          (await endpoints.pet.getMyPet(alice))!.coins,
          aliceCoinsBefore + sharedStreakCoins,
        );

        view = (await endpoints.streak.mine(alice)).single;
        expect(view.status, StreakBuddyStatus.active);
        expect(view.streak, 1);
        expect(view.youFedToday && view.friendFedToday, isTrue);

        await endpoints.streak.remove(alice, view.id);
        expect(await endpoints.streak.mine(bob), isEmpty);
      },
    );

    test('a health sync pays each day once, up to the caps', () async {
      final before = (await endpoints.pet.getMyPet(alice))!;
      // Drain energy so the gain shows
      await Pet.db.updateRow(
        alice.build(),
        before.copyWith(energy: 50, health: 50),
      );

      var r = await endpoints.activity.sync(alice, 3200, 7 * 60 + 30, 0);
      expect(r.energyGained, 3);
      expect(r.healthGained, sleepHealth);
      expect(r.pet.energy, 53);

      // Same totals again: nothing new
      r = await endpoints.activity.sync(alice, 3200, 7 * 60 + 30, 0);
      expect(r.energyGained, 0);
      expect(r.healthGained, 0);

      // More steps later, and a lower bogus reading can't take it back
      r = await endpoints.activity.sync(alice, 50000, 0, 0);
      expect(r.energyGained, maxActivityEnergyPerDay - 3);
      expect(r.energyToday, maxActivityEnergyPerDay);
      expect(r.sleepMinutes, 7 * 60 + 30);
      expect(r.pet.energy, 50 + maxActivityEnergyPerDay);

      await expectLater(
        endpoints.activity.sync(alice, -1, 0, 0),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test("today's meal ideas come from the cache", () async {
      final pet = (await endpoints.pet.getMyPet(alice))!;
      await MealIdeas.db.insertRow(
        alice.build(),
        MealIdeas(
          ownerId: aliceId,
          day: localDay(DateTime.now(), pet.utcOffsetMinutes),
          ideas: [
            MealSuggestion(
              name: 'Moi moi',
              reason: 'Protein from beans.',
              boosts: ['protein'],
            ),
          ],
          createdAt: DateTime.now().toUtc(),
        ),
      );
      final ideas = await endpoints.meal.ideas(alice, 'en_NG');
      expect(ideas.single.name, 'Moi moi');
    });

    test('a league shows its weekly team challenge', () async {
      final league = await endpoints.league.create(alice, 'Gym Buddies');
      expect(league.challenge.target, greaterThan(0));
      expect(league.challenge.completed, isFalse);
      expect(league.challenge.rewardCoins, greaterThan(0));
    });
  });
}
