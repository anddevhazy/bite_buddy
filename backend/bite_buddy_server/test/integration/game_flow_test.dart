import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Walks one user through the core loop: adopt a pet, feed it a meal, check
// the leaderboard, and fight a battle to the end. The food scan itself calls
// the Claude API, so these tests insert the scanned meal directly.
void main() {
  withServerpod('Bite Buddy game flow', (sessionBuilder, endpoints) {
    final userId = const Uuid().v4obj();
    final signedIn = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    Future<Meal> insertScannedMeal({int healthScore = 80}) => Meal.db.insertRow(
      signedIn.build(),
      Meal(
        ownerId: userId,
        name: 'Rice and Beans',
        description: 'A plate of jollof rice with beans.',
        calories: 520,
        proteinPct: 30,
        carbsPct: 45,
        fatsPct: 15,
        vitaminsPct: 20,
        mineralsPct: 25,
        fiberPct: 35,
        healthScore: healthScore,
        grade: 'B',
        imageHash: const Uuid().v4(),
        fed: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );

    test('anonymous calls are rejected', () async {
      await expectLater(
        endpoints.pet.getMyPet(sessionBuilder),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test('a new user has no pet and can adopt one', () async {
      expect(await endpoints.pet.getMyPet(signedIn), isNull);

      final species = await endpoints.pet.listSpecies(signedIn);
      expect(species, isNotEmpty);

      final pet = await endpoints.pet.adopt(
        signedIn,
        species.first.key,
        'Fluffy',
      );
      expect(pet.name, 'Fluffy');
      expect(pet.health, 100);
      expect(pet.level, 1);

      expect((await endpoints.pet.getMyPet(signedIn))?.id, pet.id);
    });

    test('a user can only adopt one pet', () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      await endpoints.pet.adopt(signedIn, key, 'Fluffy');

      await expectLater(
        endpoints.pet.adopt(signedIn, key, 'Second'),
        throwsA(
          isA<BiteBuddyException>().having((e) => e.code, 'code', 'PET_EXISTS'),
        ),
      );
    });

    test('feeding a meal raises nutrition, puts the pet on the leaderboard, '
        'and the same meal cannot be fed twice', () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      await endpoints.pet.adopt(signedIn, key, 'Fluffy');
      final meal = await insertScannedMeal(healthScore: 80);

      final result = await endpoints.meal.feed(signedIn, meal.id!, 60);
      expect(result.pet.nutrition, 80);
      expect(result.pet.mealsEaten, 1);
      expect(result.xpGained, greaterThan(0));
      expect(result.pet.streak, 1);
      expect(result.streakExtended, isTrue);

      final insights = await endpoints.meal.insights(signedIn);
      expect(insights.mealsCounted, 1);
      expect(insights.averageHealthScore, 80);
      expect(insights.tips, isNotEmpty);

      final board = await endpoints.leaderboard.top(signedIn);
      final me = board.singleWhere((e) => e.isYou);
      expect(me.nutrition, 80);

      await expectLater(
        endpoints.meal.feed(signedIn, meal.id!, 60),
        throwsA(isA<BiteBuddyException>()),
      );

      final history = await endpoints.meal.history(signedIn);
      expect(history.single.fed, isTrue);
    });

    ArenaRunReport report({
      required bool won,
      required int durationMs,
      required int damageDealt,
      int damageTaken = 10,
    }) => ArenaRunReport(
      won: won,
      durationMs: durationMs,
      damageDealt: damageDealt,
      damageTaken: damageTaken,
      hitsLanded: 5,
    );

    test('a real-time fight is set up, reported and paid out', () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      final before = await endpoints.pet.adopt(signedIn, key, 'Fluffy');

      final arena = await endpoints.battle.arena(signedIn);
      expect(arena.petStats.hp, greaterThan(0));
      final pup = arena.opponents.first;
      expect(pup.windupMs, greaterThan(arena.opponents.last.windupMs));

      final run = await endpoints.battle.startRun(signedIn, pup.key);
      expect(run.opponent.key, pup.key);
      expect(run.rules.attackCooldownMs, greaterThan(0));

      // Pretend the fight took a while: wind the start back 30 seconds
      final row = (await ArenaRun.db.findById(signedIn.build(), run.runId))!;
      await ArenaRun.db.updateRow(
        signedIn.build(),
        row.copyWith(
          startedAt: row.startedAt.subtract(const Duration(seconds: 30)),
        ),
      );

      final result = await endpoints.battle.finishRun(
        signedIn,
        run.runId,
        report(
          won: true,
          durationMs: 25000,
          damageDealt: pup.hp * run.rules.hpMultiplier,
        ),
      );
      expect(result.won, isTrue);
      expect(result.verified, isTrue);
      expect(result.coinsEarned, pup.coinReward);

      final after = (await endpoints.pet.getMyPet(signedIn))!;
      expect(after.wins, 1);
      expect(after.coins, before.coins + pup.coinReward);
      expect(after.energy, before.energy + result.energyChange);

      // A run can only be reported once
      await expectLater(
        endpoints.battle.finishRun(
          signedIn,
          run.runId,
          report(
            won: true,
            durationMs: 25000,
            damageDealt: pup.hp * run.rules.hpMultiplier,
          ),
        ),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test('an impossible win is rejected and counts as a loss', () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      await endpoints.pet.adopt(signedIn, key, 'Fluffy');
      final golem = (await endpoints.battle.arena(signedIn)).opponents.last;
      final run = await endpoints.battle.startRun(signedIn, golem.key);

      // Claims a 2-minute win, but the fight only started a moment ago
      final result = await endpoints.battle.finishRun(
        signedIn,
        run.runId,
        report(
          won: true,
          durationMs: 120000,
          damageDealt: golem.hp * run.rules.hpMultiplier,
        ),
      );
      expect(result.won, isFalse);
      expect(result.verified, isFalse);
      expect(result.coinsEarned, 0);
      expect((await endpoints.pet.getMyPet(signedIn))!.losses, 1);
    });

    test(
      'starting a new fight abandons the unfinished one as a loss',
      () async {
        final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
        await endpoints.pet.adopt(signedIn, key, 'Fluffy');
        final pup = (await endpoints.battle.arena(signedIn)).opponents.first;
        final first = await endpoints.battle.startRun(signedIn, pup.key);
        await endpoints.battle.startRun(signedIn, pup.key);

        expect((await endpoints.pet.getMyPet(signedIn))!.losses, 1);
        await expectLater(
          endpoints.battle.finishRun(
            signedIn,
            first.runId,
            report(won: false, durationMs: 1000, damageDealt: 0),
          ),
          throwsA(isA<BiteBuddyException>()),
        );
      },
    );

    test("one user can't report another user's fight", () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      await endpoints.pet.adopt(signedIn, key, 'Fluffy');
      final pup = (await endpoints.battle.arena(signedIn)).opponents.first;
      final run = await endpoints.battle.startRun(signedIn, pup.key);

      final intruder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          const Uuid().v4(),
          {},
        ),
      );
      await expectLater(
        endpoints.battle.finishRun(
          intruder,
          run.runId,
          report(
            won: true,
            durationMs: 9000,
            damageDealt: pup.hp * run.rules.hpMultiplier,
          ),
        ),
        throwsA(isA<BiteBuddyException>()),
      );
    });
  });
}
