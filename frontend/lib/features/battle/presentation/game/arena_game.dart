import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:bite_buddy/features/global/services/sound_service.dart';
import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

// Draws a real-time fight: the arena, the opponent facing you, your buddy in
// front, and every hit, block, dodge and stun as it happens. The rules all
// live in [FightEngine]; this only animates what it reports. The HP bars and
// buttons are ordinary Flutter widgets on top (see FightPage).
class ArenaGame extends FlameGame {
  final FightEngine engine;
  final String petImage;
  final String opponentImage;
  final String backgroundImage;
  // Animation sheets made from Flow clips (assets/images/anim/<name>.json).
  // A character without them is drawn from its still picture.
  final String? petAnimations;
  final String? opponentAnimations;
  // The photo of the user's own pet, if their buddy is made from one. It
  // replaces [petImage] and the pet's animations.
  final Future<ui.Image?> Function()? petPortrait;
  // Null in tests
  final SoundService? sounds;

  // Set by the page once the countdown finishes
  bool running = false;

  ArenaGame({
    required this.engine,
    required this.petImage,
    required this.opponentImage,
    required this.backgroundImage,
    this.petAnimations,
    this.opponentAnimations,
    this.petPortrait,
    this.sounds,
  });

  late final _FighterSprite _opponent;
  late final _FighterSprite _pet;
  late final _Glow _glow;
  late final _Label _warning;
  late final _Label _petShield;
  double _msCarry = 0;
  double _shakeFor = 0;
  double _shakeStrength = 0;
  final _rng = Random();

  // Whether each fighter is drawn from Flow animations (for tests)
  @visibleForTesting
  bool get opponentAnimated => _opponent.animated;
  @visibleForTesting
  bool get petAnimated => _pet.animated;

  @override
  Color backgroundColor() => AppColors.background;

  @override
  Future<void> onLoad() async {
    images.prefix = '';
    final background = await Sprite.load(backgroundImage, images: images);
    add(_Cover(background));

    _glow = _Glow()..priority = 1;
    add(_glow);

    _opponent =
        await _FighterSprite.load(
            images,
            picture: opponentImage,
            animations: opponentAnimations,
          )
          ..priority = 2;
    final portrait = await petPortrait?.call();
    _pet =
        (portrait != null
              ? _FighterSprite.still(Sprite(portrait))
              : await _FighterSprite.load(
                  images,
                  picture: petImage,
                  animations: petAnimations,
                ))
          ..priority = 3;
    addAll([_opponent, _pet]);

    _warning = _Label(size: 46)..priority = 4;
    _petShield = _Label(size: 44, text: '🛡️')..priority = 4;
    addAll([_warning, _petShield]);
    _layout(size);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) _layout(size);
  }

  // Opponent in the middle facing you; your buddy smaller, bottom left
  void _layout(Vector2 size) {
    final opponentSize = min(size.x * 0.62, size.y * 0.5);
    _opponent
      ..fitInto(opponentSize)
      ..home = Vector2(size.x / 2, size.y * 0.36);
    final petSize = min(size.x * 0.4, size.y * 0.32);
    _pet
      ..fitInto(petSize)
      ..home = Vector2(size.x * 0.27, size.y * 0.8);
    _glow.radius = opponentSize * 0.5;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (running && !engine.isOver) {
      // The engine works in whole milliseconds; carry the fractions over
      _msCarry += dt * 1000;
      final ms = _msCarry.floor();
      _msCarry -= ms;
      engine.update(ms);
    }
    for (final event in engine.takeEvents()) {
      _show(event);
    }
    _animateStates(dt);
    if (_shakeFor > 0) _shakeFor -= dt;
  }

  @override
  void render(Canvas canvas) {
    if (_shakeFor > 0) {
      canvas.save();
      canvas.translate(
        (_rng.nextDouble() - 0.5) * _shakeStrength,
        (_rng.nextDouble() - 0.5) * _shakeStrength,
      );
      super.render(canvas);
      canvas.restore();
    } else {
      super.render(canvas);
    }
  }

  // Ongoing states: the windup glow, the "!" warning, stuns, blocking, dodging
  void _animateStates(double dt) {
    final o = _opponent.home;
    switch (engine.phase) {
      case OpponentPhase.windup:
        final heavy = engine.windupKind == AttackKind.heavy;
        final p = engine.windupProgress;
        _opponent.grow = 0.15 * p;
        _opponent.wobble = 0;
        _glow
          ..position = o
          ..color = heavy ? const Color(0xFFB04CFF) : AppColors.error
          ..strength = p;
        _warning
          ..text = heavy ? '!!' : '!'
          ..color = heavy ? const Color(0xFFD9A6FF) : AppColors.error
          ..position = Vector2(o.x, o.y - _opponent.size.y * 0.62)
          ..visible = true;
      case OpponentPhase.stunned:
        _opponent.grow = 0;
        _opponent.wobble = 0.08;
        _glow.strength = 0;
        _warning
          ..text = '💫'
          ..color = AppColors.white
          ..position = Vector2(o.x, o.y - _opponent.size.y * 0.6)
          ..visible = true;
      case OpponentPhase.recovering:
        _opponent.grow = 0;
        _opponent.wobble = 0;
        _glow.strength = 0;
        _warning
          ..text = 'OPEN!'
          ..color = AppColors.primary
          ..position = Vector2(o.x, o.y - _opponent.size.y * 0.6)
          ..visible = true;
      case OpponentPhase.idle:
        _opponent.grow = 0;
        _opponent.wobble = 0;
        _glow.strength = 0;
        _warning.visible = false;
    }

    _pet.dodgeShift = engine.dodging ? -_pet.size.x * 0.5 : 0;
    _pet.faded = engine.dodging;
    _petShield
      ..visible = engine.blocking
      ..position = _pet.home + Vector2(_pet.size.x * 0.35, -_pet.size.y * 0.3);
  }

  // One-off moments: hits, blocks, labels, particles, shakes, buzzes
  void _show(FightEvent event) {
    final o = _opponent.home;
    final p = _pet.home;
    switch (event) {
      case WindupStarted(:final combo, :final durationMs):
        _opponent.play(_Pose.windup, overMs: durationMs);
        sounds?.play(Sfx.windup, volume: 0.5);
        if (combo) _float('AGAIN!', o + Vector2(0, -20), AppColors.error);
      case FeintRevealed():
        _opponent.play(_Pose.idle);
        _float('FAKE!', o, AppColors.gold);
      case OpponentStruck(:final result, :final damage, :final critical):
        _opponent.play(_Pose.strike);
        // An animated strike already lunges; a still picture needs the help
        if (!_opponent.animated) _opponent.lunge(toward: p);
        switch (result) {
          case StrikeResult.dodged:
            _float('DODGE!', p + Vector2(0, -60), AppColors.primary);
          case StrikeResult.parried:
            sounds?.play(Sfx.perfectBlock);
            _float('PERFECT BLOCK!', p + Vector2(0, -60), AppColors.gold);
            _sparks(p + Vector2(0, -30), AppColors.gold, 22);
            HapticFeedback.mediumImpact();
          case StrikeResult.blocked:
            sounds?.play(Sfx.block);
            _float('-$damage', p + Vector2(0, -50), AppColors.textMuted);
            _sparks(p + Vector2(0, -30), AppColors.white, 10);
            HapticFeedback.lightImpact();
          case StrikeResult.guardBroken:
          case StrikeResult.hit:
            final big = critical || result == StrikeResult.guardBroken;
            sounds?.play(big ? Sfx.heavyHit : Sfx.hit);
            _pet.hurt();
            _float(
              result == StrikeResult.guardBroken
                  ? 'GUARD BROKEN! -$damage'
                  : critical
                  ? 'CRITICAL! -$damage'
                  : '-$damage',
              p + Vector2(0, -50),
              AppColors.error,
            );
            _sparks(p, AppColors.error, critical ? 26 : 16);
            _shake(critical || result == StrikeResult.guardBroken ? 14 : 7);
            HapticFeedback.heavyImpact();
        }
      case PlayerHit(:final kind, :final damage, :final critical):
        _pet.lunge(toward: o);
        _opponent.hurt();
        final (label, color) = switch (kind) {
          PlayerHitKind.counter => ('COUNTER! -$damage', AppColors.primary),
          PlayerHitKind.special => ('SPECIAL! -$damage', AppColors.gold),
          PlayerHitKind.blocked => ('Blocked -$damage', AppColors.textMuted),
          PlayerHitKind.normal => ('-$damage', AppColors.white),
        };
        sounds?.play(switch (kind) {
          PlayerHitKind.special => Sfx.special,
          PlayerHitKind.blocked => Sfx.block,
          _ => critical ? Sfx.heavyHit : Sfx.hit,
        });
        _float(critical ? 'CRIT $label' : label, o + Vector2(0, -40), color);
        _sparks(
          o,
          kind == PlayerHitKind.special ? AppColors.gold : AppColors.white,
          kind == PlayerHitKind.special ? 40 : (critical ? 22 : 12),
        );
        if (kind == PlayerHitKind.special) _shake(16);
        HapticFeedback.selectionClick();
      case OpponentStunned():
        sounds?.play(Sfx.stun);
        _sparks(o + Vector2(0, -_opponent.size.y * 0.4), AppColors.gold, 12);
      case DodgeStarted():
        sounds?.play(Sfx.dodge);
      case FightEnded(:final outcome):
        sounds?.play(Sfx.knockout);
        (outcome == FightOutcome.won ? _opponent : _pet).knockedOut = true;
        _shake(18);
        HapticFeedback.heavyImpact();
    }
  }

  void _float(String text, Vector2 at, Color color) =>
      add(_FloatingText(text, at.clone(), color)..priority = 5);

  void _sparks(Vector2 at, Color color, int count) {
    add(
      ParticleSystemComponent(
        position: at.clone(),
        priority: 5,
        particle: Particle.generate(
          count: count,
          lifespan: 0.5,
          generator: (_) {
            final angle = _rng.nextDouble() * pi * 2;
            final speed = 120 + _rng.nextDouble() * 220;
            return AcceleratedParticle(
              speed: Vector2(cos(angle), sin(angle)) * speed,
              acceleration: Vector2(0, 400),
              child: CircleParticle(
                radius: 2 + _rng.nextDouble() * 3,
                paint: Paint()..color = color,
              ),
            );
          },
        ),
      ),
    );
  }

  void _shake(double strength) {
    _shakeFor = 0.25;
    _shakeStrength = strength;
  }
}

// The background, scaled to cover the whole game like BoxFit.cover
class _Cover extends SpriteComponent {
  _Cover(Sprite sprite) : super(sprite: sprite);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    final src = sprite!.srcSize;
    final scale = max(size.x / src.x, size.y / src.y);
    this.size = src * scale;
    position = (size - this.size) / 2;
  }
}

enum _Pose { idle, windup, strike }

// A fighter, drawn from its Flow animations when it has them (idle, wind-up,
// strike), or else from its still picture. On top of either it adds small
// effects: a gentle bob, lunging, flashing when hit, growing during a
// windup, wobbling when stunned, sliding aside on a dodge, and falling over
// when knocked out.
class _FighterSprite extends SpriteAnimationGroupComponent<_Pose> {
  Vector2 home = Vector2.zero();
  double grow = 0;
  double wobble = 0;
  double dodgeShift = 0;
  bool faded = false;
  bool knockedOut = false;

  // True when drawn from Flow animations rather than a still picture
  final bool animated;
  // Width / height of a frame
  final double aspect;

  double _time = 0;
  double _lunge = 0;
  Vector2 _lungeTarget = Vector2.zero();
  double _hurt = 0;
  double _shift = 0;

  _FighterSprite._({
    required Map<_Pose, SpriteAnimation> animations,
    required this.animated,
    required this.aspect,
  }) : super(
         animations: animations,
         current: _Pose.idle,
         anchor: Anchor.center,
         autoResize: false,
         size: Vector2.all(1),
       ) {
    // A strike plays once, then it's back to idle
    animationTickers?[_Pose.strike]?.onComplete = () => current = _Pose.idle;
  }

  static Future<_FighterSprite> load(
    Images images, {
    required String picture,
    String? animations,
  }) async {
    if (animations != null) {
      try {
        return await _fromSheets(images, animations);
      } catch (_) {
        // No sheets for this character yet: use the still picture
      }
    }
    return still(await Sprite.load(picture, images: images));
  }

  // One picture for every pose; the movement is all done in code
  static _FighterSprite still(Sprite sprite) {
    final animation = SpriteAnimation.spriteList([sprite], stepTime: 1);
    return _FighterSprite._(
      animations: {for (final pose in _Pose.values) pose: animation},
      animated: false,
      aspect: 1,
    );
  }

  static Future<_FighterSprite> _fromSheets(
    Images images,
    String jsonPath,
  ) async {
    final meta = jsonDecode(await rootBundle.loadString(jsonPath)) as Map;
    final frameSize = Vector2(
      (meta['frameWidth'] as num).toDouble(),
      (meta['frameHeight'] as num).toDouble(),
    );
    final folder = jsonPath.substring(0, jsonPath.lastIndexOf('/') + 1);
    final sheets = meta['animations'] as Map;

    Future<SpriteAnimation> sheet(String name) async {
      final a = sheets[name] as Map;
      return SpriteAnimation.fromFrameData(
        await images.load('$folder${a['file']}'),
        SpriteAnimationData.sequenced(
          amount: a['frames'] as int,
          amountPerRow: a['columns'] as int,
          stepTime: 1 / (a['fps'] as num),
          textureSize: frameSize,
          loop: a['loops'] as bool,
        ),
      );
    }

    final idle = await sheet('idle');
    return _FighterSprite._(
      animations: {
        _Pose.idle: idle,
        // A character may have an idle but not (yet) its attack
        _Pose.windup: sheets.containsKey('windup')
            ? await sheet('windup')
            : idle,
        _Pose.strike: sheets.containsKey('strike')
            ? await sheet('strike')
            : idle,
      },
      animated: true,
      aspect: frameSize.x / frameSize.y,
    );
  }

  // Sizes the fighter to [height], keeping its frames' shape. Animated frames
  // are cropped tight, so they're drawn a bit smaller than a still picture
  // (which has empty space around the character) to look the same size.
  void fitInto(double height) {
    final h = animated ? height * 0.85 : height;
    size = Vector2(h * aspect, h);
  }

  // Switches pose. [overMs] stretches a one-shot animation (the wind-up) to
  // last exactly that long, so it lines up with the attack's real timing.
  void play(_Pose pose, {int? overMs}) {
    final animation = animations?[pose];
    if (overMs != null && animation != null && !animation.loop) {
      final step = overMs / 1000 / animation.frames.length;
      for (final frame in animation.frames) {
        frame.stepTime = step;
      }
    }
    if (current == pose) {
      animationTickers?[pose]?.reset();
    } else {
      current = pose;
    }
  }

  void lunge({required Vector2 toward}) {
    _lunge = 1;
    _lungeTarget = toward;
  }

  void hurt() => _hurt = 1;

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
    _lunge = max(0, _lunge - dt / 0.22);
    _hurt = max(0, _hurt - dt / 0.25);
    // Ease toward the dodge position rather than teleporting
    _shift += (dodgeShift - _shift) * min(1, dt * 18);

    // Animated fighters already move; only still pictures need a bob
    final bob = knockedOut || animated ? 0 : sin(_time * 2.4) * 5;
    // Out and back: peaks halfway through the lunge
    final lungeAmount = sin(_lunge * pi) * 0.35;
    final lungeOffset = (_lungeTarget - home) * lungeAmount;
    final hurtShake = _hurt > 0 ? sin(_time * 90) * 8 * _hurt : 0;
    position = home + lungeOffset + Vector2(_shift + hurtShake, bob.toDouble());

    scale = Vector2.all(1 + grow);
    angle = knockedOut ? min(angle + dt * 4, pi / 2) : wobble * sin(_time * 18);
    // Freeze the animation once knocked out
    playing = !knockedOut;

    final opacity = knockedOut ? 0.55 : (faded ? 0.45 : 1.0);
    paint.color = Color.fromRGBO(255, 255, 255, opacity);
    paint.colorFilter = _hurt > 0
        ? ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, 0.7 * _hurt),
            BlendMode.srcATop,
          )
        : null;
  }
}

// The coloured glow behind the opponent while it winds up: red for a jab
// (block it), purple for a heavy attack (dodge it)
class _Glow extends PositionComponent {
  double radius = 100;
  Color color = AppColors.error;
  double strength = 0;

  _Glow() : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    if (strength <= 0) return;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.75 * strength),
          color.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius));
    canvas.drawCircle(Offset.zero, radius * (0.8 + 0.4 * strength), paint);
  }
}

// A label that can be shown and hidden, like the "!" warning or the shield
class _Label extends PositionComponent {
  final double fontSize;
  String text;
  Color color = AppColors.white;
  bool visible = false;

  _Label({required double size, this.text = ''})
    : fontSize = size,
      super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    if (!visible || text.isEmpty) return;
    TextPaint(
      style: AppTextStyles.h1.copyWith(
        fontSize: fontSize,
        color: color,
        shadows: const [Shadow(blurRadius: 8, color: Color(0xCC000000))],
      ),
    ).render(canvas, text, Vector2.zero(), anchor: Anchor.center);
  }
}

// A number or callout that drifts up and fades away
class _FloatingText extends PositionComponent {
  final String text;
  final Color color;
  double _age = 0;
  static const double _life = 0.9;

  _FloatingText(this.text, Vector2 at, this.color)
    : super(position: at, anchor: Anchor.center);

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;
    position.y -= dt * 70;
    if (_age >= _life) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final fade = (1 - _age / _life).clamp(0.0, 1.0);
    TextPaint(
      style: AppTextStyles.h2.copyWith(
        fontSize: 26,
        color: color.withValues(alpha: fade),
        shadows: [
          Shadow(blurRadius: 6, color: Color.fromRGBO(0, 0, 0, 0.8 * fade)),
        ],
      ),
    ).render(canvas, text, Vector2.zero(), anchor: Anchor.center);
  }
}
