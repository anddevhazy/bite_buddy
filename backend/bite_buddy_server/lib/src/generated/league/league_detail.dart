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
import 'package:bite_buddy_server/src/generated/protocol.dart' as _i61ow1lb;
import 'package:serverpod/serverpod.dart' as _is;
import '../league/duel_view.dart' as _i0oqzm9q;
import '../league/league_challenge.dart' as _iomiitux;
import '../league/league_standing.dart' as _iyvw479e;

/// Everything on a league's screen.
abstract class LeagueDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LeagueDetail._({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.isOwner,
    required this.seasonStartsAt,
    required this.seasonEndsAt,
    required this.standings,
    required this.challenge,
    required this.duels,
    this.lastSeasonWinner,
    this.lastSeasonYourRank,
    this.lastChallengeCompleted,
  });

  factory LeagueDetail({
    required int id,
    required String name,
    required String inviteCode,
    required bool isOwner,
    required DateTime seasonStartsAt,
    required DateTime seasonEndsAt,
    required List<_iyvw479e.LeagueStanding> standings,
    required _iomiitux.LeagueChallenge challenge,
    required List<_i0oqzm9q.DuelView> duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
    bool? lastChallengeCompleted,
  }) = _LeagueDetailImpl;

  factory LeagueDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueDetail(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      isOwner: _is.BoolJsonExtension.fromJson(jsonSerialization['isOwner']),
      seasonStartsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['seasonStartsAt'],
      ),
      seasonEndsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['seasonEndsAt'],
      ),
      standings: _i61ow1lb.Protocol()
          .deserialize<List<_iyvw479e.LeagueStanding>>(
            jsonSerialization['standings'],
          ),
      challenge: _i61ow1lb.Protocol().deserialize<_iomiitux.LeagueChallenge>(
        jsonSerialization['challenge'],
      ),
      duels: _i61ow1lb.Protocol().deserialize<List<_i0oqzm9q.DuelView>>(
        jsonSerialization['duels'],
      ),
      lastSeasonWinner: jsonSerialization['lastSeasonWinner'] as String?,
      lastSeasonYourRank: jsonSerialization['lastSeasonYourRank'] as int?,
      lastChallengeCompleted:
          jsonSerialization['lastChallengeCompleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['lastChallengeCompleted'],
            ),
    );
  }

  int id;

  String name;

  String inviteCode;

  bool isOwner;

  DateTime seasonStartsAt;

  DateTime seasonEndsAt;

  List<_iyvw479e.LeagueStanding> standings;

  _iomiitux.LeagueChallenge challenge;

  /// The caller's friend battles in this league: active ones, then the most
  /// recent finished ones.
  List<_i0oqzm9q.DuelView> duels;

  /// How last week ended, if there was a last week.
  String? lastSeasonWinner;

  int? lastSeasonYourRank;

  /// Whether last week's team challenge was met (and paid out).
  bool? lastChallengeCompleted;

  /// Returns a shallow copy of this [LeagueDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeagueDetail copyWith({
    int? id,
    String? name,
    String? inviteCode,
    bool? isOwner,
    DateTime? seasonStartsAt,
    DateTime? seasonEndsAt,
    List<_iyvw479e.LeagueStanding>? standings,
    _iomiitux.LeagueChallenge? challenge,
    List<_i0oqzm9q.DuelView>? duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
    bool? lastChallengeCompleted,
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
      'challenge': challenge.toJson(),
      'duels': duels.toJson(valueToJson: (v) => v.toJson()),
      if (lastSeasonWinner != null) 'lastSeasonWinner': lastSeasonWinner,
      if (lastSeasonYourRank != null) 'lastSeasonYourRank': lastSeasonYourRank,
      if (lastChallengeCompleted != null)
        'lastChallengeCompleted': lastChallengeCompleted,
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
      'challenge': challenge.toJsonForProtocol(),
      'duels': duels.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (lastSeasonWinner != null) 'lastSeasonWinner': lastSeasonWinner,
      if (lastSeasonYourRank != null) 'lastSeasonYourRank': lastSeasonYourRank,
      if (lastChallengeCompleted != null)
        'lastChallengeCompleted': lastChallengeCompleted,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    required _iomiitux.LeagueChallenge challenge,
    required List<_i0oqzm9q.DuelView> duels,
    String? lastSeasonWinner,
    int? lastSeasonYourRank,
    bool? lastChallengeCompleted,
  }) : super._(
         id: id,
         name: name,
         inviteCode: inviteCode,
         isOwner: isOwner,
         seasonStartsAt: seasonStartsAt,
         seasonEndsAt: seasonEndsAt,
         standings: standings,
         challenge: challenge,
         duels: duels,
         lastSeasonWinner: lastSeasonWinner,
         lastSeasonYourRank: lastSeasonYourRank,
         lastChallengeCompleted: lastChallengeCompleted,
       );

  /// Returns a shallow copy of this [LeagueDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeagueDetail copyWith({
    int? id,
    String? name,
    String? inviteCode,
    bool? isOwner,
    DateTime? seasonStartsAt,
    DateTime? seasonEndsAt,
    List<_iyvw479e.LeagueStanding>? standings,
    _iomiitux.LeagueChallenge? challenge,
    List<_i0oqzm9q.DuelView>? duels,
    Object? lastSeasonWinner = _Undefined,
    Object? lastSeasonYourRank = _Undefined,
    Object? lastChallengeCompleted = _Undefined,
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
      challenge: challenge ?? this.challenge.copyWith(),
      duels: duels ?? this.duels.map((e0) => e0.copyWith()).toList(),
      lastSeasonWinner: lastSeasonWinner is String?
          ? lastSeasonWinner
          : this.lastSeasonWinner,
      lastSeasonYourRank: lastSeasonYourRank is int?
          ? lastSeasonYourRank
          : this.lastSeasonYourRank,
      lastChallengeCompleted: lastChallengeCompleted is bool?
          ? lastChallengeCompleted
          : this.lastChallengeCompleted,
    );
  }
}
