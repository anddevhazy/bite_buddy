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

/// A league in the caller's list of leagues.
abstract class LeagueSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeagueSummary._({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.myRank,
    required this.myScore,
    required this.seasonEndsAt,
    required this.yourTurnCount,
  });

  factory LeagueSummary({
    required int id,
    required String name,
    required int memberCount,
    required int myRank,
    required int myScore,
    required DateTime seasonEndsAt,
    required int yourTurnCount,
  }) = _LeagueSummaryImpl;

  factory LeagueSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueSummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      memberCount: jsonSerialization['memberCount'] as int,
      myRank: jsonSerialization['myRank'] as int,
      myScore: jsonSerialization['myScore'] as int,
      seasonEndsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['seasonEndsAt'],
      ),
      yourTurnCount: jsonSerialization['yourTurnCount'] as int,
    );
  }

  int id;

  String name;

  int memberCount;

  int myRank;

  int myScore;

  DateTime seasonEndsAt;

  /// Friend battles in this league waiting for the caller's move.
  int yourTurnCount;

  /// Returns a shallow copy of this [LeagueSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeagueSummary copyWith({
    int? id,
    String? name,
    int? memberCount,
    int? myRank,
    int? myScore,
    DateTime? seasonEndsAt,
    int? yourTurnCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueSummary',
      'id': id,
      'name': name,
      'memberCount': memberCount,
      'myRank': myRank,
      'myScore': myScore,
      'seasonEndsAt': seasonEndsAt.toJson(),
      'yourTurnCount': yourTurnCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueSummary',
      'id': id,
      'name': name,
      'memberCount': memberCount,
      'myRank': myRank,
      'myScore': myScore,
      'seasonEndsAt': seasonEndsAt.toJson(),
      'yourTurnCount': yourTurnCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LeagueSummaryImpl extends LeagueSummary {
  _LeagueSummaryImpl({
    required int id,
    required String name,
    required int memberCount,
    required int myRank,
    required int myScore,
    required DateTime seasonEndsAt,
    required int yourTurnCount,
  }) : super._(
         id: id,
         name: name,
         memberCount: memberCount,
         myRank: myRank,
         myScore: myScore,
         seasonEndsAt: seasonEndsAt,
         yourTurnCount: yourTurnCount,
       );

  /// Returns a shallow copy of this [LeagueSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeagueSummary copyWith({
    int? id,
    String? name,
    int? memberCount,
    int? myRank,
    int? myScore,
    DateTime? seasonEndsAt,
    int? yourTurnCount,
  }) {
    return LeagueSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      memberCount: memberCount ?? this.memberCount,
      myRank: myRank ?? this.myRank,
      myScore: myScore ?? this.myScore,
      seasonEndsAt: seasonEndsAt ?? this.seasonEndsAt,
      yourTurnCount: yourTurnCount ?? this.yourTurnCount,
    );
  }
}
