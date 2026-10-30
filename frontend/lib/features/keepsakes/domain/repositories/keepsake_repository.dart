import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:dartz/dartz.dart';

abstract class KeepsakeRepository {
  // The wallet (null if none yet) and the keepsakes, newest first
  Future<Either<Failure, (WalletEntity?, List<KeepsakeEntity>)>> fetch();

  Future<Either<Failure, WalletEntity>> createWallet({
    required bool showPetPhoto,
  });

  Future<Either<Failure, WalletEntity>> setShowPetPhoto(bool show);

  Future<Either<Failure, KeepsakeEntity>> mint(String key);
}
