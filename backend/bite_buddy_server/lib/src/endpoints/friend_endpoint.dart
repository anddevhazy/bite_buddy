import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.friend
class FriendEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // The code to give friends so they can add you
  Future<String> myCode(Session session) =>
      friendService.myCode(session, session.userId);

  // Friends and pending requests both ways
  Future<List<Friend>> list(Session session) =>
      friendService.list(session, session.userId);

  // Sends a request, or accepts theirs if they already asked you
  Future<Friend> add(Session session, String friendCode) =>
      friendService.add(session, session.userId, friendCode);

  Future<Friend> accept(Session session, int friendshipId) =>
      friendService.accept(session, session.userId, friendshipId);

  // Unfriend, decline, or cancel a request
  Future<void> remove(Session session, int friendshipId) =>
      friendService.remove(session, session.userId, friendshipId);
}
