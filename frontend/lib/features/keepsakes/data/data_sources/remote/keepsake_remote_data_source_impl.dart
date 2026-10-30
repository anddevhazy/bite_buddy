import 'package:bite_buddy/features/keepsakes/data/data_sources/remote/keepsake_remote_data_source.dart';
import 'package:bite_buddy/features/keepsakes/data/models/keepsake_models.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Wallets are made by the server for now (test mode). With a wallet
// provider like Privy, createWallet would make the wallet on the phone with
// its SDK and send the address to the server to check and save.
class KeepsakeRemoteDataSourceImpl implements KeepsakeRemoteDataSource {
  final Client client;

  KeepsakeRemoteDataSourceImpl({required this.client});

  @override
  Future<WalletEntity?> fetchWallet() async =>
      switch (await client.wallet.mine()) {
        final w? => KeepsakeModels.wallet(w),
        null => null,
      };

  @override
  Future<List<KeepsakeEntity>> fetchKeepsakes() async =>
      (await client.keepsake.mine()).map(KeepsakeModels.keepsake).toList();

  @override
  Future<WalletEntity> createWallet({required bool showPetPhoto}) async =>
      KeepsakeModels.wallet(await client.wallet.create(showPetPhoto));

  @override
  Future<WalletEntity> setShowPetPhoto(bool show) async =>
      KeepsakeModels.wallet(await client.wallet.setShowPetPhoto(show));

  @override
  Future<KeepsakeEntity> mint(String key) async =>
      KeepsakeModels.keepsake(await client.keepsake.mint(key));
}
