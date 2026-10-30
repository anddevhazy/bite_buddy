import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.wallet: the player's wallet on Base, for keepsake NFTs
class WalletEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Null until they create one
  Future<WalletView?> mine(Session session) =>
      keepsakeService.wallet(session, session.userId);

  // [showPetPhoto]: whether their own pet's photo may appear on their
  // (public) keepsakes
  Future<WalletView> create(Session session, bool showPetPhoto) =>
      keepsakeService.createWallet(
        session,
        session.userId,
        showPetPhoto: showPetPhoto,
      );

  Future<WalletView> setShowPetPhoto(Session session, bool show) =>
      keepsakeService.setShowPetPhoto(session, session.userId, show);
}
