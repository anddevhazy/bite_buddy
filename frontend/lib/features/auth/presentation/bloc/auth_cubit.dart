import 'dart:async';

import 'package:bite_buddy/features/auth/domain/usecases/get_sign_in_status_usecase.dart';
import 'package:bite_buddy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bite_buddy/features/auth/domain/usecases/watch_sign_in_status_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetSignInStatusUseCase getSignInStatusUseCase;
  final WatchSignInStatusUseCase watchSignInStatusUseCase;
  final SignOutUseCase signOutUseCase;

  StreamSubscription<bool>? _subscription;

  AuthCubit({
    required this.getSignInStatusUseCase,
    required this.watchSignInStatusUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  // Called once from the splash screen
  void start() {
    _emitStatus(getSignInStatusUseCase.call());
    _subscription ??= watchSignInStatusUseCase.call().listen(_emitStatus);
  }

  Future<void> signOut() async {
    final result = await signOutUseCase.call();
    result.fold(
      (failure) => emit(AuthFailed(failure: failure)),
      (_) => emit(Unauthenticated()),
    );
  }

  void _emitStatus(bool signedIn) =>
      emit(signedIn ? Authenticated() : Unauthenticated());

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
