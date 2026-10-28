import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class ChallengeModel extends ChallengeEntity {
  const ChallengeModel({
    required super.id,
    required super.name,
    required super.code,
    required super.startsAt,
    required super.endsAt,
    required super.isOwner,
    required super.standings,
  });

  factory ChallengeModel.fromProtocol(ChallengeSummary challenge) {
    return ChallengeModel(
      id: challenge.id,
      name: challenge.name,
      code: challenge.code,
      startsAt: challenge.startsAt.toLocal(),
      endsAt: challenge.endsAt.toLocal(),
      isOwner: challenge.isOwner,
      standings: [
        for (final s in challenge.standings)
          ChallengeStandingEntity(
            rank: s.rank,
            petName: s.petName,
            speciesKey: s.speciesKey,
            score: s.score,
            isYou: s.isYou,
          ),
      ],
    );
  }
}
