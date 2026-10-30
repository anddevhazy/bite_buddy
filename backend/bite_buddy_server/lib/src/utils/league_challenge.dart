import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pet_stats.dart';
import 'season.dart';

// Weekly team challenges for leagues. Each week every league gets one, picked
// from the list below in rotation, and the whole league works on it together.

const int challengeRewardCoins = 150; // to every member, when it's met
const int goodMealScore = 70;
const int proteinMealPct = 25;

class _Kind {
  final String key;
  final String title;
  final String Function(int target) description;
  // The target for a league of [members] people (at least 2)
  final int Function(int members) target;
  const _Kind(this.key, this.title, this.description, this.target);
}

final _kinds = <_Kind>[
  _Kind(
    'goodMeals',
    'Eat well together',
    (t) => 'Feed $t meals that score $goodMealScore or more, as a team.',
    (n) => 4 * n,
  ),
  _Kind(
    'daysFed',
    'Every day counts',
    (t) =>
        'Reach $t feeding days between you. Each member feeding on a day '
        'counts once.',
    (n) => 5 * n,
  ),
  _Kind(
    'proteinMeals',
    'Power up',
    (t) => 'Feed $t meals with $proteinMealPct% or more of daily protein.',
    (n) => 3 * n,
  ),
  _Kind(
    'battles',
    'Friendly fights',
    (t) => 'Finish $t friend battles in this league.',
    (n) => n,
  ),
];

// Which challenge a league gets in a given week. Rotates weekly, and leagues
// are staggered so friends in several leagues see different ones.
int challengeIndex(int leagueId, DateTime week) {
  final weekNumber =
      week.millisecondsSinceEpoch ~/ const Duration(days: 7).inMilliseconds;
  return (leagueId + weekNumber) % _kinds.length;
}

// [fedMeals] are the league members' meals fed this season, [finishedDuels]
// the league's battles that finished this season, [offsets] each member's
// UTC offset by user id.
LeagueChallenge weeklyChallenge({
  required int leagueId,
  required DateTime week,
  required int memberCount,
  required List<Meal> fedMeals,
  required int finishedDuels,
  required Map<UuidValue, int> offsets,
}) {
  final kind = _kinds[challengeIndex(leagueId, week)];
  final target = kind.target(
    memberCount < minMembersForWinner ? minMembersForWinner : memberCount,
  );
  final progress = switch (kind.key) {
    'goodMeals' => fedMeals.where((m) => m.healthScore >= goodMealScore).length,
    'daysFed' => {
      for (final m in fedMeals)
        (m.ownerId, localDay(m.createdAt, offsets[m.ownerId] ?? 0)),
    }.length,
    'proteinMeals' =>
      fedMeals.where((m) => m.proteinPct >= proteinMealPct).length,
    _ => finishedDuels,
  };
  return LeagueChallenge(
    key: kind.key,
    title: kind.title,
    description: kind.description(target),
    progress: progress > target ? target : progress,
    target: target,
    completed: progress >= target,
    rewardCoins: challengeRewardCoins,
  );
}
