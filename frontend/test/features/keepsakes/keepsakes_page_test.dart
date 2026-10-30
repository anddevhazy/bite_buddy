import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/services/sound_service.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy/features/keepsakes/domain/repositories/keepsake_repository.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/create_wallet_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/fetch_keepsakes_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/mint_keepsake_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/set_show_pet_photo_usecase.dart';
import 'package:bite_buddy/features/keepsakes/presentation/bloc/keepsakes_cubit.dart';
import 'package:bite_buddy/features/keepsakes/presentation/pages/keepsakes_page.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:bite_buddy/features/pet/domain/usecases/adopt_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_my_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_species_usecase.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

KeepsakeEntity certificate({bool minted = false}) => KeepsakeEntity(
  key: 'certificate',
  title: 'Buddy certificate',
  emoji: '📜',
  kind: 'certificate',
  earnedAt: DateTime(2026, 10, 1),
  minted: minted,
  petName: 'Biscuit',
  speciesKey: 'fluffy',
  showPaw: false,
  isTest: true,
  tokenId: minted ? 12 : null,
  edition: minted ? 3 : null,
  stat: 'Adopted 1 Oct 2026',
);

class FakeKeepsakeRepository implements KeepsakeRepository {
  WalletEntity? wallet;
  final List<KeepsakeEntity> keepsakes;

  FakeKeepsakeRepository({this.wallet, List<KeepsakeEntity>? keepsakes})
    : keepsakes = keepsakes ?? [certificate()];

  @override
  Future<Either<Failure, (WalletEntity?, List<KeepsakeEntity>)>>
  fetch() async => Right((wallet, keepsakes));

  @override
  Future<Either<Failure, WalletEntity>> createWallet({
    required bool showPetPhoto,
  }) async {
    wallet = WalletEntity(
      address: '0x${'ab' * 20}',
      isTest: true,
      networkName: 'Test mode',
      showPetPhoto: showPetPhoto,
    );
    return Right(wallet!);
  }

  @override
  Future<Either<Failure, WalletEntity>> setShowPetPhoto(bool show) async =>
      Right(wallet!);

  @override
  Future<Either<Failure, KeepsakeEntity>> mint(String key) async {
    final minted = certificate(minted: true);
    keepsakes
      ..clear()
      ..add(minted);
    return Right(minted);
  }
}

class _MutedSounds extends SoundService {
  _MutedSounds() : super(const FlutterSecureStorage());

  @override
  void play(Sfx sfx, {double volume = 1}) {}
}

class _NoPetRepo implements PetRepository {
  @override
  Future<Either<Failure, PetEntity?>> fetchMyPet() async => const Right(null);

  @override
  Future<Either<Failure, List<PetSpeciesEntity>>> fetchSpecies() async =>
      const Right([]);

  @override
  Future<Either<Failure, PetEntity>> adoptPet(String s, String n) async =>
      const Left(UnexpectedFailure('not in this test'));
}

void registerFakes(FakeKeepsakeRepository repo) {
  sl.registerFactory<KeepsakesCubit>(
    () => KeepsakesCubit(
      fetchKeepsakesUseCase: FetchKeepsakesUseCase(repository: repo),
      createWalletUseCase: CreateWalletUseCase(repository: repo),
      setShowPetPhotoUseCase: SetShowPetPhotoUseCase(repository: repo),
      mintKeepsakeUseCase: MintKeepsakeUseCase(repository: repo),
    ),
  );
}

Widget app() => BlocProvider(
  create: (_) => PetCubit(
    fetchMyPetUseCase: FetchMyPetUseCase(repository: _NoPetRepo()),
    fetchSpeciesUseCase: FetchSpeciesUseCase(repository: _NoPetRepo()),
    adoptPetUseCase: AdoptPetUseCase(repository: _NoPetRepo()),
  ),
  child: const MaterialApp(home: KeepsakesPage()),
);

void main() {
  tearDown(() => sl.reset());

  testWidgets('create a wallet, then mint the certificate', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 1600));
    final repo = FakeKeepsakeRepository();
    registerFakes(repo);
    sl.registerSingleton<SoundService>(_MutedSounds());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.textContaining('Test mode'), findsWidgets);
    expect(find.text('CREATE MY WALLET'), findsOneWidget);
    await tester.tap(find.text('CREATE MY WALLET'));
    await tester.pumpAndSettle();

    expect(find.text('0xabab…abab'), findsOneWidget);
    expect(find.text('Mint'), findsOneWidget);
    await tester.tap(find.text('Mint'));
    await tester.pumpAndSettle();

    expect(find.text('🎉 Minted to your wallet!'), findsOneWidget);
    expect(find.textContaining('Edition #3'), findsOneWidget);
    // Let the success toasts time out
    await tester.pump(const Duration(seconds: 5));
  });
}
