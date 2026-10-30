import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/create_wallet_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/fetch_keepsakes_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/mint_keepsake_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/set_show_pet_photo_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'keepsakes_state.dart';

// The wallet and keepsake NFTs on the "My collection" page
class KeepsakesCubit extends Cubit<KeepsakesState> {
  final FetchKeepsakesUseCase fetchKeepsakesUseCase;
  final CreateWalletUseCase createWalletUseCase;
  final SetShowPetPhotoUseCase setShowPetPhotoUseCase;
  final MintKeepsakeUseCase mintKeepsakeUseCase;

  KeepsakesCubit({
    required this.fetchKeepsakesUseCase,
    required this.createWalletUseCase,
    required this.setShowPetPhotoUseCase,
    required this.mintKeepsakeUseCase,
  }) : super(KeepsakesLoading());

  Future<void> load() async {
    if (state is! KeepsakesLoaded) emit(KeepsakesLoading());
    final result = await fetchKeepsakesUseCase.call();
    result.fold((failure) {
      if (state is! KeepsakesLoaded) emit(KeepsakesFailed(failure: failure));
    }, (data) => emit(KeepsakesLoaded(wallet: data.$1, keepsakes: data.$2)));
  }

  // Each action hands back its result so the page can show errors or
  // celebrate
  Future<Either<Failure, WalletEntity>> createWallet({
    required bool showPetPhoto,
  }) async {
    final current = state;
    if (current is KeepsakesLoaded) {
      emit(current.copyWith(creatingWallet: true));
    }
    final result = await createWalletUseCase.call(showPetPhoto: showPetPhoto);
    if (result.isRight()) {
      await load();
    } else if (current is KeepsakesLoaded) {
      emit(current.copyWith());
    }
    return result;
  }

  Future<Either<Failure, WalletEntity>> setShowPetPhoto(bool show) async {
    final result = await setShowPetPhotoUseCase.call(show);
    if (result.isRight()) await load();
    return result;
  }

  Future<Either<Failure, KeepsakeEntity>> mint(String key) async {
    final current = state;
    if (current is! KeepsakesLoaded || current.mintingKey != null) {
      return const Left(UnexpectedFailure('Already minting.'));
    }
    emit(current.copyWith(mintingKey: key));
    final result = await mintKeepsakeUseCase.call(key);
    result.fold(
      (_) => emit(current.copyWith()),
      (minted) => emit(
        current.copyWith(
          keepsakes: [
            for (final k in current.keepsakes) k.key == key ? minted : k,
          ],
        ),
      ),
    );
    return result;
  }
}
