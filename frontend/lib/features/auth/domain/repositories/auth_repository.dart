import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  bool isSignedIn();

  // Emits whenever the user signs in or out (including session expiry)
  Stream<bool> watchSignedIn();

  Future<Either<Failure, void>> signOut();
}
