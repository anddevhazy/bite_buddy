import 'package:equatable/equatable.dart';

// The player's wallet on Base
class WalletEntity extends Equatable {
  final String address;
  // A stand-in wallet: nothing minted to it is on a real blockchain
  final bool isTest;
  // e.g. "Base" or "Test mode"
  final String networkName;
  // Whether their own pet's photo may appear on their (public) keepsakes
  final bool showPetPhoto;
  final String? explorerUrl;

  const WalletEntity({
    required this.address,
    required this.isTest,
    required this.networkName,
    required this.showPetPhoto,
    this.explorerUrl,
  });

  // 0x1234…abcd
  String get shortAddress =>
      '${address.substring(0, 6)}…${address.substring(address.length - 4)}';

  @override
  List<Object?> get props => [address, isTest, showPetPhoto];
}

// A soulbound NFT for the buddy's certificate or a big milestone, minted or
// ready to mint
class KeepsakeEntity extends Equatable {
  final String key;
  final String title;
  final String emoji;
  // certificate, streak, level, meals or trophy
  final String kind;
  final DateTime earnedAt;
  final bool minted;
  final int? tokenId;
  final int? edition;
  final String? stat;
  final String petName;
  final String speciesKey;
  final int? portraitId;
  // A paw instead of the buddy's picture (own pet, photo not shared)
  final bool showPaw;
  final bool isTest;
  final String? txUrl;
  final String? metadataUrl;
  final String? imageUrl;

  const KeepsakeEntity({
    required this.key,
    required this.title,
    required this.emoji,
    required this.kind,
    required this.earnedAt,
    required this.minted,
    required this.petName,
    required this.speciesKey,
    required this.showPaw,
    required this.isTest,
    this.tokenId,
    this.edition,
    this.stat,
    this.portraitId,
    this.txUrl,
    this.metadataUrl,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [key, minted, tokenId, showPaw];
}
