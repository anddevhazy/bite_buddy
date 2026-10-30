import '../generated/protocol.dart';

// Shared streaks between two friends. Plain functions with no database, like
// the season rules, so they're easy to test.

const int maxStreakBuddies = 5; // invites and active streaks together
// Coins each friend gets every time the shared streak grows
const int sharedStreakCoins = 5;

// The two friends may live in different time zones. Expiry uses whichever of
// their days started later, so neither sees the streak end before the other.
DateTime pairToday(DateTime aToday, DateTime bToday) =>
    aToday.isBefore(bToday) ? aToday : bToday;

// The streak as it stands on [today], 0 once a whole day was missed
int liveSharedStreak(StreakBuddy buddy, DateTime today) {
  final last = buddy.lastStreakDay;
  if (buddy.streak == 0 || last == null) return 0;
  return today.difference(last).inDays <= 1 ? buddy.streak : 0;
}

// Records that one friend fed their buddy on their local [day]. The day
// counts for the streak once both friends have fed on it.
({StreakBuddy buddy, bool extended}) recordSharedFeed(
  StreakBuddy buddy, {
  required bool isA,
  required DateTime day,
}) {
  var updated = isA
      ? buddy.copyWith(aLastFedDay: day)
      : buddy.copyWith(bLastFedDay: day);
  final friendDay = isA ? buddy.bLastFedDay : buddy.aLastFedDay;
  final last = buddy.lastStreakDay;
  final alreadyCounted = last != null && !day.isAfter(last);
  if (!buddy.accepted || friendDay != day || alreadyCounted) {
    return (buddy: updated, extended: false);
  }

  final streak = last != null && day.difference(last).inDays == 1
      ? buddy.streak + 1
      : 1;
  updated = updated.copyWith(
    streak: streak,
    bestStreak: streak > buddy.bestStreak ? streak : buddy.bestStreak,
    lastStreakDay: day,
  );
  return (buddy: updated, extended: true);
}
