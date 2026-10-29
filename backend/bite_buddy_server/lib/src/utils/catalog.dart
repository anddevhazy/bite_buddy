import '../generated/protocol.dart';
import 'battle_engine.dart';

// Pets a user can adopt. Add a species here and it shows up in the app.
const List<PetSpeciesData> petSpecies = [
  PetSpeciesData('fluffy', 'Fluffy', 'Dragon Pup', 'common', '🐶'),
  PetSpeciesData('sparkle', 'Sparkle', 'Crystal Fox', 'rare', '🦝'),
  PetSpeciesData('thunder', 'Thunder', 'Storm Wolf', 'epic', '🐯'),
  PetSpeciesData('mystic', 'Mystic', 'Shadow Cat', 'legendary', '🐰'),
];

// Opponents in the battle arena, weakest first. The last number is how often
// their tells are true (percent): tougher opponents bluff more.
const List<OpponentData> opponents = [
  OpponentData('wild_pup', 'Wild Pup', '🐕', 1, 80, 18, 10, 'Easy', 75, 85),
  OpponentData(
    'forest_guardian',
    'Forest Guardian',
    '🦮',
    2,
    120,
    24,
    16,
    'Medium',
    100,
    75,
  ),
  OpponentData(
    'shadow_beast',
    'Shadow Beast',
    '🐈‍⬛',
    3,
    150,
    30,
    22,
    'Medium',
    125,
    70,
  ),
  OpponentData(
    'storm_drake',
    'Storm Drake',
    '🐉',
    5,
    200,
    38,
    30,
    'Hard',
    200,
    65,
  ),
  OpponentData(
    'ancient_golem',
    'Ancient Golem',
    '🗿',
    8,
    280,
    46,
    42,
    'Legendary',
    350,
    60,
  ),
];

PetSpeciesData? findSpecies(String key) {
  for (final s in petSpecies) {
    if (s.key == key) return s;
  }
  return null;
}

OpponentData? findOpponent(String key) {
  for (final o in opponents) {
    if (o.key == key) return o;
  }
  return null;
}

class PetSpeciesData {
  final String key;
  final String name;
  final String title;
  final String rarity;
  final String emoji;

  const PetSpeciesData(
    this.key,
    this.name,
    this.title,
    this.rarity,
    this.emoji,
  );

  PetSpecies toProtocol() => PetSpecies(
    key: key,
    name: name,
    title: title,
    rarity: rarity,
    emoji: emoji,
  );
}

class OpponentData {
  final String key;
  final String name;
  final String emoji;
  final int level;
  final int hp;
  final int attack;
  final int defense;
  final String difficulty;
  final int coinReward;
  final int tellReliability;

  const OpponentData(
    this.key,
    this.name,
    this.emoji,
    this.level,
    this.hp,
    this.attack,
    this.defense,
    this.difficulty,
    this.coinReward,
    this.tellReliability,
  );

  Fighter get fighter => Fighter(maxHp: hp, attack: attack, defense: defense);

  Opponent toProtocol({required int winChance}) => Opponent(
    key: key,
    name: name,
    emoji: emoji,
    level: level,
    hp: hp,
    attack: attack,
    defense: defense,
    difficulty: difficulty,
    coinReward: coinReward,
    tellReliability: tellReliability,
    winChance: winChance,
  );
}
