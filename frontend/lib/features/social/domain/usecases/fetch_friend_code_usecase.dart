import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class FetchFriendCodeUseCase {
  final SocialRepository repository;

  FetchFriendCodeUseCase({required this.repository});

  Future<Either<Failure, String>> call() =>
      repository.fetchFriendCode();
}
