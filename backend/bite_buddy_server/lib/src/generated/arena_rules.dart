/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// The numbers the phone uses to run a real-time fight. Sent by the server so
/// the rules live in one place.
abstract class ArenaRules
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ArenaRules._({
    required this.hpMultiplier,
    required this.opponentPower,
    required this.damageScale,
    required this.variance,
    required this.critChance,
    required this.critMultiplier,
    required this.counterMultiplier,
    required this.specialMultiplier,
    required this.blockedMultiplier,
    required this.perfectBlockMs,
    required this.stunMs,
    required this.attackCooldownMs,
    required this.dodgeCooldownMs,
    required this.dodgeMs,
    required this.specialMeterMax,
    required this.meterPerCounter,
    required this.meterPerParry,
    required this.meterPerDodge,
  });

  factory ArenaRules({
    required int hpMultiplier,
    required double opponentPower,
    required double damageScale,
    required double variance,
    required double critChance,
    required double critMultiplier,
    required double counterMultiplier,
    required double specialMultiplier,
    required double blockedMultiplier,
    required int perfectBlockMs,
    required int stunMs,
    required int attackCooldownMs,
    required int dodgeCooldownMs,
    required int dodgeMs,
    required int specialMeterMax,
    required int meterPerCounter,
    required int meterPerParry,
    required int meterPerDodge,
  }) = _ArenaRulesImpl;

  factory ArenaRules.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRules(
      hpMultiplier: jsonSerialization['hpMultiplier'] as int,
      opponentPower: (jsonSerialization['opponentPower'] as num).toDouble(),
      damageScale: (jsonSerialization['damageScale'] as num).toDouble(),
      variance: (jsonSerialization['variance'] as num).toDouble(),
      critChance: (jsonSerialization['critChance'] as num).toDouble(),
      critMultiplier: (jsonSerialization['critMultiplier'] as num).toDouble(),
      counterMultiplier: (jsonSerialization['counterMultiplier'] as num)
          .toDouble(),
      specialMultiplier: (jsonSerialization['specialMultiplier'] as num)
          .toDouble(),
      blockedMultiplier: (jsonSerialization['blockedMultiplier'] as num)
          .toDouble(),
      perfectBlockMs: jsonSerialization['perfectBlockMs'] as int,
      stunMs: jsonSerialization['stunMs'] as int,
      attackCooldownMs: jsonSerialization['attackCooldownMs'] as int,
      dodgeCooldownMs: jsonSerialization['dodgeCooldownMs'] as int,
      dodgeMs: jsonSerialization['dodgeMs'] as int,
      specialMeterMax: jsonSerialization['specialMeterMax'] as int,
      meterPerCounter: jsonSerialization['meterPerCounter'] as int,
      meterPerParry: jsonSerialization['meterPerParry'] as int,
      meterPerDodge: jsonSerialization['meterPerDodge'] as int,
    );
  }

  /// Both fighters' HP is multiplied by this in the arena, so fights last
  /// long enough to play (30-60 seconds) without changing the balance.
  int hpMultiplier;

  /// Opponents' hits are multiplied by this, so every mistake matters.
  double opponentPower;

  double damageScale;

  /// Each hit lands between (1 - variance) and (1 + variance) of normal.
  double variance;

  double critChance;

  double critMultiplier;

  /// Hitting an opponent while it's open after an attack.
  double counterMultiplier;

  double specialMultiplier;

  /// Damage taken through a block.
  double blockedMultiplier;

  /// A block started this soon before a hit is a perfect block (parry).
  int perfectBlockMs;

  /// How long a parried or dodged-heavy opponent is stunned.
  int stunMs;

  int attackCooldownMs;

  int dodgeCooldownMs;

  /// How long a dodge keeps you out of the way.
  int dodgeMs;

  /// Special meter points needed for a Special.
  int specialMeterMax;

  int meterPerCounter;

  int meterPerParry;

  int meterPerDodge;

  /// Returns a shallow copy of this [ArenaRules]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArenaRules copyWith({
    int? hpMultiplier,
    double? opponentPower,
    double? damageScale,
    double? variance,
    double? critChance,
    double? critMultiplier,
    double? counterMultiplier,
    double? specialMultiplier,
    double? blockedMultiplier,
    int? perfectBlockMs,
    int? stunMs,
    int? attackCooldownMs,
    int? dodgeCooldownMs,
    int? dodgeMs,
    int? specialMeterMax,
    int? meterPerCounter,
    int? meterPerParry,
    int? meterPerDodge,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRules',
      'hpMultiplier': hpMultiplier,
      'opponentPower': opponentPower,
      'damageScale': damageScale,
      'variance': variance,
      'critChance': critChance,
      'critMultiplier': critMultiplier,
      'counterMultiplier': counterMultiplier,
      'specialMultiplier': specialMultiplier,
      'blockedMultiplier': blockedMultiplier,
      'perfectBlockMs': perfectBlockMs,
      'stunMs': stunMs,
      'attackCooldownMs': attackCooldownMs,
      'dodgeCooldownMs': dodgeCooldownMs,
      'dodgeMs': dodgeMs,
      'specialMeterMax': specialMeterMax,
      'meterPerCounter': meterPerCounter,
      'meterPerParry': meterPerParry,
      'meterPerDodge': meterPerDodge,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRules',
      'hpMultiplier': hpMultiplier,
      'opponentPower': opponentPower,
      'damageScale': damageScale,
      'variance': variance,
      'critChance': critChance,
      'critMultiplier': critMultiplier,
      'counterMultiplier': counterMultiplier,
      'specialMultiplier': specialMultiplier,
      'blockedMultiplier': blockedMultiplier,
      'perfectBlockMs': perfectBlockMs,
      'stunMs': stunMs,
      'attackCooldownMs': attackCooldownMs,
      'dodgeCooldownMs': dodgeCooldownMs,
      'dodgeMs': dodgeMs,
      'specialMeterMax': specialMeterMax,
      'meterPerCounter': meterPerCounter,
      'meterPerParry': meterPerParry,
      'meterPerDodge': meterPerDodge,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ArenaRulesImpl extends ArenaRules {
  _ArenaRulesImpl({
    required int hpMultiplier,
    required double opponentPower,
    required double damageScale,
    required double variance,
    required double critChance,
    required double critMultiplier,
    required double counterMultiplier,
    required double specialMultiplier,
    required double blockedMultiplier,
    required int perfectBlockMs,
    required int stunMs,
    required int attackCooldownMs,
    required int dodgeCooldownMs,
    required int dodgeMs,
    required int specialMeterMax,
    required int meterPerCounter,
    required int meterPerParry,
    required int meterPerDodge,
  }) : super._(
         hpMultiplier: hpMultiplier,
         opponentPower: opponentPower,
         damageScale: damageScale,
         variance: variance,
         critChance: critChance,
         critMultiplier: critMultiplier,
         counterMultiplier: counterMultiplier,
         specialMultiplier: specialMultiplier,
         blockedMultiplier: blockedMultiplier,
         perfectBlockMs: perfectBlockMs,
         stunMs: stunMs,
         attackCooldownMs: attackCooldownMs,
         dodgeCooldownMs: dodgeCooldownMs,
         dodgeMs: dodgeMs,
         specialMeterMax: specialMeterMax,
         meterPerCounter: meterPerCounter,
         meterPerParry: meterPerParry,
         meterPerDodge: meterPerDodge,
       );

  /// Returns a shallow copy of this [ArenaRules]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArenaRules copyWith({
    int? hpMultiplier,
    double? opponentPower,
    double? damageScale,
    double? variance,
    double? critChance,
    double? critMultiplier,
    double? counterMultiplier,
    double? specialMultiplier,
    double? blockedMultiplier,
    int? perfectBlockMs,
    int? stunMs,
    int? attackCooldownMs,
    int? dodgeCooldownMs,
    int? dodgeMs,
    int? specialMeterMax,
    int? meterPerCounter,
    int? meterPerParry,
    int? meterPerDodge,
  }) {
    return ArenaRules(
      hpMultiplier: hpMultiplier ?? this.hpMultiplier,
      opponentPower: opponentPower ?? this.opponentPower,
      damageScale: damageScale ?? this.damageScale,
      variance: variance ?? this.variance,
      critChance: critChance ?? this.critChance,
      critMultiplier: critMultiplier ?? this.critMultiplier,
      counterMultiplier: counterMultiplier ?? this.counterMultiplier,
      specialMultiplier: specialMultiplier ?? this.specialMultiplier,
      blockedMultiplier: blockedMultiplier ?? this.blockedMultiplier,
      perfectBlockMs: perfectBlockMs ?? this.perfectBlockMs,
      stunMs: stunMs ?? this.stunMs,
      attackCooldownMs: attackCooldownMs ?? this.attackCooldownMs,
      dodgeCooldownMs: dodgeCooldownMs ?? this.dodgeCooldownMs,
      dodgeMs: dodgeMs ?? this.dodgeMs,
      specialMeterMax: specialMeterMax ?? this.specialMeterMax,
      meterPerCounter: meterPerCounter ?? this.meterPerCounter,
      meterPerParry: meterPerParry ?? this.meterPerParry,
      meterPerDodge: meterPerDodge ?? this.meterPerDodge,
    );
  }
}
