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

  // How long after scanning a meal can still be fed. Mirrors feedWindow in
  // the server's meal_service.dart, which has the final say.
  static const Duration feedWindow = Duration(hours: 3);

  DateTime get feedableUntil => createdAt.add(feedWindow);

  bool canFeedAt(DateTime now) => !fed && now.isBefore(feedableUntil);

  @override
  List<Object?> get props => [id, fed];
}
