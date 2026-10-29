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
import 'package:bite_buddy_server/src/generated/protocol.dart' as _i61ow1lb;
import 'package:serverpod/serverpod.dart' as _is;
import 'battle_stats.dart' as _ievndlqk;
import 'opponent.dart' as _i2ot5zrj;

/// The Battle Arena screen: the caller's pet's battle stats and the opponents.
abstract class Arena
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Arena._({
    required this.petStats,
    required this.opponents,
  });

  factory Arena({
    required _ievndlqk.BattleStats petStats,
    required List<_i2ot5zrj.Opponent> opponents,
  }) = _ArenaImpl;

  factory Arena.fromJson(Map<String, dynamic> jsonSerialization) {
    return Arena(
      petStats: _i61ow1lb.Protocol().deserialize<_ievndlqk.BattleStats>(
        jsonSerialization['petStats'],
      ),
      opponents: _i61ow1lb.Protocol().deserialize<List<_i2ot5zrj.Opponent>>(
        jsonSerialization['opponents'],
      ),
    );
  }

  _ievndlqk.BattleStats petStats;

  List<_i2ot5zrj.Opponent> opponents;

  /// Returns a shallow copy of this [Arena]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Arena copyWith({
    _ievndlqk.BattleStats? petStats,
    List<_i2ot5zrj.Opponent>? opponents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Arena',
      'petStats': petStats.toJson(),
      'opponents': opponents.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Arena',
      'petStats': petStats.toJsonForProtocol(),
      'opponents': opponents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ArenaImpl extends Arena {
  _ArenaImpl({
    required _ievndlqk.BattleStats petStats,
    required List<_i2ot5zrj.Opponent> opponents,
  }) : super._(
         petStats: petStats,
         opponents: opponents,
       );

  /// Returns a shallow copy of this [Arena]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Arena copyWith({
    _ievndlqk.BattleStats? petStats,
    List<_i2ot5zrj.Opponent>? opponents,
  }) {
    return Arena(
      petStats: petStats ?? this.petStats.copyWith(),
      opponents:
          opponents ?? this.opponents.map((e0) => e0.copyWith()).toList(),
    );
  }
}
