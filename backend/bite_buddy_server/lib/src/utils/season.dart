import 'dart:math';

import '../generated/protocol.dart';
import 'pet_stats.dart';

// Weekly league seasons and how they're scored. Plain functions with no
// database, so the rules are easy to test and tune.

const int feedingWeight = 70; // percent of the season score
const int battleWeight = 30;
const int pointsPerWin = 20; // battle score is capped at 100, so 5 wins max
const int maxCountedWinsPerFriend = 2; // per season, so friends can't farm
const int seasonWinnerCoins = 500;
const int minMembersForWinner = 2;
const int maxLeagueMembers = 20;

// Seasons run Monday 00:00 to the next Monday 00:00, in UTC
DateTime weekStart(DateTime time) {
  final utc = time.toUtc();
  final day = DateTime.utc(utc.year, utc.month, utc.day);
  return day.subtract(Duration(days: day.weekday - DateTime.monday));
}

DateTime weekEnd(DateTime weekStart) => weekStart.add(const Duration(days: 7));

// A member's fed meals and duel wins for one season
class SeasonActivity {
  final int memberId;
  final Pet pet;
  // Meals that were fed this season
  final List<Meal> fedMeals;
  // The user id of the friend beaten in each duel won this season
  final List<String> beatenFriendIds;
  final bool isCaller;

  const SeasonActivity({
    required this.memberId,
    required this.pet,
    required this.fedMeals,
    required this.beatenFriendIds,
    this.isCaller = false,
  });
}

// Feeding score: average meal health score scaled by how many of the 7 days
// the buddy was fed, so eating well every day beats eating a lot
({int average, int days, int score}) feedingScore(
  List<Meal> fedMeals,
  int utcOffsetMinutes,
) {
  if (fedMeals.isEmpty) return (average: 0, days: 0, score: 0);
  final average =
      fedMeals.map((m) => m.healthScore).reduce((a, b) => a + b) /
      fedMeals.length;
  final days = {
    for (final m in fedMeals) localDay(m.createdAt, utcOffsetMinutes),
  }.length;
  final score = (average * min(days, 7) / 7).round();
  return (average: average.round(), days: days, score: score);
}

// Battle score: 20 points a win, at most 2 wins against the same friend
({int wins, int score}) battleScore(List<String> beatenFriendIds) {
  final perFriend = <String, int>{};
  var wins = 0;
  for (final id in beatenFriendIds) {
    final count = (perFriend[id] ?? 0) + 1;
    perFriend[id] = count;
    if (count <= maxCountedWinsPerFriend) wins++;
  }
  return (wins: wins, score: min(100, wins * pointsPerWin));
}

int totalScore(int feeding, int battles) =>
    ((feeding * feedingWeight + battles * battleWeight) / 100).round();

// The season table, best first. Ties go to the better feeding score, then
// the higher level.
List<LeagueStanding> rankSeason(List<SeasonActivity> members) {
  final rows = [
    for (final m in members)
      (
        member: m,
        feeding: feedingScore(m.fedMeals, m.pet.utcOffsetMinutes),
        battles: battleScore(m.beatenFriendIds),
      ),
  ];
  rows.sort((x, y) {
    final total = totalScore(
      y.feeding.score,
      y.battles.score,
    ).compareTo(totalScore(x.feeding.score, x.battles.score));
    if (total != 0) return total;
    final feeding = y.feeding.score.compareTo(x.feeding.score);
    if (feeding != 0) return feeding;
    return y.member.pet.level.compareTo(x.member.pet.level);
  });
  return [
    for (final (i, r) in rows.indexed)
      LeagueStanding(
        rank: i + 1,
        memberId: r.member.memberId,
        petName: r.member.pet.name,
        speciesKey: r.member.pet.speciesKey,
        level: r.member.pet.level,
        averageMealScore: r.feeding.average,
        daysFed: r.feeding.days,
        feedingScore: r.feeding.score,
        wins: r.battles.wins,
        battleScore: r.battles.score,
        totalScore: totalScore(r.feeding.score, r.battles.score),
        isYou: r.member.isCaller,
      ),
  ];
}
