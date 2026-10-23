import 'package:bite_buddy/features/auth/domain/repositories/auth_repository.dart';

class WatchSignInStatusUseCase {
  final AuthRepository repository;

  WatchSignInStatusUseCase({required this.repository});

  Stream<bool> call() => repository.watchSignedIn();
}
