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

/// A friend request between two users. It becomes a friendship once the
/// addressee accepts. There is one row per pair, whoever asked first.
abstract class Friendship
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Friendship._({
    this.id,
    required this.requesterId,
    required this.addresseeId,
    required this.accepted,
    required this.sharedStreak,
    this.sharedStreakDay,
    required this.createdAt,
  });

  factory Friendship({
    int? id,
    required _isc.UuidValue requesterId,
    required _isc.UuidValue addresseeId,
    required bool accepted,
    required int sharedStreak,
    DateTime? sharedStreakDay,
    required DateTime createdAt,
  }) = _FriendshipImpl;

  factory Friendship.fromJson(Map<String, dynamic> jsonSerialization) {
    return Friendship(
      id: jsonSerialization['id'] as int?,
      requesterId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['requesterId'],
      ),
      addresseeId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['addresseeId'],
      ),
      accepted: _isc.BoolJsonExtension.fromJson(jsonSerialization['accepted']),
      sharedStreak: jsonSerialization['sharedStreak'] as int,
      sharedStreakDay: jsonSerialization['sharedStreakDay'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['sharedStreakDay'],
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

  _isc.UuidValue requesterId;

  _isc.UuidValue addresseeId;

  bool accepted;

  /// Days in a row both friends fed their pets.
  int sharedStreak;

  /// The last day (UTC midnight of the feeder's local day) that counted.
  DateTime? sharedStreakDay;

  DateTime createdAt;

  /// Returns a shallow copy of this [Friendship]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Friendship copyWith({
    int? id,
    _isc.UuidValue? requesterId,
    _isc.UuidValue? addresseeId,
    bool? accepted,
    int? sharedStreak,
    DateTime? sharedStreakDay,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Friendship',
      if (id != null) 'id': id,
      'requesterId': requesterId.toJson(),
      'addresseeId': addresseeId.toJson(),
      'accepted': accepted,
      'sharedStreak': sharedStreak,
      if (sharedStreakDay != null) 'sharedStreakDay': sharedStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Friendship',
      if (id != null) 'id': id,
      'requesterId': requesterId.toJson(),
      'addresseeId': addresseeId.toJson(),
      'accepted': accepted,
      'sharedStreak': sharedStreak,
      if (sharedStreakDay != null) 'sharedStreakDay': sharedStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FriendshipImpl extends Friendship {
  _FriendshipImpl({
    int? id,
    required _isc.UuidValue requesterId,
    required _isc.UuidValue addresseeId,
    required bool accepted,
    required int sharedStreak,
    DateTime? sharedStreakDay,
    required DateTime createdAt,
  }) : super._(
         id: id,
         requesterId: requesterId,
         addresseeId: addresseeId,
         accepted: accepted,
         sharedStreak: sharedStreak,
         sharedStreakDay: sharedStreakDay,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Friendship]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Friendship copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? requesterId,
    _isc.UuidValue? addresseeId,
    bool? accepted,
    int? sharedStreak,
    Object? sharedStreakDay = _Undefined,
    DateTime? createdAt,
  }) {
    return Friendship(
      id: id is int? ? id : this.id,
      requesterId: requesterId ?? this.requesterId,
      addresseeId: addresseeId ?? this.addresseeId,
      accepted: accepted ?? this.accepted,
      sharedStreak: sharedStreak ?? this.sharedStreak,
      sharedStreakDay: sharedStreakDay is DateTime?
          ? sharedStreakDay
          : this.sharedStreakDay,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
