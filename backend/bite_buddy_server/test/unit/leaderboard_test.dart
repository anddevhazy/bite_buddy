import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/leaderboard.dart';
import 'package:bite_buddy_server/src/utils/pet_stats.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final now = DateTime.utc(2026, 10, 29, 12);
  final me = const Uuid().v4obj();

  Pet pet(
    int id,
    int nutrition, {
    int level = 1,
    UuidValue? owner,
    Duration lastFed = const Duration(hours: 1),
  }) {
    final fedAt = now.subtract(lastFed);
    return newPet(
      ownerId: owner ?? const Uuid().v4obj(),
      speciesKey: 'fluffy',
      name: 'Pet $id',
      now: fedAt,
    ).copyWith(
      id: id,
      nutrition: nutrition,
      level: level,
      mealsEaten: 1,
      lastFedAt: fedAt,
      lastDecayAt: fedAt,
    );
  }

  test('ranks by nutrition, then level', () {
    final board = rankLeaderboard(
      [pet(1, 60), pet(2, 80), pet(3, 60, level: 4)],
      me,
      now,
      size: 50,
    );
    expect(board.map((e) => e.petId), [2, 3, 1]);
    expect(board.map((e) => e.rank), [1, 2, 3]);
  });

  test('an inactive pet is ranked with its hunger decay applied', () {
    // Fed 2 days ago: 40 hours past the 8-hour grace, so nutrition 90 -> 50
    final inactive = pet(1, 90, lastFed: const Duration(hours: 48));
    final active = pet(2, 70);

    final board = rankLeaderboard([inactive, active], me, now, size: 50);
    expect(board.first.petId, 2);
    expect(board[1].nutrition, 50);
  });

  test("adds the caller's pet with its real rank when outside the top", () {
    final pets = [
      for (var i = 1; i <= 5; i++) pet(i, 100 - i),
      pet(99, 10, owner: me),
    ];
    final board = rankLeaderboard(pets, me, now, size: 3);
    expect(board.map((e) => e.rank), [1, 2, 3, 6]);
    expect(board.last.isYou, isTrue);
    expect(board.where((e) => e.isYou), hasLength(1));
  });

  test('does not repeat the caller when already in the top', () {
    final board = rankLeaderboard(
      [pet(1, 90, owner: me), pet(2, 50)],
      me,
      now,
      size: 1,
    );
    expect(board, hasLength(1));
    expect(board.single.isYou, isTrue);
  });
}
