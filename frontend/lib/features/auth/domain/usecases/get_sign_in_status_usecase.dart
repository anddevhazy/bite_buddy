import 'package:bite_buddy/features/auth/domain/repositories/auth_repository.dart';

class GetSignInStatusUseCase {
  final AuthRepository repository;

  GetSignInStatusUseCase({required this.repository});

  bool call() => repository.isSignedIn();
}
