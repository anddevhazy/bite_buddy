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

/// One player's place in a challenge.
abstract class ChallengeStanding
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChallengeStanding._({
    required this.rank,
    required this.petName,
    required this.speciesKey,
    required this.score,
    required this.isYou,
  });

  factory ChallengeStanding({
    required int rank,
    required String petName,
    required String speciesKey,
    required int score,
    required bool isYou,
  }) = _ChallengeStandingImpl;

  factory ChallengeStanding.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeStanding(
      rank: jsonSerialization['rank'] as int,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      score: jsonSerialization['score'] as int,
      isYou: _isc.BoolJsonExtension.fromJson(jsonSerialization['isYou']),
    );
  }

  int rank;

  String petName;

  String speciesKey;

  /// Healthy meals (score 70+) fed during the challenge.
  int score;

  bool isYou;

  /// Returns a shallow copy of this [ChallengeStanding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChallengeStanding copyWith({
    int? rank,
    String? petName,
    String? speciesKey,
    int? score,
    bool? isYou,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeStanding',
      'rank': rank,
      'petName': petName,
      'speciesKey': speciesKey,
      'score': score,
      'isYou': isYou,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeStanding',
      'rank': rank,
      'petName': petName,
      'speciesKey': speciesKey,
      'score': score,
      'isYou': isYou,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ChallengeStandingImpl extends ChallengeStanding {
  _ChallengeStandingImpl({
    required int rank,
    required String petName,
    required String speciesKey,
    required int score,
    required bool isYou,
  }) : super._(
         rank: rank,
         petName: petName,
         speciesKey: speciesKey,
         score: score,
         isYou: isYou,
       );

  /// Returns a shallow copy of this [ChallengeStanding]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChallengeStanding copyWith({
    int? rank,
    String? petName,
    String? speciesKey,
    int? score,
    bool? isYou,
  }) {
    return ChallengeStanding(
      rank: rank ?? this.rank,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      score: score ?? this.score,
      isYou: isYou ?? this.isYou,
    );
  }
}
