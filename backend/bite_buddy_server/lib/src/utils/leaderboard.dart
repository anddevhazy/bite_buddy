import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pet_stats.dart';

// Ranks pets by nutrition (ties go to the higher level) and returns the top
// [size]. If the caller's pet ranks below that, it's added at the end with its
// real rank, so everyone can see where they stand.
//
// Nutrition is ranked as of [now]: hunger decay is normally only saved when an
// owner opens the app, so without this an inactive player would keep a high
// score forever. The decayed values are only used for ranking, not saved.
List<LeaderboardEntry> rankLeaderboard(
  List<Pet> pets,
  UuidValue callerId,
  DateTime now, {
  required int size,
}) {
  final ranked = [for (final pet in pets) applyDecay(pet, now)]
    ..sort((a, b) {
      final byNutrition = b.nutrition.compareTo(a.nutrition);
      return byNutrition != 0 ? byNutrition : b.level.compareTo(a.level);
    });

  LeaderboardEntry entry(int index) {
    final pet = ranked[index];
    return LeaderboardEntry(
      rank: index + 1,
      petId: pet.id!,
      petName: pet.name,
      speciesKey: pet.speciesKey,
      level: pet.level,
      nutrition: pet.nutrition,
      isYou: pet.ownerId == callerId,
    );
  }

  final top = [for (var i = 0; i < ranked.length && i < size; i++) entry(i)];
  if (top.any((e) => e.isYou)) return top;

  final callerIndex = ranked.indexWhere((p) => p.ownerId == callerId);
  if (callerIndex == -1) return top; // hasn't eaten yet, so isn't ranked
  return [...top, entry(callerIndex)];
}
