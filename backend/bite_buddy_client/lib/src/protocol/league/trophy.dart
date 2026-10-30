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

/// Awarded to a league's weekly winner, shown on their profile.
abstract class Trophy
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Trophy._({
    this.id,
    required this.userId,
    required this.leagueId,
    required this.leagueName,
    required this.weekStart,
    required this.score,
    required this.createdAt,
  });

  factory Trophy({
    int? id,
    required _isc.UuidValue userId,
    required int leagueId,
    required String leagueName,
    required DateTime weekStart,
    required int score,
    required DateTime createdAt,
  }) = _TrophyImpl;

  factory Trophy.fromJson(Map<String, dynamic> jsonSerialization) {
    return Trophy(
      id: jsonSerialization['id'] as int?,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      leagueId: jsonSerialization['leagueId'] as int,
      leagueName: jsonSerialization['leagueName'] as String,
      weekStart: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      score: jsonSerialization['score'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue userId;

  int leagueId;

  String leagueName;

  DateTime weekStart;

  int score;

  DateTime createdAt;

  /// Returns a shallow copy of this [Trophy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Trophy copyWith({
    int? id,
    _isc.UuidValue? userId,
    int? leagueId,
    String? leagueName,
    DateTime? weekStart,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Trophy',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'leagueId': leagueId,
      'leagueName': leagueName,
      'weekStart': weekStart.toJson(),
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Trophy',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'leagueId': leagueId,
      'leagueName': leagueName,
      'weekStart': weekStart.toJson(),
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrophyImpl extends Trophy {
  _TrophyImpl({
    int? id,
    required _isc.UuidValue userId,
    required int leagueId,
    required String leagueName,
    required DateTime weekStart,
    required int score,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         leagueId: leagueId,
         leagueName: leagueName,
         weekStart: weekStart,
         score: score,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Trophy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Trophy copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? userId,
    int? leagueId,
    String? leagueName,
    DateTime? weekStart,
    int? score,
    DateTime? createdAt,
  }) {
    return Trophy(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      leagueId: leagueId ?? this.leagueId,
      leagueName: leagueName ?? this.leagueName,
      weekStart: weekStart ?? this.weekStart,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
