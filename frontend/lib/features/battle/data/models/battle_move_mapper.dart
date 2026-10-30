import 'package:bite_buddy/features/global/enums/battle_move.dart' as app;
import 'package:bite_buddy_client/bite_buddy_client.dart';

// The app keeps its own BattleMove enum so the domain layer doesn't depend on
// the generated client; both enums share the same value names.
class BattleMoveMapper {
  static app.BattleMove toApp(BattleMove move) =>
      app.BattleMove.values.byName(move.name);

  static BattleMove toProtocol(app.BattleMove move) =>
      BattleMove.values.byName(move.name);
}
