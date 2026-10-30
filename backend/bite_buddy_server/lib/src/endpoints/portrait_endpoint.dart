import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.portrait: turning a photo of your real pet into your buddy
class PortraitEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Throws BiteBuddyException(PORTRAIT_REJECTED) if there's no animal, or
  // there are people, in the photo
  Future<PortraitDraft> create(Session session, ByteData photo) =>
      portraitService.create(session, session.userId, photo);

  Future<Pet> apply(Session session, int portraitId) =>
      portraitService.apply(session, session.userId, portraitId);

  Future<Pet> clear(Session session) =>
      portraitService.clear(session, session.userId);

  Future<ByteData> image(Session session, int portraitId) =>
      portraitService.image(session, session.userId, portraitId);
}
