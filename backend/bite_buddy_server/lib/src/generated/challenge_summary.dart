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
import 'challenge_standing.dart' as _itrt04px;

/// A challenge with its current standings.
abstract class ChallengeSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChallengeSummary._({
    required this.id,
    required this.name,
    required this.code,
    required this.startsAt,
    required this.endsAt,
    required this.isOwner,
    required this.standings,
  });

  factory ChallengeSummary({
    required int id,
    required String name,
    required String code,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isOwner,
    required List<_itrt04px.ChallengeStanding> standings,
  }) = _ChallengeSummaryImpl;

  factory ChallengeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeSummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      isOwner: _is.BoolJsonExtension.fromJson(jsonSerialization['isOwner']),
      standings: _i61ow1lb.Protocol()
          .deserialize<List<_itrt04px.ChallengeStanding>>(
            jsonSerialization['standings'],
          ),
    );
  }

  int id;

  String name;

  String code;

  DateTime startsAt;

  DateTime endsAt;

  bool isOwner;

  List<_itrt04px.ChallengeStanding> standings;

  /// Returns a shallow copy of this [ChallengeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChallengeSummary copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isOwner,
    List<_itrt04px.ChallengeStanding>? standings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeSummary',
      'id': id,
      'name': name,
      'code': code,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isOwner': isOwner,
      'standings': standings.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeSummary',
      'id': id,
      'name': name,
      'code': code,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isOwner': isOwner,
      'standings': standings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ChallengeSummaryImpl extends ChallengeSummary {
  _ChallengeSummaryImpl({
    required int id,
    required String name,
    required String code,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isOwner,
    required List<_itrt04px.ChallengeStanding> standings,
  }) : super._(
         id: id,
         name: name,
         code: code,
         startsAt: startsAt,
         endsAt: endsAt,
         isOwner: isOwner,
         standings: standings,
       );

  /// Returns a shallow copy of this [ChallengeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChallengeSummary copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isOwner,
    List<_itrt04px.ChallengeStanding>? standings,
  }) {
    return ChallengeSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isOwner: isOwner ?? this.isOwner,
      standings:
          standings ?? this.standings.map((e0) => e0.copyWith()).toList(),
    );
  }
}
