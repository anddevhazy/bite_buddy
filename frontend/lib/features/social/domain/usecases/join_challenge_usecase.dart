import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class JoinChallengeUseCase {
  final SocialRepository repository;

  JoinChallengeUseCase({required this.repository});

  Future<Either<Failure, ChallengeEntity>> call(String code) =>
      repository.joinChallenge(code);
}
