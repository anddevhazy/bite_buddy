import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// The memory book through the endpoint, and level-ups being recorded as
// they happen.
void main() {
  withServerpod('Memory book', (sessionBuilder, endpoints) {
    late UuidValue userId;
    late TestSessionBuilder user;

    setUp(() async {
      userId = const Uuid().v4obj();
      user = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId.toString(),
          {},
        ),
      );
      final key = (await endpoints.pet.listSpecies(user)).first.key;
      await endpoints.pet.adopt(user, key, 'Biscuit');
    });

    Future<Meal> scanned() => Meal.db.insertRow(
      user.build(),
      Meal(
        ownerId: userId,
        name: 'Jollof rice',
        description: '',
        calories: 500,
        proteinPct: 30,
        carbsPct: 40,
        fatsPct: 20,
        vitaminsPct: 30,
        mineralsPct: 30,
        fiberPct: 30,
        healthScore: 90,
        grade: 'A',
        imageHash: const Uuid().v4(),
        fed: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );

    test('a new buddy has day 1 and nothing else', () async {
      final book = await endpoints.memory.book(user);
      expect(book.petName, 'Biscuit');
      expect(book.daysTogether, 1);
      expect(book.memories.single.key, 'adopted');
      expect(book.feedingDays.single.meals, 0);
      expect(book.levels.single.level, 1);
    });

    test('feeding fills the book and level-ups are recorded', () async {
      var level = 1;
      for (var i = 0; i < 6 && level < 2; i++) {
        level = (await endpoints.meal.feed(
          user,
          (await scanned()).id!,
          0,
        )).pet.level;
      }
      expect(level, greaterThanOrEqualTo(2), reason: 'meals should level up');

      final book = await endpoints.memory.book(user);
      final keys = book.memories.map((m) => m.key);
      expect(
        keys,
        containsAll(['adopted', 'first_meal', 'first_a', 'level_2']),
      );
      expect(book.levels.map((l) => l.level), containsAll([1, 2]));
      expect(book.feedingDays.last.meals, greaterThan(0));
      expect(book.today.level, level);
    });
  });
}
