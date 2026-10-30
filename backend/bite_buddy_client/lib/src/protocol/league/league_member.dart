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

/// One user's membership of a league.
abstract class LeagueMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeagueMember._({
    this.id,
    required this.leagueId,
    required this.userId,
    required this.joinedAt,
  });

  factory LeagueMember({
    int? id,
    required int leagueId,
    required _isc.UuidValue userId,
    required DateTime joinedAt,
  }) = _LeagueMemberImpl;

  factory LeagueMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueMember(
      id: jsonSerialization['id'] as int?,
      leagueId: jsonSerialization['leagueId'] as int,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int leagueId;

  _isc.UuidValue userId;

  DateTime joinedAt;

  /// Returns a shallow copy of this [LeagueMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeagueMember copyWith({
    int? id,
    int? leagueId,
    _isc.UuidValue? userId,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueMember',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueMember',
      if (id != null) 'id': id,
      'leagueId': leagueId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueMemberImpl extends LeagueMember {
  _LeagueMemberImpl({
    int? id,
    required int leagueId,
    required _isc.UuidValue userId,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         userId: userId,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [LeagueMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeagueMember copyWith({
    Object? id = _Undefined,
    int? leagueId,
    _isc.UuidValue? userId,
    DateTime? joinedAt,
  }) {
    return LeagueMember(
      id: id is int? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
