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

abstract class ChallengeMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChallengeMember._({
    this.id,
    required this.challengeId,
    required this.userId,
    required this.joinedAt,
  });

  factory ChallengeMember({
    int? id,
    required int challengeId,
    required _isc.UuidValue userId,
    required DateTime joinedAt,
  }) = _ChallengeMemberImpl;

  factory ChallengeMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeMember(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as int,
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

  int challengeId;

  _isc.UuidValue userId;

  DateTime joinedAt;

  /// Returns a shallow copy of this [ChallengeMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChallengeMember copyWith({
    int? id,
    int? challengeId,
    _isc.UuidValue? userId,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeMember',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'userId': userId.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeMember',
      if (id != null) 'id': id,
      'challengeId': challengeId,
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

class _ChallengeMemberImpl extends ChallengeMember {
  _ChallengeMemberImpl({
    int? id,
    required int challengeId,
    required _isc.UuidValue userId,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         challengeId: challengeId,
         userId: userId,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [ChallengeMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChallengeMember copyWith({
    Object? id = _Undefined,
    int? challengeId,
    _isc.UuidValue? userId,
    DateTime? joinedAt,
  }) {
    return ChallengeMember(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
