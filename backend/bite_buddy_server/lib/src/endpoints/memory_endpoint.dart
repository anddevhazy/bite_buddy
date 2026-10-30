import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.memory: the memory book, how far the buddy has come
class MemoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MemoryBook> book(Session session) =>
      memoryService.book(session, session.userId);
}
