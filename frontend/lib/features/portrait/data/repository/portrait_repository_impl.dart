import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:dartz/dartz.dart';

class PortraitRepositoryImpl implements PortraitRepository {
  final PortraitRemoteDataSource remoteDataSource;

  PortraitRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PortraitDraftEntity>> create(Uint8List photo) async {
    try {
      return Right(await remoteDataSource.create(photo));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, PetEntity>> adopt(int portraitId, String name) async {
    try {
      return Right(await remoteDataSource.adopt(portraitId, name));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
