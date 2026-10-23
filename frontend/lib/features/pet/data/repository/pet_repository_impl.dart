import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/data/data_sources/remote/pet_remote_data_source.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';

class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource remoteDataSource;

  PetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PetSpeciesEntity>>> fetchSpecies() async {
    try {
      return Right(await remoteDataSource.fetchSpecies());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, PetEntity?>> fetchMyPet() async {
    try {
      return Right(await remoteDataSource.fetchMyPet());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, PetEntity>> adoptPet(
    String speciesKey,
    String name,
  ) async {
    try {
      return Right(await remoteDataSource.adoptPet(speciesKey, name));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
