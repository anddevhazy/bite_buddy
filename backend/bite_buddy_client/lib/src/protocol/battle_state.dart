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
import 'battle.dart' as _inh3lnzs;
import 'opponent.dart' as _i2ot5zrj;

/// A battle plus the details the app needs to draw it.
abstract class BattleState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BattleState._({
    required this.battle,
    required this.opponent,
    required this.petName,
    required this.petSpeciesKey,
  });

  factory BattleState({
    required _inh3lnzs.Battle battle,
    required _i2ot5zrj.Opponent opponent,
    required String petName,
    required String petSpeciesKey,
  }) = _BattleStateImpl;

  factory BattleState.fromJson(Map<String, dynamic> jsonSerialization) {
    return BattleState(
      battle: _i7z1njky.Protocol().deserialize<_inh3lnzs.Battle>(
        jsonSerialization['battle'],
      ),
      opponent: _i7z1njky.Protocol().deserialize<_i2ot5zrj.Opponent>(
        jsonSerialization['opponent'],
      ),
      petName: jsonSerialization['petName'] as String,
      petSpeciesKey: jsonSerialization['petSpeciesKey'] as String,
    );
  }

  _inh3lnzs.Battle battle;

  _i2ot5zrj.Opponent opponent;

  String petName;

  String petSpeciesKey;

  /// Returns a shallow copy of this [BattleState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BattleState copyWith({
    _inh3lnzs.Battle? battle,
    _i2ot5zrj.Opponent? opponent,
    String? petName,
    String? petSpeciesKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BattleState',
      'battle': battle.toJson(),
      'opponent': opponent.toJson(),
      'petName': petName,
      'petSpeciesKey': petSpeciesKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BattleState',
      'battle': battle.toJsonForProtocol(),
      'opponent': opponent.toJsonForProtocol(),
      'petName': petName,
      'petSpeciesKey': petSpeciesKey,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BattleStateImpl extends BattleState {
  _BattleStateImpl({
    required _inh3lnzs.Battle battle,
    required _i2ot5zrj.Opponent opponent,
    required String petName,
    required String petSpeciesKey,
  }) : super._(
         battle: battle,
         opponent: opponent,
         petName: petName,
         petSpeciesKey: petSpeciesKey,
       );

  /// Returns a shallow copy of this [BattleState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BattleState copyWith({
    _inh3lnzs.Battle? battle,
    _i2ot5zrj.Opponent? opponent,
    String? petName,
    String? petSpeciesKey,
  }) {
    return BattleState(
      battle: battle ?? this.battle.copyWith(),
      opponent: opponent ?? this.opponent.copyWith(),
      petName: petName ?? this.petName,
      petSpeciesKey: petSpeciesKey ?? this.petSpeciesKey,
    );
  }
}
