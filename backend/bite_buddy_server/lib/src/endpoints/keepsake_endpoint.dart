import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.keepsake: soulbound NFTs for the buddy's certificate and milestones
class KeepsakeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Minted keepsakes and the ones that can be minted now, newest first
  Future<List<KeepsakeView>> mine(Session session) =>
      keepsakeService.list(session, session.userId);

  // [key] from a KeepsakeView, e.g. certificate or streak_30
  Future<KeepsakeView> mint(Session session, String key) =>
      keepsakeService.mint(session, session.userId, key);
}
