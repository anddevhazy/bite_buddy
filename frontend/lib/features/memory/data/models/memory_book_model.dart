import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Converts the generated server models into this feature's entities
class MemoryBookModel {
  static MemoryBookEntity fromProtocol(MemoryBook b) => MemoryBookEntity(
    petName: b.petName,
    speciesKey: b.speciesKey,
    portraitId: b.portraitId,
    adoptedAt: b.adoptedAt.toLocal(),
    daysTogether: b.daysTogether,
    dayOne: _snapshot(b.dayOne),
    today: _snapshot(b.today),
    memories: [
      for (final m in b.memories)
        MemoryEntryEntity(
          key: m.key,
          emoji: m.emoji,
          title: m.title,
          detail: m.detail,
          happenedAt: m.happenedAt.toLocal(),
          keepsake: m.keepsake,
        ),
    ],
    // Local days arrive as UTC midnight; keep them as plain dates
    feedingDays: [
      for (final d in b.feedingDays)
        FeedingDayEntity(
          day: DateTime(d.day.year, d.day.month, d.day.day),
          meals: d.meals,
          averageScore: d.averageScore,
        ),
    ],
    weeks: [
      for (final w in b.weeks)
        WeekProgressEntity(
          weekStart: w.weekStart.toLocal(),
          meals: w.meals,
          averageScore: w.averageScore,
          wins: w.wins,
        ),
    ],
    levels: [
      for (final l in b.levels)
        LevelPointEntity(level: l.level, reachedAt: l.reachedAt.toLocal()),
    ],
    firstWeekNutrients: _balance(b.firstWeekNutrients),
    lastWeekNutrients: _balance(b.lastWeekNutrients),
  );

  static ProgressSnapshotEntity _snapshot(ProgressSnapshot s) =>
      ProgressSnapshotEntity(
        level: s.level,
        mealsEaten: s.mealsEaten,
        bestStreak: s.bestStreak,
        wins: s.wins,
        trophies: s.trophies,
      );

  static NutrientBalanceEntity? _balance(NutrientBalance? n) => n == null
      ? null
      : NutrientBalanceEntity(
          protein: n.protein,
          carbs: n.carbs,
          fats: n.fats,
          vitamins: n.vitamins,
          minerals: n.minerals,
          fiber: n.fiber,
        );
}
