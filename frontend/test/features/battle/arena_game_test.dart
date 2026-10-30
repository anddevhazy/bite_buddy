import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/presentation/game/arena_game.dart';
import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fight_engine_test.dart' show rules;

// Loads the real arena scene with the real art (an animated opponent and a
// still-picture pet) and plays a fight through it, so every animation path
// runs at least once
void main() {
  testWidgets('the arena scene loads and animates a whole fight', (
    tester,
  ) async {
    final engine = FightEngine(
      const ArenaRunConfigEntity(
        runId: 1,
        petName: 'Hazy',
        petSpeciesKey: 'thunder',
        petStats: BattleStatsEntity(hp: 115, attack: 27, defense: 21),
        opponent: OpponentEntity(
          key: 'wild_pup',
          name: 'Wild Pup',
          emoji: '',
          level: 3,
          hp: 150,
          attack: 30,
          defense: 22,
          difficulty: 'Medium',
          coinReward: 125,
          windupMs: 560,
          recoveryMs: 700,
          attackIntervalMs: 1300,
          heavyChance: 40,
          feintChance: 20,
          comboChance: 40,
          blockChance: 30,
        ),
        rules: rules,
        seed: 3,
      ),
    );
    final game = ArenaGame(
      engine: engine,
      petImage: AppImages.pet('thunder'),
      opponentImage: AppImages.opponent('wild_pup'),
      backgroundImage: AppImages.arenaBackground,
      // Wild Pup has Flow animations; Thunder doesn't yet (still picture)
      opponentAnimations: AppImages.animations('opp_wild_pup'),
      petAnimations: AppImages.animations('pet_thunder'),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GameWidget(game: game)),
        ),
      );
      // Image decoding happens off the test clock
      for (var i = 0; i < 60 && !game.isLoaded; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
        await tester.pump();
      }
    });
    expect(game.isLoaded, isTrue);
    expect(game.opponentAnimated, isTrue);
    expect(game.petAnimated, isFalse);

    game.running = true;
    var frames = 0;
    // Mix every action in, then let the opponent finish us off
    while (!engine.isOver && frames < 20000) {
      frames++;
      if (frames % 40 == 0) engine.attack();
      if (frames % 97 == 0) engine.dodge();
      if (frames % 61 == 0) engine.startBlock();
      if (frames % 61 == 30) engine.endBlock();
      if (engine.specialReady) engine.special();
      game.update(1 / 60);
    }
    expect(engine.isOver, isTrue);
    // A few more frames for the knockout animation and floating text
    for (var i = 0; i < 90; i++) {
      game.update(1 / 60);
    }
    await tester.pump();
  });
}
