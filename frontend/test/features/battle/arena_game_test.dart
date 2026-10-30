import 'dart:ui' as ui;

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

// Loads the real arena scene with the real art and plays a fight through
// it, drawing every few frames, so every animation path runs at least once:
// full Flow animations, a character missing some (Shadow Beast has no
// stunned or knockout), and a still picture (Fluffy, for now)
void main() {
  for (final (opponent, pet, petAnimated) in [
    ('wild_pup', 'thunder', true),
    ('ancient_golem', 'fluffy', false),
    ('shadow_beast', 'thunder', true),
  ]) {
    testWidgets('the arena animates a whole fight: $opponent vs $pet', (
      tester,
    ) async {
      await _fight(tester, opponent: opponent, pet: pet);
      expect(_lastGame!.opponentAnimated, isTrue);
      expect(_lastGame!.petAnimated, petAnimated);
    });
  }
}

ArenaGame? _lastGame;

Future<void> _fight(
  WidgetTester tester, {
  required String opponent,
  required String pet,
}) async {
  {
    final engine = FightEngine(
      ArenaRunConfigEntity(
        runId: 1,
        petName: 'Hazy',
        petSpeciesKey: pet,
        petStats: const BattleStatsEntity(hp: 115, attack: 27, defense: 21),
        opponent: OpponentEntity(
          key: opponent,
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
      petImage: AppImages.pet(pet),
      opponentImage: AppImages.opponent(opponent),
      backgroundImage: AppImages.arenaBackground,
      opponentAnimations: AppImages.animations('opp_$opponent'),
      petAnimations: AppImages.animations('pet_$pet'),
    );
    _lastGame = game;

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
    void draw() => game.render(ui.Canvas(ui.PictureRecorder()));

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
      if (frames % 5 == 0) draw();
    }
    expect(engine.isOver, isTrue);
    // A few more frames for the knockout animation and floating text
    for (var i = 0; i < 180; i++) {
      game.update(1 / 60);
      if (i % 5 == 0) draw();
    }
    await tester.pump();
  }
}
