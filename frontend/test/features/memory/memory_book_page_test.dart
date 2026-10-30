import 'dart:math';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy/features/memory/domain/repositories/memory_repository.dart';
import 'package:bite_buddy/features/memory/domain/usecases/fetch_memory_book_usecase.dart';
import 'package:bite_buddy/features/memory/presentation/bloc/memory_book_cubit.dart';
import 'package:bite_buddy/features/memory/presentation/pages/memory_book_page.dart';
import 'package:bite_buddy/features/memory/presentation/widgets/progress_charts.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepository implements MemoryRepository {
  final MemoryBookEntity book;

  _FakeRepository(this.book);

  @override
  Future<Either<Failure, MemoryBookEntity>> fetchBook() async => Right(book);
}

// 40 days with a buddy: meals most days, a few level-ups and wins
MemoryBookEntity sampleBook() {
  final rng = Random(4);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final adopted = today.subtract(const Duration(days: 39));
  final days = [
    for (var i = 0; i < 40; i++)
      FeedingDayEntity(
        day: adopted.add(Duration(days: i)),
        meals: rng.nextInt(10) < 2 ? 0 : 1 + rng.nextInt(4),
        averageScore: 50 + i,
      ),
  ];
  final monday = adopted.subtract(Duration(days: adopted.weekday - 1));
  return MemoryBookEntity(
    petName: 'Biscuit',
    speciesKey: 'fluffy',
    portraitId: null,
    adoptedAt: adopted,
    daysTogether: 40,
    dayOne: const ProgressSnapshotEntity(
      level: 1,
      mealsEaten: 0,
      bestStreak: 0,
      wins: 0,
      trophies: 0,
    ),
    today: const ProgressSnapshotEntity(
      level: 5,
      mealsEaten: 74,
      bestStreak: 9,
      wins: 11,
      trophies: 1,
    ),
    memories: [
      MemoryEntryEntity(
        key: 'adopted',
        emoji: '🐣',
        title: 'Adopted Biscuit',
        detail: 'Day 1 of your journey together',
        happenedAt: adopted,
      ),
      MemoryEntryEntity(
        key: 'first_meal',
        emoji: '🍽️',
        title: 'First meal',
        detail: 'Jollof rice',
        happenedAt: adopted.add(const Duration(hours: 3)),
      ),
      MemoryEntryEntity(
        key: 'streak_7',
        emoji: '🔥',
        title: '7-day streak',
        happenedAt: adopted.add(const Duration(days: 8)),
      ),
    ],
    feedingDays: days,
    weeks: [
      for (var w = 0; w < 7; w++)
        WeekProgressEntity(
          weekStart: monday.add(Duration(days: 7 * w)),
          meals: 10 + w,
          averageScore: w == 2 ? null : 55 + w * 5,
          wins: [0, 1, 2, 0, 3, 2, 3][w],
        ),
    ],
    levels: [
      for (final (l, d) in [(1, 0), (2, 5), (3, 12), (4, 22), (5, 33)])
        LevelPointEntity(
          level: l,
          reachedAt: adopted.add(Duration(days: d)),
        ),
    ],
    firstWeekNutrients: const NutrientBalanceEntity(
      protein: 30,
      carbs: 90,
      fats: 80,
      vitamins: 20,
      minerals: 35,
      fiber: 25,
    ),
    lastWeekNutrients: const NutrientBalanceEntity(
      protein: 70,
      carbs: 85,
      fats: 60,
      vitamins: 65,
      minerals: 60,
      fiber: 55,
    ),
  );
}

void main() {
  setUp(() {
    sl.registerFactory<MemoryBookCubit>(
      () => MemoryBookCubit(
        fetchMemoryBookUseCase: FetchMemoryBookUseCase(
          repository: _FakeRepository(sampleBook()),
        ),
      ),
    );
  });

  tearDown(() => sl.reset());

  testWidgets('shows days together, day 1 vs today, charts and memories', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 3200));
    await tester.pumpWidget(const MaterialApp(home: MemoryBookPage()));
    await tester.pumpAndSettle();

    expect(find.text('40'), findsOneWidget);
    expect(find.text('days with Biscuit'), findsOneWidget);
    expect(find.text('Day 1 vs today'), findsOneWidget);
    expect(find.text('+74'), findsOneWidget);
    expect(find.text('Feeding calendar'), findsOneWidget);
    expect(find.text('Then and now'), findsOneWidget);
    expect(find.text('7-day streak'), findsOneWidget);

    // Tapping the calendar names the day
    expect(find.text('Tap the chart for details'), findsWidgets);
    final calendar = find.descendant(
      of: find.byType(FeedingCalendar),
      matching: find.byType(CustomPaint),
    );
    await tester.tapAt(tester.getTopLeft(calendar) + const Offset(4, 4));
    await tester.pump();
    expect(find.textContaining(' · '), findsWidgets);
  });
}
