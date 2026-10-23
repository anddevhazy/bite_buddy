import 'package:bite_buddy/features/auth/domain/repositories/auth_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<Either<Failure, void>> call() => repository.signOut();
}
