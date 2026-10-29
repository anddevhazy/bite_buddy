import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final scannedAt = DateTime(2026, 10, 29, 12);

  MealEntity meal({bool fed = false}) => MealEntity(
    id: 1,
    name: 'Jollof Rice',
    description: '',
    calories: 500,
    proteinPct: 20,
    carbsPct: 40,
    fatsPct: 15,
    vitaminsPct: 20,
    mineralsPct: 20,
    fiberPct: 15,
    healthScore: 70,
    grade: 'B',
    fed: fed,
    createdAt: scannedAt,
  );

  test('an unfed meal can be fed until 3 hours after scanning', () {
    expect(meal().canFeedAt(scannedAt), isTrue);
    expect(
      meal().canFeedAt(scannedAt.add(const Duration(hours: 2, minutes: 59))),
      isTrue,
    );
    expect(meal().canFeedAt(scannedAt.add(const Duration(hours: 3))), isFalse);
  });

  test('a meal that was already fed cannot be fed again', () {
    expect(meal(fed: true).canFeedAt(scannedAt), isFalse);
  });
}
