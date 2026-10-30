import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';

abstract class KeepsakeRemoteDataSource {
  Future<WalletEntity?> fetchWallet();

  Future<List<KeepsakeEntity>> fetchKeepsakes();

  Future<WalletEntity> createWallet({required bool showPetPhoto});

  Future<WalletEntity> setShowPetPhoto(bool show);

  Future<KeepsakeEntity> mint(String key);
}
