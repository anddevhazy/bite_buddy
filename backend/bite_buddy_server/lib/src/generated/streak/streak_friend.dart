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
import 'package:serverpod/serverpod.dart' as _is;

/// A league friend the caller could start a shared streak with.
abstract class StreakFriend
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StreakFriend._({
    required this.userId,
    required this.petName,
    required this.speciesKey,
    this.portraitId,
  });

  factory StreakFriend({
    required _is.UuidValue userId,
    required String petName,
    required String speciesKey,
    int? portraitId,
  }) = _StreakFriendImpl;

  factory StreakFriend.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreakFriend(
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
    );
  }

  _is.UuidValue userId;

  String petName;

  String speciesKey;

  int? portraitId;

  /// Returns a shallow copy of this [StreakFriend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StreakFriend copyWith({
    _is.UuidValue? userId,
    String? petName,
    String? speciesKey,
    int? portraitId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreakFriend',
      'userId': userId.toJson(),
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreakFriend',
      'userId': userId.toJson(),
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreakFriendImpl extends StreakFriend {
  _StreakFriendImpl({
    required _is.UuidValue userId,
    required String petName,
    required String speciesKey,
    int? portraitId,
  }) : super._(
         userId: userId,
         petName: petName,
         speciesKey: speciesKey,
         portraitId: portraitId,
       );

  /// Returns a shallow copy of this [StreakFriend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StreakFriend copyWith({
    _is.UuidValue? userId,
    String? petName,
    String? speciesKey,
    Object? portraitId = _Undefined,
  }) {
    return StreakFriend(
      userId: userId ?? this.userId,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
    );
  }
}
