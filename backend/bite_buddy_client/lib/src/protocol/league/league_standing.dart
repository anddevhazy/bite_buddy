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

/// One member's row in a league's season table. Scores are 0-100; the total
/// is 70% feeding and 30% battles.
abstract class LeagueStanding
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeagueStanding._({
    required this.rank,
    required this.memberId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.averageMealScore,
    required this.daysFed,
    required this.feedingScore,
    required this.wins,
    required this.battleScore,
    required this.totalScore,
    required this.isYou,
  });

  factory LeagueStanding({
    required int rank,
    required int memberId,
    required String petName,
    required String speciesKey,
    required int level,
    required int averageMealScore,
    required int daysFed,
    required int feedingScore,
    required int wins,
    required int battleScore,
    required int totalScore,
    required bool isYou,
  }) = _LeagueStandingImpl;

  factory LeagueStanding.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueStanding(
      rank: jsonSerialization['rank'] as int,
      memberId: jsonSerialization['memberId'] as int,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      level: jsonSerialization['level'] as int,
      averageMealScore: jsonSerialization['averageMealScore'] as int,
      daysFed: jsonSerialization['daysFed'] as int,
      feedingScore: jsonSerialization['feedingScore'] as int,
      wins: jsonSerialization['wins'] as int,
      battleScore: jsonSerialization['battleScore'] as int,
      totalScore: jsonSerialization['totalScore'] as int,
      isYou: _isc.BoolJsonExtension.fromJson(jsonSerialization['isYou']),
    );
  }

  int rank;

  /// The member's id in this league, used to challenge them.
  int memberId;

  String petName;

  String speciesKey;

  int level;

  /// Average health score of the meals fed this season.
  int averageMealScore;

  int daysFed;

  int feedingScore;

  /// Duel wins this season that count toward the score.
  int wins;

  int battleScore;

  int totalScore;

  bool isYou;

  /// Returns a shallow copy of this [LeagueStanding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeagueStanding copyWith({
    int? rank,
    int? memberId,
    String? petName,
    String? speciesKey,
    int? level,
    int? averageMealScore,
    int? daysFed,
    int? feedingScore,
    int? wins,
    int? battleScore,
    int? totalScore,
    bool? isYou,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueStanding',
      'rank': rank,
      'memberId': memberId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'averageMealScore': averageMealScore,
      'daysFed': daysFed,
      'feedingScore': feedingScore,
      'wins': wins,
      'battleScore': battleScore,
      'totalScore': totalScore,
      'isYou': isYou,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueStanding',
      'rank': rank,
      'memberId': memberId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'averageMealScore': averageMealScore,
      'daysFed': daysFed,
      'feedingScore': feedingScore,
      'wins': wins,
      'battleScore': battleScore,
      'totalScore': totalScore,
      'isYou': isYou,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LeagueStandingImpl extends LeagueStanding {
  _LeagueStandingImpl({
    required int rank,
    required int memberId,
    required String petName,
    required String speciesKey,
    required int level,
    required int averageMealScore,
    required int daysFed,
    required int feedingScore,
    required int wins,
    required int battleScore,
    required int totalScore,
    required bool isYou,
  }) : super._(
         rank: rank,
         memberId: memberId,
         petName: petName,
         speciesKey: speciesKey,
         level: level,
         averageMealScore: averageMealScore,
         daysFed: daysFed,
         feedingScore: feedingScore,
         wins: wins,
         battleScore: battleScore,
         totalScore: totalScore,
         isYou: isYou,
       );

  /// Returns a shallow copy of this [LeagueStanding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeagueStanding copyWith({
    int? rank,
    int? memberId,
    String? petName,
    String? speciesKey,
    int? level,
    int? averageMealScore,
    int? daysFed,
    int? feedingScore,
    int? wins,
    int? battleScore,
    int? totalScore,
    bool? isYou,
  }) {
    return LeagueStanding(
      rank: rank ?? this.rank,
      memberId: memberId ?? this.memberId,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      level: level ?? this.level,
      averageMealScore: averageMealScore ?? this.averageMealScore,
      daysFed: daysFed ?? this.daysFed,
      feedingScore: feedingScore ?? this.feedingScore,
      wins: wins ?? this.wins,
      battleScore: battleScore ?? this.battleScore,
      totalScore: totalScore ?? this.totalScore,
      isYou: isYou ?? this.isYou,
    );
  }
}
