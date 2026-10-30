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
import '../league/duel_view.dart' as _i0oqzm9q;
import '../league/league_standing.dart' as _iyvw479e;

/// Everything on a league's screen.
abstract class LeagueDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeagueDetail._({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.isOwner,
    required this.seasonStartsAt,
    required this.seasonEndsAt,
    required this.standings,
    required this.duels,
    this.lastSeasonWinner,
    this.lastSeasonYourRank,
  });

  factory LeagueDetail({
    required int id,
    required String name,
    required String inviteCode,
    required bool isOwner,
    required DateTime seasonStartsAt,
    required DateTime seasonEndsAt,
    required List<_iyvw479e.LeagueStanding> standings,
    required List<_i0oqzm9q.DuelView> duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
  }) = _LeagueDetailImpl;

  factory LeagueDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueDetail(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      isOwner: _isc.BoolJsonExtension.fromJson(jsonSerialization['isOwner']),
      seasonStartsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['seasonStartsAt'],
      ),
      seasonEndsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['seasonEndsAt'],
      ),
      standings: _i7z1njky.Protocol()
          .deserialize<List<_iyvw479e.LeagueStanding>>(
            jsonSerialization['standings'],
          ),
      duels: _i7z1njky.Protocol().deserialize<List<_i0oqzm9q.DuelView>>(
        jsonSerialization['duels'],
      ),
      lastSeasonWinner: jsonSerialization['lastSeasonWinner'] as String?,
      lastSeasonYourRank: jsonSerialization['lastSeasonYourRank'] as int?,
    );
  }

  int id;

  String name;

  String inviteCode;

  bool isOwner;

  DateTime seasonStartsAt;

  DateTime seasonEndsAt;

  List<_iyvw479e.LeagueStanding> standings;

  /// The caller's friend battles in this league: active ones, then the most
  /// recent finished ones.
  List<_i0oqzm9q.DuelView> duels;

  /// How last week ended, if there was a last week.
  String? lastSeasonWinner;

  int? lastSeasonYourRank;

  /// Returns a shallow copy of this [LeagueDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeagueDetail copyWith({
    int? id,
    String? name,
    String? inviteCode,
    bool? isOwner,
    DateTime? seasonStartsAt,
    DateTime? seasonEndsAt,
    List<_iyvw479e.LeagueStanding>? standings,
    List<_i0oqzm9q.DuelView>? duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueDetail',
      'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'isOwner': isOwner,
      'seasonStartsAt': seasonStartsAt.toJson(),
      'seasonEndsAt': seasonEndsAt.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJson()),
      'duels': duels.toJson(valueToJson: (v) => v.toJson()),
      if (lastSeasonWinner != null) 'lastSeasonWinner': lastSeasonWinner,
      if (lastSeasonYourRank != null) 'lastSeasonYourRank': lastSeasonYourRank,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueDetail',
      'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'isOwner': isOwner,
      'seasonStartsAt': seasonStartsAt.toJson(),
      'seasonEndsAt': seasonEndsAt.toJson(),
      'standings': standings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'duels': duels.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (lastSeasonWinner != null) 'lastSeasonWinner': lastSeasonWinner,
      if (lastSeasonYourRank != null) 'lastSeasonYourRank': lastSeasonYourRank,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueDetailImpl extends LeagueDetail {
  _LeagueDetailImpl({
    required int id,
    required String name,
    required String inviteCode,
    required bool isOwner,
    required DateTime seasonStartsAt,
    required DateTime seasonEndsAt,
    required List<_iyvw479e.LeagueStanding> standings,
    required List<_i0oqzm9q.DuelView> duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
  }) : super._(
         id: id,
         name: name,
         inviteCode: inviteCode,
         isOwner: isOwner,
         seasonStartsAt: seasonStartsAt,
         seasonEndsAt: seasonEndsAt,
         standings: standings,
         duels: duels,
         lastSeasonWinner: lastSeasonWinner,
         lastSeasonYourRank: lastSeasonYourRank,
       );

  /// Returns a shallow copy of this [LeagueDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeagueDetail copyWith({
    int? id,
    String? name,
    String? inviteCode,
    bool? isOwner,
    DateTime? seasonStartsAt,
    DateTime? seasonEndsAt,
    List<_iyvw479e.LeagueStanding>? standings,
    List<_i0oqzm9q.DuelView>? duels,
    Object? lastSeasonWinner = _Undefined,
    Object? lastSeasonYourRank = _Undefined,
  }) {
    return LeagueDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      isOwner: isOwner ?? this.isOwner,
      seasonStartsAt: seasonStartsAt ?? this.seasonStartsAt,
      seasonEndsAt: seasonEndsAt ?? this.seasonEndsAt,
      standings:
          standings ?? this.standings.map((e0) => e0.copyWith()).toList(),
      duels: duels ?? this.duels.map((e0) => e0.copyWith()).toList(),
      lastSeasonWinner: lastSeasonWinner is String?
          ? lastSeasonWinner
          : this.lastSeasonWinner,
      lastSeasonYourRank: lastSeasonYourRank is int?
          ? lastSeasonYourRank
          : this.lastSeasonYourRank,
    );
  }
}
