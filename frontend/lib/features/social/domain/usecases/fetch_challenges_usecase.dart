import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class FetchChallengesUseCase {
  final SocialRepository repository;

  FetchChallengesUseCase({required this.repository});

  Future<Either<Failure, List<ChallengeEntity>>> call() =>
      repository.fetchChallenges();
}
