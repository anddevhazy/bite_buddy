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

/// The server's verdict on a finished fight, and what it paid out.
abstract class ArenaRunResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ArenaRunResult._({
    required this.won,
    required this.verified,
    required this.coinsEarned,
    required this.xpEarned,
    required this.energyChange,
    required this.leveledUp,
  });

  factory ArenaRunResult({
    required bool won,
    required bool verified,
    required int coinsEarned,
    required int xpEarned,
    required int energyChange,
    required bool leveledUp,
  }) = _ArenaRunResultImpl;

  factory ArenaRunResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRunResult(
      won: _is.BoolJsonExtension.fromJson(jsonSerialization['won']),
      verified: _is.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      coinsEarned: jsonSerialization['coinsEarned'] as int,
      xpEarned: jsonSerialization['xpEarned'] as int,
      energyChange: jsonSerialization['energyChange'] as int,
      leveledUp: _is.BoolJsonExtension.fromJson(jsonSerialization['leveledUp']),
    );
  }

  bool won;

  /// False when a reported win couldn't be verified (counted as a loss).
  bool verified;

  int coinsEarned;

  int xpEarned;

  int energyChange;

  bool leveledUp;

  /// Returns a shallow copy of this [ArenaRunResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArenaRunResult copyWith({
    bool? won,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
    bool? leveledUp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRunResult',
      'won': won,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
      'leveledUp': leveledUp,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRunResult',
      'won': won,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
      'leveledUp': leveledUp,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ArenaRunResultImpl extends ArenaRunResult {
  _ArenaRunResultImpl({
    required bool won,
    required bool verified,
    required int coinsEarned,
    required int xpEarned,
    required int energyChange,
    required bool leveledUp,
  }) : super._(
         won: won,
         verified: verified,
         coinsEarned: coinsEarned,
         xpEarned: xpEarned,
         energyChange: energyChange,
         leveledUp: leveledUp,
       );

  /// Returns a shallow copy of this [ArenaRunResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArenaRunResult copyWith({
    bool? won,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
    bool? leveledUp,
  }) {
    return ArenaRunResult(
      won: won ?? this.won,
      verified: verified ?? this.verified,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      energyChange: energyChange ?? this.energyChange,
      leveledUp: leveledUp ?? this.leveledUp,
    );
  }
}
