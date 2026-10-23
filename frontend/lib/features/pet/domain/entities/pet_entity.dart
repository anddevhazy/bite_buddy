import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final int id;
  final String speciesKey;
  final String name;
  final int level;
  final int xp;
  final int xpToNextLevel;
  final int health;
  final int energy;
  final int nutrition;
  final int coins;
  final int mealsEaten;
  final int wins;
  final int losses;
  final DateTime? lastFedAt;

  const PetEntity({
    required this.id,
    required this.speciesKey,
    required this.name,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.health,
    required this.energy,
    required this.nutrition,
    required this.coins,
    required this.mealsEaten,
    required this.wins,
    required this.losses,
    this.lastFedAt,
  });

  @override
  List<Object?> get props => [
    id,
    speciesKey,
    name,
    level,
    xp,
    xpToNextLevel,
    health,
    energy,
    nutrition,
    coins,
    mealsEaten,
    wins,
    losses,
    lastFedAt,
  ];
}
