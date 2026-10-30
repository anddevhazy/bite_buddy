import '../generated/protocol.dart';
import 'battle_engine.dart';

// Pets a user can adopt. Add a species here and it shows up in the app.
const List<PetSpeciesData> petSpecies = [
  PetSpeciesData('fluffy', 'Fluffy', 'Dragon Pup', '', '🐶'),
  PetSpeciesData('sparkle', 'Sparkle', 'Crystal Fox', '', '🦝'),
  PetSpeciesData('thunder', 'Thunder', 'Storm Wolf', '', '🐯'),
  PetSpeciesData('mystic', 'Mystic', 'Shadow Cat', '', '🐰'),
];

// Opponents in the battle arena, weakest first. Besides their stats, each has
// a fighting style for the real-time arena: tougher opponents wind up faster,
// throw more heavy (unblockable) attacks and fake more windups.
const List<OpponentData> opponents = [
  OpponentData(
    'wild_pup',
    'Wild Pup',
    '🐕',
    level: 1,
    hp: 80,
    attack: 18,
    defense: 10,
    difficulty: 'Easy',
    coinReward: 75,
    style: FightStyle(
      windupMs: 750,
      recoveryMs: 900,
      attackIntervalMs: 1700,
      heavyChance: 10,
      feintChance: 0,
      comboChance: 10,
      blockChance: 10,
    ),
  ),
  OpponentData(
    'forest_guardian',
    'Forest Guardian',
    '🦮',
    level: 2,
    hp: 120,
    attack: 24,
    defense: 16,
    difficulty: 'Medium',
    coinReward: 100,
    style: FightStyle(
      windupMs: 650,
      recoveryMs: 800,
      attackIntervalMs: 1500,
      heavyChance: 20,
      feintChance: 5,
      comboChance: 20,
      blockChance: 20,
    ),
  ),
  OpponentData(
    'shadow_beast',
    'Shadow Beast',
    '🐈‍⬛',
    level: 3,
    hp: 150,
    attack: 30,
    defense: 22,
    difficulty: 'Medium',
    coinReward: 125,
    style: FightStyle(
      windupMs: 560,
      recoveryMs: 700,
      attackIntervalMs: 1300,
      heavyChance: 25,
      feintChance: 15,
      comboChance: 30,
      blockChance: 30,
    ),
  ),
  OpponentData(
    'storm_drake',
    'Storm Drake',
    '🐉',
    level: 5,
    hp: 200,
    attack: 38,
    defense: 30,
    difficulty: 'Hard',
    coinReward: 200,
    style: FightStyle(
      windupMs: 480,
      recoveryMs: 600,
      attackIntervalMs: 1150,
      heavyChance: 35,
      feintChance: 20,
      comboChance: 40,
      blockChance: 35,
    ),
  ),
  OpponentData(
    'ancient_golem',
    'Ancient Golem',
    '🗿',
    level: 8,
    hp: 280,
    attack: 46,
    defense: 42,
    difficulty: 'Legendary',
    coinReward: 350,
    style: FightStyle(
      windupMs: 420,
      recoveryMs: 550,
      attackIntervalMs: 1050,
      heavyChance: 40,
      feintChance: 30,
      comboChance: 50,
      blockChance: 45,
    ),
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

class FightStyle {
  final int windupMs;
  final int recoveryMs;
  final int attackIntervalMs;
  final int heavyChance;
  final int feintChance;
  final int comboChance;
  final int blockChance;

  const FightStyle({
    required this.windupMs,
    required this.recoveryMs,
    required this.attackIntervalMs,
    required this.heavyChance,
    required this.feintChance,
    required this.comboChance,
    required this.blockChance,
  });
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
  final FightStyle style;

  const OpponentData(
    this.key,
    this.name,
    this.emoji, {
    required this.level,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.difficulty,
    required this.coinReward,
    required this.style,
  });

  Fighter get fighter => Fighter(maxHp: hp, attack: attack, defense: defense);

  Opponent toProtocol() => Opponent(
    key: key,
    name: name,
    emoji: emoji,
    level: level,
    hp: hp,
    attack: attack,
    defense: defense,
    difficulty: difficulty,
    coinReward: coinReward,
    windupMs: style.windupMs,
    recoveryMs: style.recoveryMs,
    attackIntervalMs: style.attackIntervalMs,
    heavyChance: style.heavyChance,
    feintChance: style.feintChance,
    comboChance: style.comboChance,
    blockChance: style.blockChance,
  );
}
