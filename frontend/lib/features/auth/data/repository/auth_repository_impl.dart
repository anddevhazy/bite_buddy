import 'package:bite_buddy/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:bite_buddy/features/auth/domain/repositories/auth_repository.dart';
import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  bool isSignedIn() => remoteDataSource.isSignedIn();

  @override
  Stream<bool> watchSignedIn() => remoteDataSource.watchSignedIn();

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
