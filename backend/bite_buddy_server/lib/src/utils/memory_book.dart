import '../generated/protocol.dart';
import 'catalog.dart';
import 'pet_stats.dart';
import 'season.dart';

// The memory book: milestones and progress charts, worked out from what the
// game already records. Plain functions with no database, so the rules are
// easy to test.

const mealMilestones = [10, 25, 50, 100, 250, 500, 1000];
const streakMilestones = [3, 7, 14, 30, 60, 100, 365];
const calendarDays = 26 * 7;
const chartWeeks = 26;
const bigStepDay = 10000;
const nutrientWindow = Duration(days: 7);

class MemoryInputs {
  final Pet pet;
  // Every meal the pet was fed, any order
  final List<Meal> fedMeals;
  final List<LevelUp> levelUps;
  final List<ArenaRun> arenaWins;
  // When each friend battle the owner won finished
  final List<DateTime> duelWins;
  final List<Trophy> trophies;
  final DateTime? firstLeagueJoinedAt;
  // The local day of the first 10,000-step day, if any
  final DateTime? firstBigStepDay;
  final DateTime now;

  const MemoryInputs({
    required this.pet,
    required this.fedMeals,
    required this.levelUps,
    required this.arenaWins,
    required this.duelWins,
    required this.trophies,
    required this.now,
    this.firstLeagueJoinedAt,
    this.firstBigStepDay,
  });
}

MemoryBook buildMemoryBook(MemoryInputs input) {
  final pet = input.pet;
  final offset = pet.utcOffsetMinutes;
  final meals = [...input.fedMeals]
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  DateTime day(DateTime t) => localDay(t, offset);
  final adoptedDay = day(pet.createdAt);
  final today = day(input.now);

  return MemoryBook(
    petName: pet.name,
    speciesKey: pet.speciesKey,
    portraitId: pet.portraitId,
    adoptedAt: pet.createdAt,
    daysTogether: today.difference(adoptedDay).inDays + 1,
    dayOne: ProgressSnapshot(
      level: 1,
      mealsEaten: 0,
      bestStreak: 0,
      wins: 0,
      trophies: 0,
    ),
    today: ProgressSnapshot(
      level: pet.level,
      mealsEaten: pet.mealsEaten,
      bestStreak: pet.bestStreak,
      wins: pet.wins + input.duelWins.length,
      trophies: input.trophies.length,
    ),
    memories: _memories(input, meals, day),
    feedingDays: _feedingDays(meals, day, adoptedDay, today),
    weeks: _weeks(input, meals),
    levels: [
      LevelPoint(level: 1, reachedAt: pet.createdAt),
      for (final l in [
        ...input.levelUps,
      ]..sort((a, b) => a.reachedAt.compareTo(b.reachedAt)))
        LevelPoint(level: l.level, reachedAt: l.reachedAt),
    ],
    firstWeekNutrients: _hasTwoWeeks(input)
        ? _balance(
            meals.where(
              (m) => m.createdAt.isBefore(pet.createdAt.add(nutrientWindow)),
            ),
            day,
          )
        : null,
    lastWeekNutrients: _hasTwoWeeks(input)
        ? _balance(
            meals.where(
              (m) => m.createdAt.isAfter(input.now.subtract(nutrientWindow)),
            ),
            day,
          )
        : null,
  );
}

bool _hasTwoWeeks(MemoryInputs input) =>
    input.now.difference(input.pet.createdAt) >= nutrientWindow * 2;

List<MemoryEntry> _memories(
  MemoryInputs input,
  List<Meal> meals,
  DateTime Function(DateTime) day,
) {
  final pet = input.pet;
  final entries = <MemoryEntry>[
    MemoryEntry(
      key: 'adopted',
      emoji: '🐣',
      title: 'Adopted ${pet.name}',
      detail: 'Day 1 of your journey together',
      happenedAt: pet.createdAt,
    ),
  ];

  if (meals.isNotEmpty) {
    entries.add(
      MemoryEntry(
        key: 'first_meal',
        emoji: '🍽️',
        title: 'First meal',
        detail: meals.first.name,
        happenedAt: meals.first.createdAt,
      ),
    );
  }
  for (final n in mealMilestones) {
    if (meals.length < n) break;
    entries.add(
      MemoryEntry(
        key: 'meals_$n',
        emoji: '🍱',
        title: '$n meals eaten',
        happenedAt: meals[n - 1].createdAt,
      ),
    );
  }
  final firstA = meals.where((m) => gradeFor(m.healthScore) == 'A').firstOrNull;
  if (firstA != null) {
    entries.add(
      MemoryEntry(
        key: 'first_a',
        emoji: '⭐',
        title: 'First A-grade meal',
        detail: firstA.name,
        happenedAt: firstA.createdAt,
      ),
    );
  }

  // Streaks: walk the days with meals in order, noting when each milestone
  // was first reached (at that day's first meal)
  DateTime? previous;
  var streak = 0;
  final reached = <int>{};
  for (final m in meals) {
    final d = day(m.createdAt);
    if (d == previous) continue;
    streak = previous != null && d.difference(previous).inDays == 1
        ? streak + 1
        : 1;
    previous = d;
    for (final n in streakMilestones) {
      if (streak == n && reached.add(n)) {
        entries.add(
          MemoryEntry(
            key: 'streak_$n',
            emoji: '🔥',
            title: '$n-day streak',
            happenedAt: m.createdAt,
          ),
        );
      }
    }
  }

  for (final l in input.levelUps) {
    entries.add(
      MemoryEntry(
        key: 'level_${l.level}',
        emoji: '⬆️',
        title: 'Reached level ${l.level}',
        happenedAt: l.reachedAt,
      ),
    );
  }

  // The first win against each opponent
  final beaten = <String>{};
  for (final run
      in [...input.arenaWins]..sort(
        (a, b) => (a.finishedAt ?? a.startedAt).compareTo(
          b.finishedAt ?? b.startedAt,
        ),
      )) {
    if (!beaten.add(run.opponentKey)) continue;
    final opponent = findOpponent(run.opponentKey);
    entries.add(
      MemoryEntry(
        key: 'beat_${run.opponentKey}',
        emoji: opponent?.emoji ?? '⚔️',
        title: beaten.length == 1 ? 'First battle won' : 'New rival beaten',
        detail: 'Beat ${opponent?.name ?? 'an opponent'}',
        happenedAt: run.finishedAt ?? run.startedAt,
      ),
    );
  }

  if (input.duelWins.isNotEmpty) {
    entries.add(
      MemoryEntry(
        key: 'first_duel_win',
        emoji: '🤺',
        title: 'First friend battle won',
        happenedAt: input.duelWins.reduce((a, b) => a.isBefore(b) ? a : b),
      ),
    );
  }
  if (input.firstLeagueJoinedAt case final joined?) {
    entries.add(
      MemoryEntry(
        key: 'first_league',
        emoji: '👥',
        title: 'Joined a friend league',
        happenedAt: joined,
      ),
    );
  }
  for (final t in input.trophies) {
    entries.add(
      MemoryEntry(
        key: 'trophy_${t.leagueId}_${t.weekStart.millisecondsSinceEpoch}',
        emoji: '🏆',
        title: 'Won the week in ${t.leagueName}',
        detail: 'Season score ${t.score}',
        happenedAt: weekEnd(t.weekStart),
      ),
    );
  }
  if (input.firstBigStepDay case final stepDay?) {
    entries.add(
      MemoryEntry(
        key: 'steps_10k',
        emoji: '👟',
        title: 'First 10,000-step day',
        happenedAt: stepDay,
      ),
    );
  }

  return entries..sort((a, b) => a.happenedAt.compareTo(b.happenedAt));
}

List<FeedingDay> _feedingDays(
  List<Meal> meals,
  DateTime Function(DateTime) day,
  DateTime adoptedDay,
  DateTime today,
) {
  final byDay = <DateTime, List<int>>{};
  for (final m in meals) {
    byDay.putIfAbsent(day(m.createdAt), () => []).add(m.healthScore);
  }
  var start = today.subtract(const Duration(days: calendarDays - 1));
  if (start.isBefore(adoptedDay)) start = adoptedDay;
  return [
    for (
      var d = start;
      !d.isAfter(today);
      d = DateTime.utc(d.year, d.month, d.day + 1)
    )
      FeedingDay(
        day: d,
        meals: byDay[d]?.length ?? 0,
        averageScore: _average(byDay[d]) ?? 0,
      ),
  ];
}

List<WeekProgress> _weeks(MemoryInputs input, List<Meal> meals) {
  final current = weekStart(input.now);
  var first = weekStart(input.pet.createdAt);
  final oldest = current.subtract(const Duration(days: 7 * (chartWeeks - 1)));
  if (first.isBefore(oldest)) first = oldest;

  final scores = <DateTime, List<int>>{};
  for (final m in meals) {
    scores.putIfAbsent(weekStart(m.createdAt), () => []).add(m.healthScore);
  }
  final wins = <DateTime, int>{};
  for (final t in [
    for (final r in input.arenaWins) r.finishedAt ?? r.startedAt,
    ...input.duelWins,
  ]) {
    wins.update(weekStart(t), (n) => n + 1, ifAbsent: () => 1);
  }
  return [
    for (var w = first; !w.isAfter(current); w = weekEnd(w))
      WeekProgress(
        weekStart: w,
        meals: scores[w]?.length ?? 0,
        averageScore: _average(scores[w]),
        wins: wins[w] ?? 0,
      ),
  ];
}

// Average per day with meals, like the weekly summary
NutrientBalance? _balance(
  Iterable<Meal> meals,
  DateTime Function(DateTime) day,
) {
  final list = meals.toList();
  if (list.isEmpty) return null;
  final days = {for (final m in list) day(m.createdAt)}.length;
  int perDay(int Function(Meal) pct) =>
      (list.fold(0, (sum, m) => sum + pct(m)) / days).round();
  return NutrientBalance(
    protein: perDay((m) => m.proteinPct),
    carbs: perDay((m) => m.carbsPct),
    fats: perDay((m) => m.fatsPct),
    vitamins: perDay((m) => m.vitaminsPct),
    minerals: perDay((m) => m.mineralsPct),
    fiber: perDay((m) => m.fiberPct),
  );
}

int? _average(List<int>? values) => values == null || values.isEmpty
    ? null
    : (values.reduce((a, b) => a + b) / values.length).round();
