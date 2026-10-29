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

    test('a battle runs to a finish and pays out', () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      final before = await endpoints.pet.adopt(signedIn, key, 'Fluffy');

      final arena = await endpoints.battle.arena(signedIn);
      final opponents = arena.opponents;
      expect(opponents, isNotEmpty);
      expect(arena.petStats.hp, greaterThan(0));
      for (final o in opponents) {
        expect(o.winChance, inInclusiveRange(0, 100));
      }
      // Weakest opponent first, so win chances only go down the list
      final chances = [for (final o in opponents) o.winChance];
      expect(chances, orderedEquals([...chances]..sort((a, b) => b - a)));

      var state = await endpoints.battle.start(signedIn, opponents.first.key);
      expect(state.battle.status, BattleStatus.ongoing);
      // The app sees a tell, never the opponent's real next move
      expect(state.battle.opponentTell, isNotNull);
      expect(
        state.battle.toJsonForProtocol(),
        isNot(contains('opponentNextMove')),
      );

      while (state.battle.status == BattleStatus.ongoing) {
        final move = state.battle.specialCooldown == 0
            ? BattleMove.special
            : BattleMove.attack;
        state = await endpoints.battle.move(signedIn, state.battle.id!, move);
      }

      final battle = state.battle;
      expect(battle.round, lessThanOrEqualTo(30));
      final after = (await endpoints.pet.getMyPet(signedIn))!;
      expect(after.wins + after.losses, 1);
      expect(after.coins, before.coins + battle.coinsEarned);
      expect(after.energy, before.energy + battle.energyChange);

      await expectLater(
        endpoints.battle.move(signedIn, battle.id!, BattleMove.attack),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test("one user can't play another user's battle", () async {
      final key = (await endpoints.pet.listSpecies(signedIn)).first.key;
      await endpoints.pet.adopt(signedIn, key, 'Fluffy');
      final opponent = (await endpoints.battle.arena(signedIn)).opponents.first;
      final state = await endpoints.battle.start(signedIn, opponent.key);

      final intruder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          const Uuid().v4(),
          {},
        ),
      );
      await expectLater(
        endpoints.battle.move(intruder, state.battle.id!, BattleMove.attack),
        throwsA(isA<BiteBuddyException>()),
      );
    });
  });
}
