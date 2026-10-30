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
import '../league/league_standing.dart' as _iyvw479e;

/// The final standings of one finished weekly season. Its unique index is
/// what stops a season being paid out twice.
abstract class SeasonResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SeasonResult._({
    this.id,
    required this.leagueId,
    required this.weekStart,
    this.winnerUserId,
    required this.standings,
    required this.createdAt,
  });

  factory SeasonResult({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    _isc.UuidValue? winnerUserId,
    required List<_iyvw479e.LeagueStanding> standings,
    required DateTime createdAt,
  }) = _SeasonResultImpl;

  factory SeasonResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeasonResult(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      weekStart: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      winnerUserId: jsonSerialization['winnerUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['winnerUserId'],
            ),
      standings: _i7z1njky.Protocol()
          .deserialize<List<_iyvw479e.LeagueStanding>>(
            jsonSerialization['standings'],
          ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int leagueId;

  /// Monday 00:00 UTC of the season's week.
  DateTime weekStart;

  /// Null when nobody scored or the league had fewer than 2 members.
  _isc.UuidValue? winnerUserId;

  List<_iyvw479e.LeagueStanding> standings;

  DateTime createdAt;

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SeasonResult copyWith({
    int? id,
    int? leagueId,
    DateTime? weekStart,
    _isc.UuidValue? winnerUserId,
    List<_iyvw479e.LeagueStanding>? standings,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'weekStart': weekStart.toJson(),
      if (winnerUserId != null) 'winnerUserId': winnerUserId?.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonResultImpl extends SeasonResult {
  _SeasonResultImpl({
    int? id,
    required int leagueId,
    required DateTime weekStart,
    _isc.UuidValue? winnerUserId,
    required List<_iyvw479e.LeagueStanding> standings,
    required DateTime createdAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         weekStart: weekStart,
         winnerUserId: winnerUserId,
         standings: standings,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SeasonResult copyWith({
    Object? id = _Undefined,
    int? leagueId,
    DateTime? weekStart,
    Object? winnerUserId = _Undefined,
    List<_iyvw479e.LeagueStanding>? standings,
    DateTime? createdAt,
  }) {
    return SeasonResult(
      id: id is int? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      weekStart: weekStart ?? this.weekStart,
      winnerUserId: winnerUserId is _isc.UuidValue?
          ? winnerUserId
          : this.winnerUserId,
      standings:
          standings ?? this.standings.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
