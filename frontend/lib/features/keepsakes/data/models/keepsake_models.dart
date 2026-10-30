import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Converts the generated server models into this feature's entities
class KeepsakeModels {
  static WalletEntity wallet(WalletView w) => WalletEntity(
    address: w.address,
    isTest: w.isTest,
    networkName: w.networkName,
    showPetPhoto: w.showPetPhoto,
    explorerUrl: w.explorerUrl,
  );

  static KeepsakeEntity keepsake(KeepsakeView k) => KeepsakeEntity(
    key: k.key,
    title: k.title,
    emoji: k.emoji,
    kind: k.kind,
    earnedAt: k.earnedAt.toLocal(),
    minted: k.minted,
    tokenId: k.tokenId,
    edition: k.edition,
    stat: k.stat,
    petName: k.petName,
    speciesKey: k.speciesKey,
    portraitId: k.portraitId,
    showPaw: k.showPaw,
    isTest: k.isTest ?? true,
    txUrl: k.txUrl,
    metadataUrl: k.metadataUrl,
    imageUrl: k.imageUrl,
  );
}
