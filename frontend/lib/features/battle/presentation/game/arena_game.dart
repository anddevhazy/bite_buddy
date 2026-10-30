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
import 'package:flame/sprite.dart';
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

  // Side by side on the same ground, between the HP bars at the top and the
  // buttons at the bottom: your buddy on the left, the opponent (a little
  // bigger) on the right
  void _layout(Vector2 size) {
    final fighterSize = min(size.x * 0.46, size.y * 0.32);
    final opponentSize = fighterSize * 1.1;
    final ground = size.y * 0.65;
    _opponent
      ..fitInto(opponentSize)
      ..home = Vector2(size.x * 0.72, ground - opponentSize / 2);
    _pet
      ..fitInto(fighterSize)
      ..home = Vector2(size.x * 0.27, ground - fighterSize / 2);
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

    // What each fighter holds between moves (the knockout and the victory
    // are set when the fight ends)
    if (!engine.isOver) {
      _opponent.rest = engine.phase == OpponentPhase.stunned
          ? _Pose.stunned
          : _Pose.idle;
      _pet.rest = engine.blocking ? _Pose.block : _Pose.idle;
    }

    // Dodges step back, away from the opponent
    _pet.dodgeShift = engine.dodging ? -_pet.size.x * 0.35 : 0;
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
            _pet
              ..hurt()
              ..play(_Pose.hurt);
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
        // An animated attack already lunges; a still picture needs the help.
        // Quick taps don't restart an attack that's still playing.
        if (!_pet.has(_Pose.attack)) {
          _pet.lunge(toward: o);
        } else if (_pet.current != _Pose.attack || !_pet.busy) {
          _pet.play(_Pose.attack);
        }
        _opponent.hurt();
        // Flinch, but never hide a windup (the tell) or a stun
        if (engine.phase == OpponentPhase.idle ||
            engine.phase == OpponentPhase.recovering) {
          _opponent.play(_Pose.hurt);
        }
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
        _pet.play(_Pose.dodge);
        sounds?.play(Sfx.dodge);
      case FightEnded(:final outcome):
        sounds?.play(Sfx.knockout);
        final (winner, loser) = outcome == FightOutcome.won
            ? (_pet, _opponent)
            : (_opponent, _pet);
        loser
          ..knockedOut = true
          ..rest = _Pose.ko;
        winner.rest = _Pose.victory;
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

// Every move a fighter can have a Flow animation for. Opponents use idle,
// windup, strike, hurt, stunned and ko; pets use idle, attack, block, dodge,
// hurt, victory and ko.
enum _Pose {
  idle,
  windup,
  strike,
  attack,
  block,
  dodge,
  hurt,
  stunned,
  victory,
  ko,
}

// One Flow animation, cropped to its own box: [offset] is where the box's
// top-left corner sits relative to the middle of the idle body, in sheet
// pixels (see design/tools/flow_to_sprites.py)
class _Move {
  final SpriteAnimationTicker ticker;
  final Vector2 frameSize;
  final Vector2 offset;
  final bool loops;

  _Move(SpriteAnimation animation, this.frameSize, this.offset)
    : ticker = animation.createTicker(),
      loops = animation.loop;
}

// A fighter, drawn from its Flow animations when it has them, or else from
// its still picture. A move it has no animation for is done with small
// effects in code instead: lunging, wobbling when stunned, falling over when
// knocked out. On top of either it flashes when hit, grows during a windup
// and slides aside on a dodge.
//
// Its size is the idle body's size, and its position is the body's middle,
// so the HP labels and effects line up whatever move is playing.
class _FighterSprite extends PositionComponent {
  Vector2 home = Vector2.zero();
  double grow = 0;
  double wobble = 0;
  double dodgeShift = 0;
  bool faded = false;
  bool knockedOut = false;

  // True when drawn from Flow animations rather than a still picture
  final bool animated;
  final Map<_Pose, _Move> _moves;
  // The idle body's size in sheet pixels
  final Vector2 _body;
  final Paint _paint = Paint();

  // What it goes back to after a one-off move: idle, or a held pose like
  // blocking or being stunned
  _Pose _rest = _Pose.idle;
  _Pose _current = _Pose.idle;

  double _time = 0;
  double _lunge = 0;
  Vector2 _lungeTarget = Vector2.zero();
  double _hurt = 0;
  double _shift = 0;

  _FighterSprite._(this._moves, this._body, {required this.animated})
    : super(anchor: Anchor.center, size: Vector2.all(1));

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
    final size = sprite.srcSize;
    return _FighterSprite._(
      {
        _Pose.idle: _Move(
          SpriteAnimation.spriteList([sprite], stepTime: 1),
          size,
          -size / 2,
        ),
      },
      size,
      animated: false,
    );
  }

  static Future<_FighterSprite> _fromSheets(
    Images images,
    String jsonPath,
  ) async {
    final meta = jsonDecode(await rootBundle.loadString(jsonPath)) as Map;
    final folder = jsonPath.substring(0, jsonPath.lastIndexOf('/') + 1);
    final moves = <_Pose, _Move>{};
    for (final MapEntry(:key, :value) in (meta['animations'] as Map).entries) {
      final pose = _Pose.values.asNameMap()[key];
      if (pose == null) continue;
      final a = value as Map;
      double n(String k) => (a[k] as num).toDouble();
      final frameSize = Vector2(n('frameWidth'), n('frameHeight'));
      moves[pose] = _Move(
        SpriteAnimation.fromFrameData(
          await images.load('$folder${a['file']}'),
          SpriteAnimationData.sequenced(
            amount: a['frames'] as int,
            amountPerRow: a['columns'] as int,
            stepTime: 1 / n('fps'),
            textureSize: frameSize,
            loop: a['loops'] as bool,
          ),
        ),
        frameSize,
        Vector2(n('offsetX'), n('offsetY')),
      );
    }
    if (!moves.containsKey(_Pose.idle)) throw StateError('No idle animation');
    return _FighterSprite._(
      moves,
      Vector2(
        (meta['bodyWidth'] as num).toDouble(),
        (meta['bodyHeight'] as num).toDouble(),
      ),
      animated: true,
    );
  }

  bool has(_Pose pose) => _moves.containsKey(pose);

  // Whether a one-off move (a strike, a flinch) is still playing
  bool get busy => _current != _rest && !_moves[_current]!.ticker.done();

  _Pose get current => _current;

  // Sizes the fighter so its body is [height] tall. Animated frames are
  // cropped tight, so they're drawn a bit smaller than a still picture
  // (which has empty space around the character) to look the same size.
  void fitInto(double height) {
    final h = animated ? height * 0.85 : height;
    size = _body * (h / _body.y);
  }

  // Plays a one-off move from the start; once it ends, the fighter goes back
  // to its rest pose. Does nothing if there's no animation for it. [overMs]
  // stretches it to last exactly that long (the wind-up, to line up with the
  // attack's real timing).
  void play(_Pose pose, {int? overMs}) {
    final move = _moves[pose];
    if (move == null) return;
    if (overMs != null) {
      final step = overMs / 1000 / move.ticker.spriteAnimation.frames.length;
      for (final frame in move.ticker.spriteAnimation.frames) {
        frame.stepTime = step;
      }
    }
    move.ticker.reset();
    _current = pose;
  }

  // The pose to hold when nothing else is playing. Switches straight away
  // unless a one-off move is still playing.
  set rest(_Pose pose) {
    if (!has(pose)) pose = _Pose.idle;
    if (pose == _rest) return;
    _rest = pose;
    if (!busy || _current == _Pose.windup) {
      _moves[pose]!.ticker.reset();
      _current = pose;
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

    // A knocked-out still picture freezes; an animated knockout plays out
    final fallsInCode = knockedOut && !has(_Pose.ko);
    if (!fallsInCode) {
      final ticker = _moves[_current]!.ticker..update(dt);
      // A one-off move ends: back to resting (the wind-up holds until the
      // strike comes)
      if (ticker.done() && _current != _rest && _current != _Pose.windup) {
        _current = _rest;
        _moves[_rest]!.ticker.reset();
      }
    }

    // Animated fighters already move; only still pictures need a bob
    final bob = knockedOut || animated ? 0 : sin(_time * 2.4) * 5;
    // Out and back: peaks halfway through the lunge
    final lungeAmount = sin(_lunge * pi) * 0.35;
    final lungeOffset = (_lungeTarget - home) * lungeAmount;
    final hurtShake = _hurt > 0 ? sin(_time * 90) * 8 * _hurt : 0;
    position = home + lungeOffset + Vector2(_shift + hurtShake, bob.toDouble());

    scale = Vector2.all(1 + grow);
    angle = fallsInCode
        ? min(angle + dt * 4, pi / 2)
        : (has(_Pose.stunned) ? 0 : wobble * sin(_time * 18));

    final opacity = fallsInCode ? 0.55 : (faded ? 0.45 : 1.0);
    _paint.color = Color.fromRGBO(255, 255, 255, opacity);
    _paint.colorFilter = _hurt > 0
        ? ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, 0.7 * _hurt),
            BlendMode.srcATop,
          )
        : null;
  }

  @override
  void render(Canvas canvas) {
    final move = _moves[_current]!;
    // Sheet pixels to screen: the body fills this component
    final unit = size.y / _body.y;
    move.ticker.getSprite().render(
      canvas,
      position: size / 2 + move.offset * unit,
      size: move.frameSize * unit,
      overridePaint: _paint,
    );
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
