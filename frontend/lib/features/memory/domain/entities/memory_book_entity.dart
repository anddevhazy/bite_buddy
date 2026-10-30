import 'package:equatable/equatable.dart';

// Everything on the memory book screen: how far the buddy has come
class MemoryBookEntity extends Equatable {
  final String petName;
  final String speciesKey;
  final int? portraitId;
  final DateTime adoptedAt;
  // 1 on the day of adoption
  final int daysTogether;
  final ProgressSnapshotEntity dayOne;
  final ProgressSnapshotEntity today;
  // Oldest first
  final List<MemoryEntryEntity> memories;
  // Up to the last 26 weeks, oldest first, only days since adoption
  final List<FeedingDayEntity> feedingDays;
  // Oldest first
  final List<WeekProgressEntity> weeks;
  // Starts with level 1 at adoption
  final List<LevelPointEntity> levels;
  // Null until the buddy is two weeks old
  final NutrientBalanceEntity? firstWeekNutrients;
  final NutrientBalanceEntity? lastWeekNutrients;

  const MemoryBookEntity({
    required this.petName,
    required this.speciesKey,
    required this.portraitId,
    required this.adoptedAt,
    required this.daysTogether,
    required this.dayOne,
    required this.today,
    required this.memories,
    required this.feedingDays,
    required this.weeks,
    required this.levels,
    this.firstWeekNutrients,
    this.lastWeekNutrients,
  });

  @override
  List<Object?> get props => [petName, daysTogether, today, memories.length];
}

class ProgressSnapshotEntity extends Equatable {
  final int level;
  final int mealsEaten;
  final int bestStreak;
  final int wins;
  final int trophies;

  const ProgressSnapshotEntity({
    required this.level,
    required this.mealsEaten,
    required this.bestStreak,
    required this.wins,
    required this.trophies,
  });

  @override
  List<Object?> get props => [level, mealsEaten, bestStreak, wins, trophies];
}

class MemoryEntryEntity extends Equatable {
  final String key;
  final String emoji;
  final String title;
  final String? detail;
  final DateTime happenedAt;

  const MemoryEntryEntity({
    required this.key,
    required this.emoji,
    required this.title,
    required this.happenedAt,
    this.detail,
  });

  @override
  List<Object?> get props => [key, happenedAt];
}

class FeedingDayEntity extends Equatable {
  // The owner's local day, as a date with no time
  final DateTime day;
  final int meals;
  // 0 with no meals
  final int averageScore;

  const FeedingDayEntity({
    required this.day,
    required this.meals,
    required this.averageScore,
  });

  @override
  List<Object?> get props => [day, meals, averageScore];
}

class WeekProgressEntity extends Equatable {
  final DateTime weekStart;
  final int meals;
  // Null with no meals
  final int? averageScore;
  final int wins;

  const WeekProgressEntity({
    required this.weekStart,
    required this.meals,
    required this.averageScore,
    required this.wins,
  });

  @override
  List<Object?> get props => [weekStart, meals, averageScore, wins];
}

class LevelPointEntity extends Equatable {
  final int level;
  final DateTime reachedAt;

  const LevelPointEntity({required this.level, required this.reachedAt});

  @override
  List<Object?> get props => [level, reachedAt];
}

// Average share of the daily target per day with meals, in percent
class NutrientBalanceEntity extends Equatable {
  final int protein;
  final int carbs;
  final int fats;
  final int vitamins;
  final int minerals;
  final int fiber;

  const NutrientBalanceEntity({
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.vitamins,
    required this.minerals,
    required this.fiber,
  });

  List<(String, int)> get named => [
    ('Protein', protein),
    ('Carbs', carbs),
    ('Fats', fats),
    ('Vitamins', vitamins),
    ('Minerals', minerals),
    ('Fiber', fiber),
  ];

  @override
  List<Object?> get props => [protein, carbs, fats, vitamins, minerals, fiber];
}
