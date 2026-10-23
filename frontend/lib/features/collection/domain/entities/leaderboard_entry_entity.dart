import 'package:equatable/equatable.dart';

class LeaderboardEntryEntity extends Equatable {
  final int rank;
  final int petId;
  final String petName;
  final String speciesKey;
  final int level;
  final int nutrition;
  final bool isYou;

  const LeaderboardEntryEntity({
    required this.rank,
    required this.petId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.nutrition,
    required this.isYou,
  });

  @override
  List<Object?> get props => [rank, petId, nutrition, isYou];
}
