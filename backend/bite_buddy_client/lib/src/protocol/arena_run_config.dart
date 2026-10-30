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
import 'package:bite_buddy_client/src/protocol/protocol.dart' as _i7z1njky;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'arena_rules.dart' as _ildu9ri2;
import 'battle_stats.dart' as _ievndlqk;
import 'opponent.dart' as _i2ot5zrj;

/// Everything the phone needs to start a real-time fight.
abstract class ArenaRunConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArenaRunConfig._({
    required this.runId,
    required this.petName,
    required this.petSpeciesKey,
    this.petPortraitId,
    required this.petStats,
    required this.opponent,
    required this.rules,
    required this.seed,
  });

  factory ArenaRunConfig({
    required int runId,
    required String petName,
    required String petSpeciesKey,
    int? petPortraitId,
    required _ievndlqk.BattleStats petStats,
    required _i2ot5zrj.Opponent opponent,
    required _ildu9ri2.ArenaRules rules,
    required int seed,
  }) = _ArenaRunConfigImpl;

  factory ArenaRunConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRunConfig(
      runId: jsonSerialization['runId'] as int,
      petName: jsonSerialization['petName'] as String,
      petSpeciesKey: jsonSerialization['petSpeciesKey'] as String,
      petPortraitId: jsonSerialization['petPortraitId'] as int?,
      petStats: _i7z1njky.Protocol().deserialize<_ievndlqk.BattleStats>(
        jsonSerialization['petStats'],
      ),
      opponent: _i7z1njky.Protocol().deserialize<_i2ot5zrj.Opponent>(
        jsonSerialization['opponent'],
      ),
      rules: _i7z1njky.Protocol().deserialize<_ildu9ri2.ArenaRules>(
        jsonSerialization['rules'],
      ),
      seed: jsonSerialization['seed'] as int,
    );
  }

  int runId;

  String petName;

  String petSpeciesKey;

  int? petPortraitId;

  _ievndlqk.BattleStats petStats;

  _i2ot5zrj.Opponent opponent;

  _ildu9ri2.ArenaRules rules;

  /// Seeds the phone's random numbers for this fight.
  int seed;

  /// Returns a shallow copy of this [ArenaRunConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArenaRunConfig copyWith({
    int? runId,
    String? petName,
    String? petSpeciesKey,
    int? petPortraitId,
    _ievndlqk.BattleStats? petStats,
    _i2ot5zrj.Opponent? opponent,
    _ildu9ri2.ArenaRules? rules,
    int? seed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRunConfig',
      'runId': runId,
      'petName': petName,
      'petSpeciesKey': petSpeciesKey,
      if (petPortraitId != null) 'petPortraitId': petPortraitId,
      'petStats': petStats.toJson(),
      'opponent': opponent.toJson(),
      'rules': rules.toJson(),
      'seed': seed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRunConfig',
      'runId': runId,
      'petName': petName,
      'petSpeciesKey': petSpeciesKey,
      if (petPortraitId != null) 'petPortraitId': petPortraitId,
      'petStats': petStats.toJsonForProtocol(),
      'opponent': opponent.toJsonForProtocol(),
      'rules': rules.toJsonForProtocol(),
      'seed': seed,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArenaRunConfigImpl extends ArenaRunConfig {
  _ArenaRunConfigImpl({
    required int runId,
    required String petName,
    required String petSpeciesKey,
    int? petPortraitId,
    required _ievndlqk.BattleStats petStats,
    required _i2ot5zrj.Opponent opponent,
    required _ildu9ri2.ArenaRules rules,
    required int seed,
  }) : super._(
         runId: runId,
         petName: petName,
         petSpeciesKey: petSpeciesKey,
         petPortraitId: petPortraitId,
         petStats: petStats,
         opponent: opponent,
         rules: rules,
         seed: seed,
       );

  /// Returns a shallow copy of this [ArenaRunConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArenaRunConfig copyWith({
    int? runId,
    String? petName,
    String? petSpeciesKey,
    Object? petPortraitId = _Undefined,
    _ievndlqk.BattleStats? petStats,
    _i2ot5zrj.Opponent? opponent,
    _ildu9ri2.ArenaRules? rules,
    int? seed,
  }) {
    return ArenaRunConfig(
      runId: runId ?? this.runId,
      petName: petName ?? this.petName,
      petSpeciesKey: petSpeciesKey ?? this.petSpeciesKey,
      petPortraitId: petPortraitId is int? ? petPortraitId : this.petPortraitId,
      petStats: petStats ?? this.petStats.copyWith(),
      opponent: opponent ?? this.opponent.copyWith(),
      rules: rules ?? this.rules.copyWith(),
      seed: seed ?? this.seed,
    );
  }
}
