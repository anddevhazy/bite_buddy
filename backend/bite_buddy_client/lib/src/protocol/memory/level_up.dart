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

/// When a pet reached a level, for the memory book's level journey.
abstract class LevelUp
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LevelUp._({
    this.id,
    required this.ownerId,
    required this.level,
    required this.reachedAt,
  });

  factory LevelUp({
    int? id,
    required _isc.UuidValue ownerId,
    required int level,
    required DateTime reachedAt,
  }) = _LevelUpImpl;

  factory LevelUp.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUp(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      level: jsonSerialization['level'] as int,
      reachedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['reachedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue ownerId;

  int level;

  DateTime reachedAt;

  /// Returns a shallow copy of this [LevelUp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelUp copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    int? level,
    DateTime? reachedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelUp',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelUp',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpImpl extends LevelUp {
  _LevelUpImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required int level,
    required DateTime reachedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         level: level,
         reachedAt: reachedAt,
       );

  /// Returns a shallow copy of this [LevelUp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LevelUp copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    int? level,
    DateTime? reachedAt,
  }) {
    return LevelUp(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      level: level ?? this.level,
      reachedAt: reachedAt ?? this.reachedAt,
    );
  }
}
