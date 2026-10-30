import 'package:equatable/equatable.dart';

// A meal that fills a gap in the pet's week
class MealIdeaEntity extends Equatable {
  final String name;
  // One short sentence on why it helps
  final String reason;
  // The nutrients it boosts, e.g. protein, fiber
  final List<String> boosts;

  const MealIdeaEntity({
    required this.name,
    required this.reason,
    required this.boosts,
  });

  @override
  List<Object?> get props => [name, reason, boosts];
}
