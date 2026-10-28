import 'package:equatable/equatable.dart';

class ChallengeStandingEntity extends Equatable {
  final int rank;
  final String petName;
  final String speciesKey;
  // Healthy meals (score 70+) fed during the challenge
  final int score;
  final bool isYou;

  const ChallengeStandingEntity({
    required this.rank,
    required this.petName,
    required this.speciesKey,
    required this.score,
    required this.isYou,
  });

  @override
  List<Object?> get props => [rank, petName, speciesKey, score, isYou];
}

// A group challenge: whoever feeds the most healthy meals before it ends wins
class ChallengeEntity extends Equatable {
  final int id;
  final String name;
  // Friends enter this to join
  final String code;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isOwner;
  final List<ChallengeStandingEntity> standings;

  const ChallengeEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.startsAt,
    required this.endsAt,
    required this.isOwner,
    required this.standings,
  });

  bool get isOver => !endsAt.isAfter(DateTime.now());

  @override
  List<Object?> get props => [
    id,
    name,
    code,
    startsAt,
    endsAt,
    isOwner,
    standings,
  ];
}
