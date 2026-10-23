import 'package:equatable/equatable.dart';

class PetSpeciesEntity extends Equatable {
  final String key;
  final String name;
  final String title;
  final String rarity;
  final String emoji;

  const PetSpeciesEntity({
    required this.key,
    required this.name,
    required this.title,
    required this.rarity,
    required this.emoji,
  });

  @override
  List<Object?> get props => [key, name, title, rarity, emoji];
}
