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

abstract class LevelPoint
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LevelPoint._({
    required this.level,
    required this.reachedAt,
  });

  factory LevelPoint({
    required int level,
    required DateTime reachedAt,
  }) = _LevelPointImpl;

  factory LevelPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelPoint(
      level: jsonSerialization['level'] as int,
      reachedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['reachedAt'],
      ),
    );
  }

  int level;

  DateTime reachedAt;

  /// Returns a shallow copy of this [LevelPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelPoint copyWith({
    int? level,
    DateTime? reachedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelPoint',
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelPoint',
      'level': level,
      'reachedAt': reachedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LevelPointImpl extends LevelPoint {
  _LevelPointImpl({
    required int level,
    required DateTime reachedAt,
  }) : super._(
         level: level,
         reachedAt: reachedAt,
       );

  /// Returns a shallow copy of this [LevelPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LevelPoint copyWith({
    int? level,
    DateTime? reachedAt,
  }) {
    return LevelPoint(
      level: level ?? this.level,
      reachedAt: reachedAt ?? this.reachedAt,
    );
  }
}
