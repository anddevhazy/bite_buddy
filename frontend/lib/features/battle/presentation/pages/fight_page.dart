import 'dart:async';

import 'package:bite_buddy/service_locator.dart';
import 'package:bite_buddy/features/global/services/sound_service.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/battle/presentation/game/arena_game.dart';
import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum _Stage { intro, countdown, fighting, reporting, result, reportFailed }

// A real-time fight against a computer opponent. The fight runs here on the
// phone; when it ends the result goes to the server, which checks it and
// pays out.
class FightPage extends StatefulWidget {
  final ArenaRunConfigEntity config;

  const FightPage({super.key, required this.config});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  late final FightEngine _engine = FightEngine(widget.config);
  late final ArenaGame _game = ArenaGame(
    engine: _engine,
    petImage: AppImages.pet(widget.config.petSpeciesKey),
    opponentImage: AppImages.opponent(widget.config.opponent.key),
    backgroundImage: AppImages.arenaBackground,
    sounds: _sounds,
  );
  final SoundService _sounds = sl<SoundService>();

  _Stage _stage = _Stage.intro;
  int _countdown = 3;
  Timer? _timer;
  ArenaRunResultEntity? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _engine.addListener(_onEngineChanged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _engine.removeListener(_onEngineChanged);
    _engine.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _stage = _Stage.countdown;
      _countdown = 3;
    });
    _sounds.play(Sfx.countdown);
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (!mounted) return timer.cancel();
      if (_countdown > 1) {
        setState(() => _countdown--);
        _sounds.play(Sfx.countdown);
      } else {
        timer.cancel();
        _sounds.play(Sfx.fight);
        setState(() => _stage = _Stage.fighting);
        _game.running = true;
      }
    });
  }

  void _onEngineChanged() {
    if (_engine.isOver && _stage == _Stage.fighting) {
      _game.running = false;
      // Let the knockout land on screen before the results cover it
      Future.delayed(const Duration(milliseconds: 1200), _report);
      setState(() => _stage = _Stage.reporting);
    }
  }

  Future<void> _report() async {
    if (!mounted) return;
    setState(() {
      _stage = _Stage.reporting;
      _error = null;
    });
    final result = await context.read<BattleCubit>().finish(
      widget.config.runId,
      _engine.report(),
    );
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _stage = _Stage.reportFailed;
        _error = failure.message;
      }),
      (r) {
        // Coins, XP and energy changed on the server
        context.read<PetCubit>().loadPet(silent: true);
        context.read<BattleCubit>().loadOpponents();
        _sounds.play(r.won ? Sfx.victory : Sfx.defeat);
        setState(() {
          _stage = _Stage.result;
          _result = r;
        });
      },
    );
  }

  // Leaving before the end counts as a loss (the fight is already open on
  // the server), so ask first
  Future<void> _confirmQuit() async {
    const leavable = {_Stage.intro, _Stage.countdown, _Stage.fighting};
    if (!leavable.contains(_stage)) return;
    final quit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('Give up?', style: AppTextStyles.h2),
        content: Text(
          'Leaving now counts as a loss and costs energy.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep fighting'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('Give up', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (quit != true || !mounted) return;
    _timer?.cancel();
    // Forfeiting ends the fight; _onEngineChanged then reports the loss
    _stage = _Stage.fighting;
    _engine.forfeit();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _stage == _Stage.result,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmQuit();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned.fill(child: GameWidget(game: _game)),
            SafeArea(
              child: ListenableBuilder(
                listenable: _engine,
                builder: (context, _) => Column(
                  children: [
                    _TopHud(
                      config: widget.config,
                      engine: _engine,
                      onQuit: _confirmQuit,
                    ),
                    const Spacer(),
                    _BottomHud(config: widget.config, engine: _engine),
                    _Controls(
                      engine: _engine,
                      enabled: _stage == _Stage.fighting,
                    ),
                  ],
                ),
              ),
            ),
            if (_stage == _Stage.intro)
              _Overlay(
                child: _Intro(config: widget.config, onStart: _startCountdown),
              ),
            if (_stage == _Stage.countdown)
              Center(
                child: Text(
                  '$_countdown',
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 120,
                    shadows: const [
                      Shadow(blurRadius: 16, color: Colors.black),
                    ],
                  ),
                ),
              ),
            if (_stage == _Stage.reporting && _engine.isOver)
              const _Overlay(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                  ],
                ),
              ),
            if (_stage == _Stage.result && _result != null)
              _Overlay(
                child: _ResultCard(
                  config: widget.config,
                  result: _result!,
                  onDone: () => context.pop(),
                ),
              ),
            if (_stage == _Stage.reportFailed)
              _Overlay(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Couldn't save the result", style: AppTextStyles.h2),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _error ?? '',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    GameButton(label: 'Try again', onPressed: _report),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopHud extends StatelessWidget {
  final ArenaRunConfigEntity config;
  final FightEngine engine;
  final VoidCallback onQuit;

  const _TopHud({
    required this.config,
    required this.engine,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: Colors.black45),
            onPressed: onQuit,
            icon: const Icon(Icons.close_rounded, color: AppColors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _HpBar(
              label: config.opponent.name,
              hp: engine.opponentHp,
              maxHp: engine.opponentMaxHp,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomHud extends StatelessWidget {
  final ArenaRunConfigEntity config;
  final FightEngine engine;

  const _BottomHud({required this.config, required this.engine});

  @override
  Widget build(BuildContext context) {
    final max = config.rules.specialMeterMax;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          _HpBar(
            label: config.petName,
            hp: engine.petHp,
            maxHp: engine.petMaxHp,
            color: AppColors.health,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text('✨', style: AppTextStyles.bodyMedium),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: engine.meter / max,
                    minHeight: 8,
                    backgroundColor: Colors.black45,
                    valueColor: AlwaysStoppedAnimation(
                      engine.specialReady ? AppColors.gold : AppColors.accent,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                engine.specialReady ? 'SPECIAL READY' : 'Special',
                style: AppTextStyles.caption.copyWith(
                  color: engine.specialReady ? AppColors.gold : AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HpBar extends StatelessWidget {
  final String label;
  final int hp;
  final int maxHp;
  final Color color;

  const _HpBar({
    required this.label,
    required this.hp,
    required this.maxHp,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('$hp/$maxHp', style: AppTextStyles.caption),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: maxHp == 0 ? 0 : hp / maxHp),
              duration: const Duration(milliseconds: 250),
              builder: (context, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 10,
                backgroundColor: AppColors.track,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dodge and Block on the left thumb, Attack and Special on the right
class _Controls extends StatelessWidget {
  final FightEngine engine;
  final bool enabled;

  const _Controls({required this.engine, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          _ActionButton(
            emoji: '💨',
            label: 'Dodge',
            color: const Color(0xFFB04CFF),
            enabled: enabled && engine.canDodge,
            onDown: engine.dodge,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ActionButton(
            emoji: '🛡️',
            label: 'Block',
            hint: 'hold',
            color: AppColors.nutrition,
            enabled: enabled,
            active: engine.blocking,
            onDown: engine.startBlock,
            onUp: engine.endBlock,
          ),
          const Spacer(),
          _ActionButton(
            emoji: '✨',
            label: 'Special',
            color: AppColors.gold,
            enabled: enabled && engine.specialReady,
            onDown: engine.special,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ActionButton(
            emoji: '⚔️',
            label: 'Attack',
            color: AppColors.accent,
            big: true,
            enabled: enabled && engine.canAttack,
            onDown: engine.attack,
          ),
        ],
      ),
    );
  }
}

// Reacts on touch-down rather than release: in a reflex game every
// millisecond counts. Block also reacts to release.
class _ActionButton extends StatelessWidget {
  final String emoji;
  final String label;
  final String? hint;
  final Color color;
  final bool enabled;
  final bool active;
  final bool big;
  final VoidCallback onDown;
  final VoidCallback? onUp;

  const _ActionButton({
    required this.emoji,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onDown,
    this.hint,
    this.onUp,
    this.active = false,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = big ? 86.0 : 70.0;
    return Listener(
      onPointerDown: enabled ? (_) => onDown() : null,
      onPointerUp: onUp == null ? null : (_) => onUp!(),
      onPointerCancel: onUp == null ? null : (_) => onUp!(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: enabled || active ? 1 : 0.4,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? color : color.withValues(alpha: 0.35),
            border: Border.all(color: color, width: 3),
            boxShadow: active
                ? [BoxShadow(color: color, blurRadius: 16)]
                : const [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: big ? 30 : 24)),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (hint != null)
                Text(
                  hint!,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Overlay extends StatelessWidget {
  final Widget child;

  const _Overlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.72),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(AppSpacing.lg),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// The rules in four lines, shown before every fight
class _Intro extends StatelessWidget {
  final ArenaRunConfigEntity config;
  final VoidCallback onStart;

  const _Intro({required this.config, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final o = config.opponent;
    const tips = [
      (
        '🔴',
        'Red glow: a jab. Hold BLOCK. Block just before it lands for '
            'a perfect block that stuns them.',
      ),
      ('🟣', "Purple glow: a heavy attack. You can't block it: DODGE!"),
      ('🟢', "When it says OPEN!, ATTACK: counters hit harder."),
      ('✨', 'Dodges, perfect blocks and counters fill your SPECIAL.'),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('vs ${o.name}', style: AppTextStyles.h1),
        Text(
          '${o.difficulty} · reacts in ${o.reactionTime} · ${o.fakes}',
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final (emoji, tip) in tips)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(tip, style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
        if (o.feintChance > 0)
          Text(
            "Watch out: ${o.name} sometimes fakes a windup. Don't move too "
            'early!',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(color: AppColors.gold),
          ),
        const SizedBox(height: AppSpacing.lg),
        GameButton(
          label: 'Fight!',
          style: GameButtonStyle.battle,
          onPressed: onStart,
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  final ArenaRunConfigEntity config;
  final ArenaRunResultEntity result;
  final VoidCallback onDone;

  const _ResultCard({
    required this.config,
    required this.result,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final won = result.won;
    final energy = result.energyChange;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(won ? '🏆' : '💫', style: const TextStyle(fontSize: 64)),
        Text(won ? 'Victory!' : 'Defeat', style: AppTextStyles.h1),
        const SizedBox(height: AppSpacing.sm),
        Text(
          !result.verified
              ? "We couldn't verify that win, so it counts as a loss."
              : won
              ? '${config.petName} beat ${config.opponent.name}!'
              : '${config.opponent.name} was too strong this time.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '💰 +${result.coinsEarned}   ⭐ +${result.xpEarned} XP   '
          '⚡ ${energy >= 0 ? '+' : ''}$energy',
          textAlign: TextAlign.center,
          style: AppTextStyles.h3,
        ),
        if (result.leveledUp) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '🎉 Level up!',
            style: AppTextStyles.h3.copyWith(color: AppColors.gold),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        GameButton(
          label: 'Back to arena',
          style: won ? GameButtonStyle.battle : GameButtonStyle.accent,
          onPressed: onDone,
        ),
      ],
    );
  }
}
