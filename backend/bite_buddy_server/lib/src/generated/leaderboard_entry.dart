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

/// One row of the nutrition leaderboard. Leaves out the owner's id on purpose.
abstract class LeaderboardEntry
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LeaderboardEntry._({
    required this.rank,
    required this.petId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.nutrition,
    required this.isYou,
  });

  factory LeaderboardEntry({
    required int rank,
    required int petId,
    required String petName,
    required String speciesKey,
    required int level,
    required int nutrition,
    required bool isYou,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      rank: jsonSerialization['rank'] as int,
      petId: jsonSerialization['petId'] as int,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      level: jsonSerialization['level'] as int,
      nutrition: jsonSerialization['nutrition'] as int,
      isYou: _is.BoolJsonExtension.fromJson(jsonSerialization['isYou']),
    );
  }

  int rank;

  int petId;

  String petName;

  String speciesKey;

  int level;

  int nutrition;

  bool isYou;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeaderboardEntry copyWith({
    int? rank,
    int? petId,
    String? petName,
    String? speciesKey,
    int? level,
    int? nutrition,
    bool? isYou,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'petId': petId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'nutrition': nutrition,
      'isYou': isYou,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'petId': petId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'nutrition': nutrition,
      'isYou': isYou,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int rank,
    required int petId,
    required String petName,
    required String speciesKey,
    required int level,
    required int nutrition,
    required bool isYou,
  }) : super._(
         rank: rank,
         petId: petId,
         petName: petName,
         speciesKey: speciesKey,
         level: level,
         nutrition: nutrition,
         isYou: isYou,
       );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeaderboardEntry copyWith({
    int? rank,
    int? petId,
    String? petName,
    String? speciesKey,
    int? level,
    int? nutrition,
    bool? isYou,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      petId: petId ?? this.petId,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      level: level ?? this.level,
      nutrition: nutrition ?? this.nutrition,
      isYou: isYou ?? this.isYou,
    );
  }
}
