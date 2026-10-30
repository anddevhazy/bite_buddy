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

/// A group of friends competing in weekly seasons.
abstract class League
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  League._({
    this.id,
    required this.name,
    required this.inviteCode,
    required this.ownerId,
    required this.createdAt,
  });

  factory League({
    int? id,
    required String name,
    required String inviteCode,
    required _isc.UuidValue ownerId,
    required DateTime createdAt,
  }) = _LeagueImpl;

  factory League.fromJson(Map<String, dynamic> jsonSerialization) {
    return League(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
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

  String name;

  /// Short code friends type in to join, e.g. "K7Q2MX".
  String inviteCode;

  _isc.UuidValue ownerId;

  DateTime createdAt;

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  League copyWith({
    int? id,
    String? name,
    String? inviteCode,
    _isc.UuidValue? ownerId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      'ownerId': ownerId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueImpl extends League {
  _LeagueImpl({
    int? id,
    required String name,
    required String inviteCode,
    required _isc.UuidValue ownerId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         inviteCode: inviteCode,
         ownerId: ownerId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  League copyWith({
    Object? id = _Undefined,
    String? name,
    String? inviteCode,
    _isc.UuidValue? ownerId,
    DateTime? createdAt,
  }) {
    return League(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
