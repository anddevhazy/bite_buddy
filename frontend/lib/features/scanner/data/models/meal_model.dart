import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class MealModel extends MealEntity {
  const MealModel({
    required super.id,
    required super.name,
    required super.description,
    required super.calories,
    required super.proteinPct,
    required super.carbsPct,
    required super.fatsPct,
    required super.vitaminsPct,
    required super.mineralsPct,
    required super.fiberPct,
    required super.healthScore,
    required super.grade,
    required super.fed,
    required super.createdAt,
  });

  factory MealModel.fromProtocol(Meal meal) {
    return MealModel(
      id: meal.id!,
      name: meal.name,
      description: meal.description,
      calories: meal.calories,
      proteinPct: meal.proteinPct,
      carbsPct: meal.carbsPct,
      fatsPct: meal.fatsPct,
      vitaminsPct: meal.vitaminsPct,
      mineralsPct: meal.mineralsPct,
      fiberPct: meal.fiberPct,
      healthScore: meal.healthScore,
      grade: meal.grade,
      fed: meal.fed,
      createdAt: meal.createdAt.toLocal(),
    );
  }
}
