import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

// All the game-balance numbers live here so they're easy to tune and test.

const int maxStat = 100;
const Duration hungerGrace = Duration(hours: 8);
const int healthDecayPerHour = 2;
const int nutritionDecayPerHour = 1;
const int battleEnergyCost = 10;
const int battleWinEnergy = 8;
const int maxStreakBonusXp = 10;
// Real UTC offsets run from -12:00 to +14:00
const int minUtcOffsetMinutes = -12 * 60;
const int maxUtcOffsetMinutes = 14 * 60;

int clampStat(num v) => v.round().clamp(0, maxStat);

int xpForLevel(int level) => level * 100;

String gradeFor(int healthScore) {
  if (healthScore >= 85) return 'A';
  if (healthScore >= 70) return 'B';
  if (healthScore >= 55) return 'C';
  if (healthScore >= 40) return 'D';
  return 'F';
}

Pet newPet({
  required UuidValue ownerId,
  required String speciesKey,
  required String name,
  required DateTime now,
}) => Pet(
  ownerId: ownerId,
  speciesKey: speciesKey,
  name: name,
  level: 1,
  xp: 0,
  health: maxStat,
  energy: 50,
  nutrition: 0,
  coins: 0,
  mealsEaten: 0,
  wins: 0,
  losses: 0,
  lastFedAt: null,
  streak: 0,
  bestStreak: 0,
  lastStreakDay: null,
  utcOffsetMinutes: 0,
  lastDecayAt: now,
  createdAt: now,
);

// Adds XP and levels up as many times as it covers. Returns the new pet and
// whether it levelled up.
(Pet, bool) addXp(Pet pet, int amount) {
  var level = pet.level;
  var xp = pet.xp + amount;
  var leveledUp = false;
  while (xp >= xpForLevel(level)) {
    xp -= xpForLevel(level);
    level++;
    leveledUp = true;
  }
  return (pet.copyWith(level: level, xp: xp), leveledUp);
}

// A pet that hasn't eaten for [hungerGrace] slowly loses health and nutrition.
// Only whole hours are charged, and lastDecayAt moves forward by exactly those
// hours, so calling this often never loses or double-counts time.
Pet applyDecay(Pet pet, DateTime now) {
  final graceEnd = (pet.lastFedAt ?? pet.createdAt).add(hungerGrace);
  final from = pet.lastDecayAt.isAfter(graceEnd) ? pet.lastDecayAt : graceEnd;
  if (!now.isAfter(from)) return pet;

  final hours = now.difference(from).inHours;
  if (hours < 1) return pet;

  return pet.copyWith(
    health: clampStat(pet.health - hours * healthDecayPerHour),
    nutrition: clampStat(pet.nutrition - hours * nutritionDecayPerHour),
    lastDecayAt: from.add(Duration(hours: hours)),
  );
}

// The owner's calendar day at [now], as UTC midnight so days compare cleanly
DateTime localDay(DateTime now, int utcOffsetMinutes) {
  final local = now.toUtc().add(Duration(minutes: utcOffsetMinutes));
  return DateTime.utc(local.year, local.month, local.day);
}

// A streak survives until the end of the day after its last meal. Once a
// whole day passes with no meal, it drops to 0.
Pet expireStreak(Pet pet, DateTime now) {
  final last = pet.lastStreakDay;
  if (pet.streak == 0 || last == null) return pet;
  final today = localDay(now, pet.utcOffsetMinutes);
  if (today.difference(last).inDays <= 1) return pet;
  return pet.copyWith(streak: 0);
}

FeedResult feed(
  Pet pet,
  Meal meal,
  DateTime now, {
  int utcOffsetMinutes = 0,
}) {
  final offset = utcOffsetMinutes.clamp(
    minUtcOffsetMinutes,
    maxUtcOffsetMinutes,
  );
  final today = localDay(now, offset);
  final last = pet.lastStreakDay;
  final streakExtended = last == null || today.isAfter(last);
  final int streak;
  if (!streakExtended) {
    streak = pet.streak; // already counted today
  } else if (last != null && today.difference(last).inDays == 1) {
    streak = pet.streak + 1;
  } else {
    streak = 1;
  }
  // Only the first meal of the day earns the bonus, so it can't be farmed
  final streakBonusXp = streakExtended ? min(streak, maxStreakBonusXp) : 0;

  final score = meal.healthScore.clamp(0, 100);

  // Nutrition leans on recent meals: one bad meal dents it, a habit sinks it
  final nutrition = pet.mealsEaten == 0
      ? score
      : clampStat(pet.nutrition * 0.7 + score * 0.3);
  // Good meals heal, junk hurts: -10 to +10
  final healing = (score - 50) / 5;
  final health = clampStat(pet.health + healing);
  // Healing past full health becomes XP, so a good meal is never wasted
  final fullHealthBonusXp = max(0, (pet.health + healing).round() - maxStat);
  // Good food is better fuel: 5 energy for the worst meal, 15 for the best.
  // Based on quality, not calories, so eating more never pays off.
  final energy = clampStat(pet.energy + 5 + score / 10);
  final xpGained =
      10 + (score >= 70 ? 5 : 0) + streakBonusXp + fullHealthBonusXp;

  final fed = pet.copyWith(
    nutrition: nutrition,
    health: health,
    energy: energy,
    mealsEaten: pet.mealsEaten + 1,
    streak: streak,
    bestStreak: max(pet.bestStreak, streak),
    lastStreakDay: streakExtended ? today : last,
    utcOffsetMinutes: offset,
    lastFedAt: now,
    lastDecayAt: now,
  );
  final (leveled, leveledUp) = addXp(fed, xpGained);

  return FeedResult(
    pet: leveled,
    healthChange: health - pet.health,
    energyChange: energy - pet.energy,
    nutritionChange: nutrition - pet.nutrition,
    xpGained: xpGained,
    leveledUp: leveledUp,
    streakExtended: streakExtended,
    streakBonusXp: streakBonusXp,
    fullHealthBonusXp: fullHealthBonusXp,
  );
}

// ── Battle stats ────────────────────────────────────────────────────────────

int petMaxHp(Pet pet) => (60 + pet.health * 0.4 + pet.level * 10).round();
int petAttack(Pet pet) => (10 + pet.level * 4 + pet.nutrition / 5).round();
int petDefense(Pet pet) => (6 + pet.level * 3 + pet.health / 10).round();

int baseDamage(int attack, int defense, Random rng) {
  final roll = 0.85 + rng.nextDouble() * 0.3;
  return max(1, (attack * roll - defense * 0.5).round());
}

// Estimates how likely the pet is to win by comparing how many rounds each
// side needs to knock the other out. Clamped so nothing is ever a sure thing.
int winChance({
  required int petHp,
  required int petAtk,
  required int petDef,
  required int oppHp,
  required int oppAtk,
  required int oppDef,
}) {
  final petDmg = max(1, petAtk - oppDef * 0.5);
  final oppDmg = max(1, oppAtk - petDef * 0.5);
  final roundsToWin = oppHp / petDmg;
  final roundsToLose = petHp / oppDmg;
  final r = pow(roundsToLose / roundsToWin, 2);
  return (100 * r / (1 + r)).round().clamp(5, 95);
}
