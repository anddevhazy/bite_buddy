import 'dart:math';

import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
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

  // Set by the page once the countdown finishes
  bool running = false;

  ArenaGame({
    required this.engine,
    required this.petImage,
    required this.opponentImage,
    required this.backgroundImage,
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

  @override
  Color backgroundColor() => AppColors.background;

  @override
  Future<void> onLoad() async {
    images.prefix = '';
    final background = await Sprite.load(backgroundImage, images: images);
    add(_Cover(background));

    _glow = _Glow()..priority = 1;
    add(_glow);

    _opponent = _FighterSprite(await Sprite.load(opponentImage, images: images))
      ..priority = 2;
    _pet = _FighterSprite(await Sprite.load(petImage, images: images))
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
      ..size = Vector2.all(opponentSize)
      ..home = Vector2(size.x / 2, size.y * 0.36);
    final petSize = min(size.x * 0.4, size.y * 0.32);
    _pet
      ..size = Vector2.all(petSize)
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
      case WindupStarted(:final combo):
        if (combo) _float('AGAIN!', o + Vector2(0, -20), AppColors.error);
      case FeintRevealed():
        _float('FAKE!', o, AppColors.gold);
      case OpponentStruck(:final result, :final damage, :final critical):
        _opponent.lunge(toward: p);
        switch (result) {
          case StrikeResult.dodged:
            _float('DODGE!', p + Vector2(0, -60), AppColors.primary);
          case StrikeResult.parried:
            _float('PERFECT BLOCK!', p + Vector2(0, -60), AppColors.gold);
            _sparks(p + Vector2(0, -30), AppColors.gold, 22);
            HapticFeedback.mediumImpact();
          case StrikeResult.blocked:
            _float('-$damage', p + Vector2(0, -50), AppColors.textMuted);
            _sparks(p + Vector2(0, -30), AppColors.white, 10);
            HapticFeedback.lightImpact();
          case StrikeResult.guardBroken:
          case StrikeResult.hit:
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
        _float(critical ? 'CRIT $label' : label, o + Vector2(0, -40), color);
        _sparks(
          o,
          kind == PlayerHitKind.special ? AppColors.gold : AppColors.white,
          kind == PlayerHitKind.special ? 40 : (critical ? 22 : 12),
        );
        if (kind == PlayerHitKind.special) _shake(16);
        HapticFeedback.selectionClick();
      case OpponentStunned():
        _sparks(o + Vector2(0, -_opponent.size.y * 0.4), AppColors.gold, 12);
      case DodgeStarted():
        break;
      case FightEnded(:final outcome):
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

// A fighter picture with its own small animations: a gentle bob, lunging at
// the other fighter, flashing when hit, growing during a windup, wobbling
// when stunned, sliding aside on a dodge, and falling over when knocked out
class _FighterSprite extends SpriteComponent {
  Vector2 home = Vector2.zero();
  double grow = 0;
  double wobble = 0;
  double dodgeShift = 0;
  bool faded = false;
  bool knockedOut = false;

  double _time = 0;
  double _lunge = 0;
  Vector2 _lungeTarget = Vector2.zero();
  double _hurt = 0;
  double _shift = 0;

  _FighterSprite(Sprite sprite) : super(sprite: sprite, anchor: Anchor.center);

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

    final bob = knockedOut ? 0 : sin(_time * 2.4) * 5;
    // Out and back: peaks halfway through the lunge
    final lungeAmount = sin(_lunge * pi) * 0.35;
    final lungeOffset = (_lungeTarget - home) * lungeAmount;
    final hurtShake = _hurt > 0 ? sin(_time * 90) * 8 * _hurt : 0;
    position = home + lungeOffset + Vector2(_shift + hurtShake, bob.toDouble());

    scale = Vector2.all(1 + grow);
    angle = knockedOut ? min(angle + dt * 4, pi / 2) : wobble * sin(_time * 18);

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
