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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// The headline numbers, for "Day 1 vs today".
abstract class ProgressSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProgressSnapshot._({
    required this.level,
    required this.mealsEaten,
    required this.bestStreak,
    required this.wins,
    required this.trophies,
  });

  factory ProgressSnapshot({
    required int level,
    required int mealsEaten,
    required int bestStreak,
    required int wins,
    required int trophies,
  }) = _ProgressSnapshotImpl;

  factory ProgressSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProgressSnapshot(
      level: jsonSerialization['level'] as int,
      mealsEaten: jsonSerialization['mealsEaten'] as int,
      bestStreak: jsonSerialization['bestStreak'] as int,
      wins: jsonSerialization['wins'] as int,
      trophies: jsonSerialization['trophies'] as int,
    );
  }

  int level;

  int mealsEaten;

  int bestStreak;

  int wins;

  int trophies;

  /// Returns a shallow copy of this [ProgressSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProgressSnapshot copyWith({
    int? level,
    int? mealsEaten,
    int? bestStreak,
    int? wins,
    int? trophies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProgressSnapshot',
      'level': level,
      'mealsEaten': mealsEaten,
      'bestStreak': bestStreak,
      'wins': wins,
      'trophies': trophies,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProgressSnapshot',
      'level': level,
      'mealsEaten': mealsEaten,
      'bestStreak': bestStreak,
      'wins': wins,
      'trophies': trophies,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProgressSnapshotImpl extends ProgressSnapshot {
  _ProgressSnapshotImpl({
    required int level,
    required int mealsEaten,
    required int bestStreak,
    required int wins,
    required int trophies,
  }) : super._(
         level: level,
         mealsEaten: mealsEaten,
         bestStreak: bestStreak,
         wins: wins,
         trophies: trophies,
       );

  /// Returns a shallow copy of this [ProgressSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProgressSnapshot copyWith({
    int? level,
    int? mealsEaten,
    int? bestStreak,
    int? wins,
    int? trophies,
  }) {
    return ProgressSnapshot(
      level: level ?? this.level,
      mealsEaten: mealsEaten ?? this.mealsEaten,
      bestStreak: bestStreak ?? this.bestStreak,
      wins: wins ?? this.wins,
      trophies: trophies ?? this.trophies,
    );
  }
}
