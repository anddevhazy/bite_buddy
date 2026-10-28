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
import 'friend_status.dart' as _ic60syjb;

/// A friend or pending request, as the app shows it. Leaves out the other
/// user's id on purpose.
abstract class Friend
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Friend._({
    required this.friendshipId,
    required this.status,
    required this.petId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.nutrition,
    required this.streak,
    required this.sharedStreak,
  });

  factory Friend({
    required int friendshipId,
    required _ic60syjb.FriendStatus status,
    required int petId,
    required String petName,
    required String speciesKey,
    required int level,
    required int nutrition,
    required int streak,
    required int sharedStreak,
  }) = _FriendImpl;

  factory Friend.fromJson(Map<String, dynamic> jsonSerialization) {
    return Friend(
      friendshipId: jsonSerialization['friendshipId'] as int,
      status: _ic60syjb.FriendStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      petId: jsonSerialization['petId'] as int,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      level: jsonSerialization['level'] as int,
      nutrition: jsonSerialization['nutrition'] as int,
      streak: jsonSerialization['streak'] as int,
      sharedStreak: jsonSerialization['sharedStreak'] as int,
    );
  }

  int friendshipId;

  _ic60syjb.FriendStatus status;

  int petId;

  String petName;

  String speciesKey;

  int level;

  int nutrition;

  int streak;

  /// 0 unless you're friends and both fed on the same days.
  int sharedStreak;

  /// Returns a shallow copy of this [Friend]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Friend copyWith({
    int? friendshipId,
    _ic60syjb.FriendStatus? status,
    int? petId,
    String? petName,
    String? speciesKey,
    int? level,
    int? nutrition,
    int? streak,
    int? sharedStreak,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Friend',
      'friendshipId': friendshipId,
      'status': status.toJson(),
      'petId': petId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'nutrition': nutrition,
      'streak': streak,
      'sharedStreak': sharedStreak,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Friend',
      'friendshipId': friendshipId,
      'status': status.toJson(),
      'petId': petId,
      'petName': petName,
      'speciesKey': speciesKey,
      'level': level,
      'nutrition': nutrition,
      'streak': streak,
      'sharedStreak': sharedStreak,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FriendImpl extends Friend {
  _FriendImpl({
    required int friendshipId,
    required _ic60syjb.FriendStatus status,
    required int petId,
    required String petName,
    required String speciesKey,
    required int level,
    required int nutrition,
    required int streak,
    required int sharedStreak,
  }) : super._(
         friendshipId: friendshipId,
         status: status,
         petId: petId,
         petName: petName,
         speciesKey: speciesKey,
         level: level,
         nutrition: nutrition,
         streak: streak,
         sharedStreak: sharedStreak,
       );

  /// Returns a shallow copy of this [Friend]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Friend copyWith({
    int? friendshipId,
    _ic60syjb.FriendStatus? status,
    int? petId,
    String? petName,
    String? speciesKey,
    int? level,
    int? nutrition,
    int? streak,
    int? sharedStreak,
  }) {
    return Friend(
      friendshipId: friendshipId ?? this.friendshipId,
      status: status ?? this.status,
      petId: petId ?? this.petId,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      level: level ?? this.level,
      nutrition: nutrition ?? this.nutrition,
      streak: streak ?? this.streak,
      sharedStreak: sharedStreak ?? this.sharedStreak,
    );
  }
}
