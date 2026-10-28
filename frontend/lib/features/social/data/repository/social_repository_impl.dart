import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/data/data_sources/remote/social_remote_data_source.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class SocialRepositoryImpl implements SocialRepository {
  final SocialRemoteDataSource remoteDataSource;

  SocialRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> fetchFriendCode() async {
    try {
      return Right(await remoteDataSource.fetchFriendCode());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<FriendEntity>>> fetchFriends() async {
    try {
      return Right(await remoteDataSource.fetchFriends());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, FriendEntity>> addFriend(String friendCode) async {
    try {
      return Right(await remoteDataSource.addFriend(friendCode));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, FriendEntity>> acceptFriend(int friendshipId) async {
    try {
      return Right(await remoteDataSource.acceptFriend(friendshipId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFriend(int friendshipId) async {
    try {
      await remoteDataSource.removeFriend(friendshipId);
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ChallengeEntity>>> fetchChallenges() async {
    try {
      return Right(await remoteDataSource.fetchChallenges());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ChallengeEntity>> createChallenge(String name, int days) async {
    try {
      return Right(await remoteDataSource.createChallenge(name, days));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ChallengeEntity>> joinChallenge(String code) async {
    try {
      return Right(await remoteDataSource.joinChallenge(code));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> leaveChallenge(int challengeId) async {
    try {
      await remoteDataSource.leaveChallenge(challengeId);
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
