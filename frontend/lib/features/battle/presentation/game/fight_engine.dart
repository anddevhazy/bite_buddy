import 'dart:math';

import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:flutter/foundation.dart';

// The rules of a real-time arena fight, with no graphics. The game calls
// [update] every frame and the player's buttons call [attack], [startBlock],
// [endBlock], [dodge] and [special]; everything that happens is announced
// through [events] so the scene can animate it. Times are in milliseconds.
//
// The opponent winds up each attack (the "tell"), then strikes:
//   - a jab can be blocked (a block started at the last moment is a perfect
//     block: no damage, and the opponent is stunned) or dodged
//   - a heavy attack can't be blocked: dodge it, and the opponent is stunned
//   - tougher opponents sometimes fake a windup to bait an early dodge, and
//     follow a jab with a quick second one: dodge has a cooldown, so only a
//     block covers both
// After striking, the opponent is open for a moment: attacks then are
// counters, which hit harder and charge the Special meter.

enum OpponentPhase { idle, windup, recovering, stunned }

enum AttackKind { jab, heavy }

enum FightOutcome { ongoing, won, lost }

sealed class FightEvent {
  const FightEvent();
}

class WindupStarted extends FightEvent {
  final AttackKind kind;
  final int durationMs;
  // The quick second jab of a combo
  final bool combo;
  const WindupStarted(this.kind, this.durationMs, {this.combo = false});
}

class FeintRevealed extends FightEvent {
  const FeintRevealed();
}

enum StrikeResult { hit, blocked, parried, dodged, guardBroken }

class OpponentStruck extends FightEvent {
  final AttackKind kind;
  final StrikeResult result;
  final int damage;
  final bool critical;
  const OpponentStruck(this.kind, this.result, this.damage, this.critical);
}

enum PlayerHitKind { normal, counter, blocked, special }

class PlayerHit extends FightEvent {
  final PlayerHitKind kind;
  final int damage;
  final bool critical;
  const PlayerHit(this.kind, this.damage, this.critical);
}

class OpponentStunned extends FightEvent {
  final int durationMs;
  const OpponentStunned(this.durationMs);
}

class DodgeStarted extends FightEvent {
  const DodgeStarted();
}

class FightEnded extends FightEvent {
  final FightOutcome outcome;
  const FightEnded(this.outcome);
}

class FightEngine extends ChangeNotifier {
  final ArenaRunConfigEntity config;
  final Random _rng;
  final _events = <FightEvent>[];

  // A fight that somehow drags on is decided on remaining HP
  static const int timeLimitMs = 3 * 60 * 1000;
  static const int _feintPauseMs = 500;
  // Longer than a dodge lasts, so one dodge can't cover both jabs
  static const int comboWindupMs = 380;

  late final int petMaxHp;
  late final int opponentMaxHp;
  late int petHp;
  late int opponentHp;

  int timeMs = 0;
  int meter = 0;
  FightOutcome outcome = FightOutcome.ongoing;

  OpponentPhase phase = OpponentPhase.idle;
  AttackKind windupKind = AttackKind.jab;
  bool _windupIsFeint = false;
  bool _windupIsCombo = false;
  int _phaseEndsAt = 0;
  int _nextAttackAt = 0;

  bool blocking = false;
  int _blockStartedAt = 0;
  int _dodgingUntil = 0;
  int _dodgeReadyAt = 0;
  int _attackReadyAt = 0;

  // For the report sent to the server
  int damageDealt = 0;
  int damageTaken = 0;
  int hitsLanded = 0;

  FightEngine(this.config) : _rng = Random(config.seed) {
    final multiplier = config.rules.hpMultiplier;
    petMaxHp = config.petStats.hp * multiplier;
    opponentMaxHp = config.opponent.hp * multiplier;
    petHp = petMaxHp;
    opponentHp = opponentMaxHp;
    // A moment to get ready before the first attack
    _nextAttackAt = 1200;
  }

  ArenaRulesEntity get rules => config.rules;
  bool get isOver => outcome != FightOutcome.ongoing;
  bool get dodging => timeMs < _dodgingUntil;
  bool get canDodge => !isOver && timeMs >= _dodgeReadyAt;
  bool get canAttack => !isOver && !dodging && timeMs >= _attackReadyAt;
  bool get specialReady => !isOver && meter >= rules.specialMeterMax;
  bool get opponentOpen =>
      phase == OpponentPhase.recovering || phase == OpponentPhase.stunned;

  // 0..1 through the current windup, for the scene's glow
  double get windupProgress {
    if (phase != OpponentPhase.windup) return 0;
    final total = _windupDuration(windupKind);
    return (1 - (_phaseEndsAt - timeMs) / total).clamp(0.0, 1.0);
  }

  // Everything that happened since the last call, oldest first
  List<FightEvent> takeEvents() {
    final taken = List<FightEvent>.of(_events);
    _events.clear();
    return taken;
  }

  void update(int dtMs) {
    if (isOver) return;
    timeMs += dtMs;

    switch (phase) {
      case OpponentPhase.idle:
        if (timeMs >= _nextAttackAt) _beginWindup();
      case OpponentPhase.windup:
        if (timeMs >= _phaseEndsAt) {
          _windupIsFeint ? _revealFeint() : _strike();
        }
      case OpponentPhase.recovering:
      case OpponentPhase.stunned:
        if (timeMs >= _phaseEndsAt) _toIdle(_nextInterval());
    }

    if (!isOver && timeMs >= timeLimitMs) {
      _end(
        petHp / petMaxHp >= opponentHp / opponentMaxHp
            ? FightOutcome.won
            : FightOutcome.lost,
      );
    }
    notifyListeners();
  }

  // ── Player actions ────────────────────────────────────────────────────────

  void attack() {
    if (!canAttack) return;
    _attackReadyAt = timeMs + rules.attackCooldownMs;

    final hit = _rollHit(config.petStats.attack, config.opponent.defense);
    final PlayerHitKind kind;
    var damage = hit.damage;
    if (opponentOpen) {
      kind = PlayerHitKind.counter;
      damage = (damage * rules.counterMultiplier).round();
      _addMeter(rules.meterPerCounter);
    } else if (phase == OpponentPhase.idle &&
        _rng.nextInt(100) < config.opponent.blockChance) {
      kind = PlayerHitKind.blocked;
      damage = max(1, (damage * rules.blockedMultiplier).round());
    } else {
      kind = PlayerHitKind.normal;
    }
    _damageOpponent(damage);
    _events.add(PlayerHit(kind, damage, hit.critical));
    _checkEnd();
    notifyListeners();
  }

  void special() {
    if (!specialReady) return;
    meter = 0;
    final hit = _rollHit(config.petStats.attack, config.opponent.defense);
    final damage = (hit.damage * rules.specialMultiplier).round();
    _damageOpponent(damage);
    _events.add(PlayerHit(PlayerHitKind.special, damage, hit.critical));
    if (!_checkEnd()) _stun(rules.stunMs ~/ 2);
    notifyListeners();
  }

  void startBlock() {
    if (isOver || dodging || blocking) return;
    blocking = true;
    _blockStartedAt = timeMs;
    notifyListeners();
  }

  void endBlock() {
    if (!blocking) return;
    blocking = false;
    notifyListeners();
  }

  void dodge() {
    if (!canDodge) return;
    blocking = false;
    _dodgingUntil = timeMs + rules.dodgeMs;
    _dodgeReadyAt = timeMs + rules.dodgeCooldownMs;
    _events.add(const DodgeStarted());
    notifyListeners();
  }

  // Giving up counts as a loss
  void forfeit() {
    if (!isOver) _end(FightOutcome.lost);
    notifyListeners();
  }

  // ── Opponent ──────────────────────────────────────────────────────────────

  void _beginWindup() {
    final o = config.opponent;
    windupKind = _rng.nextInt(100) < o.heavyChance
        ? AttackKind.heavy
        : AttackKind.jab;
    _windupIsFeint = _rng.nextInt(100) < o.feintChance;
    _windupIsCombo = false;
    phase = OpponentPhase.windup;
    final duration = _windupDuration(windupKind);
    _phaseEndsAt = timeMs + duration;
    _events.add(WindupStarted(windupKind, duration));
  }

  // Heavy attacks take longer to wind up, so there's time to see them coming
  int _windupDuration(AttackKind kind) => _windupIsCombo
      ? comboWindupMs
      : kind == AttackKind.heavy
      ? (config.opponent.windupMs * 1.35).round()
      : config.opponent.windupMs;

  // A quick follow-up jab straight after the first
  void _beginCombo() {
    windupKind = AttackKind.jab;
    _windupIsFeint = false;
    _windupIsCombo = true;
    phase = OpponentPhase.windup;
    _phaseEndsAt = timeMs + comboWindupMs;
    _events.add(
      const WindupStarted(AttackKind.jab, comboWindupMs, combo: true),
    );
  }

  void _revealFeint() {
    _events.add(const FeintRevealed());
    _toIdle(_feintPauseMs);
  }

  void _strike() {
    final heavy = windupKind == AttackKind.heavy;
    final hit = _rollHit(config.opponent.attack, config.petStats.defense);
    final power = rules.opponentPower * (heavy ? 1.6 : 1);
    final full = (hit.damage * power).round();

    final StrikeResult result;
    var damage = 0;
    if (dodging) {
      result = StrikeResult.dodged;
      _addMeter(rules.meterPerDodge);
    } else if (blocking && heavy) {
      result = StrikeResult.guardBroken;
      damage = full;
    } else if (blocking && timeMs - _blockStartedAt <= rules.perfectBlockMs) {
      result = StrikeResult.parried;
      _addMeter(rules.meterPerParry);
    } else if (blocking) {
      result = StrikeResult.blocked;
      damage = max(1, (full * rules.blockedMultiplier).round());
    } else {
      result = StrikeResult.hit;
      damage = full;
    }

    petHp = max(0, petHp - damage);
    damageTaken += damage;
    _events.add(
      OpponentStruck(windupKind, result, damage, hit.critical && damage > 0),
    );
    if (_checkEnd()) return;

    // Dodging a heavy attack or parrying a jab leaves the opponent stunned
    if (result == StrikeResult.parried ||
        (result == StrikeResult.dodged && heavy)) {
      _stun(rules.stunMs);
    } else if (!heavy &&
        !_windupIsCombo &&
        _rng.nextInt(100) < config.opponent.comboChance) {
      _beginCombo();
    } else {
      phase = OpponentPhase.recovering;
      _phaseEndsAt = timeMs + config.opponent.recoveryMs;
    }
  }

  void _stun(int durationMs) {
    phase = OpponentPhase.stunned;
    _phaseEndsAt = timeMs + durationMs;
    _events.add(OpponentStunned(durationMs));
  }

  void _toIdle(int untilNextAttackMs) {
    phase = OpponentPhase.idle;
    _nextAttackAt = timeMs + untilNextAttackMs;
  }

  // Varies the rhythm so attacks can't be timed by counting
  int _nextInterval() =>
      (config.opponent.attackIntervalMs * (0.6 + _rng.nextDouble() * 0.6))
          .round();

  // ── Helpers ───────────────────────────────────────────────────────────────

  ({int damage, bool critical}) _rollHit(int attack, int defense) {
    final roll = 1 - rules.variance + _rng.nextDouble() * 2 * rules.variance;
    var damage = max(1, attack * roll - defense * 0.5) * rules.damageScale;
    final critical = _rng.nextDouble() < rules.critChance;
    if (critical) damage *= rules.critMultiplier;
    return (damage: max(1, damage.round()), critical: critical);
  }

  void _damageOpponent(int damage) {
    opponentHp = max(0, opponentHp - damage);
    damageDealt += damage;
    hitsLanded++;
  }

  void _addMeter(int points) =>
      meter = min(rules.specialMeterMax, meter + points);

  bool _checkEnd() {
    if (opponentHp == 0) {
      _end(FightOutcome.won);
    } else if (petHp == 0) {
      _end(FightOutcome.lost);
    }
    return isOver;
  }

  void _end(FightOutcome result) {
    outcome = result;
    blocking = false;
    _events.add(FightEnded(result));
  }

  ArenaRunReportEntity report() => ArenaRunReportEntity(
    won: outcome == FightOutcome.won,
    durationMs: timeMs,
    damageDealt: damageDealt,
    damageTaken: damageTaken,
    hitsLanded: hitsLanded,
  );
}
