import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/data/data_sources/remote/scanner_remote_data_source.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:dartz/dartz.dart';

class ScannerRepositoryImpl implements ScannerRepository {
  final ScannerRemoteDataSource remoteDataSource;

  ScannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MealEntity>> analyzeMeal(Uint8List jpegBytes) async {
    try {
      return Right(await remoteDataSource.analyzeMeal(jpegBytes));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, FeedResultEntity>> feedPet(int mealId) async {
    try {
      return Right(await remoteDataSource.feedPet(mealId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
