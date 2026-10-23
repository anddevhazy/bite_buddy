import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int calories;
  // Percent of a daily target, 0-100+
  final int proteinPct;
  final int carbsPct;
  final int fatsPct;
  final int vitaminsPct;
  final int mineralsPct;
  final int fiberPct;
  // 0-100, how good this meal is for you overall
  final int healthScore;
  // A-F, from healthScore
  final String grade;
  final bool fed;
  final DateTime createdAt;

  const MealEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.proteinPct,
    required this.carbsPct,
    required this.fatsPct,
    required this.vitaminsPct,
    required this.mineralsPct,
    required this.fiberPct,
    required this.healthScore,
    required this.grade,
    required this.fed,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, fed];
}
