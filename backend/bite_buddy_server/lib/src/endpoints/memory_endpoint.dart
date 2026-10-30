import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/keepsake_rules.dart';
import '../utils/session_user.dart';

// client.memory: the memory book, how far the buddy has come
class MemoryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MemoryBook> book(Session session) async {
    final book = await memoryService.book(session, session.userId);
    final minted = await keepsakeService.mintedKeys(session, session.userId);
    return book.copyWith(
      memories: [
        for (final m in book.memories)
          switch (keepsakeKeyFor(m.key)) {
            final key? => m.copyWith(
              keepsake: minted.contains(key) ? 'minted' : 'mintable',
            ),
            null => m,
          },
      ],
    );
  }
}
