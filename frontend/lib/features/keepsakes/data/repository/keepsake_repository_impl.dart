import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/keepsakes/data/data_sources/remote/keepsake_remote_data_source.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy/features/keepsakes/domain/repositories/keepsake_repository.dart';
import 'package:dartz/dartz.dart';

class KeepsakeRepositoryImpl implements KeepsakeRepository {
  final KeepsakeRemoteDataSource remoteDataSource;

  KeepsakeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, (WalletEntity?, List<KeepsakeEntity>)>> fetch() async {
    try {
      final (wallet, keepsakes) = await (
        remoteDataSource.fetchWallet(),
        remoteDataSource.fetchKeepsakes(),
      ).wait;
      return Right((wallet, keepsakes));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> createWallet({
    required bool showPetPhoto,
  }) async {
    try {
      return Right(
        await remoteDataSource.createWallet(showPetPhoto: showPetPhoto),
      );
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> setShowPetPhoto(bool show) async {
    try {
      return Right(await remoteDataSource.setShowPetPhoto(show));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, KeepsakeEntity>> mint(String key) async {
    try {
      return Right(await remoteDataSource.mint(key));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
