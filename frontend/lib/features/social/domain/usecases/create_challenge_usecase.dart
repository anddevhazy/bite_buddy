import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class CreateChallengeUseCase {
  final SocialRepository repository;

  CreateChallengeUseCase({required this.repository});

  Future<Either<Failure, ChallengeEntity>> call(String name, int days) =>
      repository.createChallenge(name, days);
}
