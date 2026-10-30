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
import '../streak/streak_buddy_status.dart' as _iwq0twic;

/// One shared streak as the caller sees it.
abstract class StreakBuddyView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StreakBuddyView._({
    required this.id,
    required this.status,
    required this.friendPetName,
    required this.friendSpeciesKey,
    required this.streak,
    required this.bestStreak,
    required this.youFedToday,
    required this.friendFedToday,
  });

  factory StreakBuddyView({
    required int id,
    required _iwq0twic.StreakBuddyStatus status,
    required String friendPetName,
    required String friendSpeciesKey,
    required int streak,
    required int bestStreak,
    required bool youFedToday,
    required bool friendFedToday,
  }) = _StreakBuddyViewImpl;

  factory StreakBuddyView.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreakBuddyView(
      id: jsonSerialization['id'] as int,
      status: _iwq0twic.StreakBuddyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      friendPetName: jsonSerialization['friendPetName'] as String,
      friendSpeciesKey: jsonSerialization['friendSpeciesKey'] as String,
      streak: jsonSerialization['streak'] as int,
      bestStreak: jsonSerialization['bestStreak'] as int,
      youFedToday: _is.BoolJsonExtension.fromJson(
        jsonSerialization['youFedToday'],
      ),
      friendFedToday: _is.BoolJsonExtension.fromJson(
        jsonSerialization['friendFedToday'],
      ),
    );
  }

  int id;

  _iwq0twic.StreakBuddyStatus status;

  String friendPetName;

  String friendSpeciesKey;

  int streak;

  int bestStreak;

  bool youFedToday;

  bool friendFedToday;

  /// Returns a shallow copy of this [StreakBuddyView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StreakBuddyView copyWith({
    int? id,
    _iwq0twic.StreakBuddyStatus? status,
    String? friendPetName,
    String? friendSpeciesKey,
    int? streak,
    int? bestStreak,
    bool? youFedToday,
    bool? friendFedToday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreakBuddyView',
      'id': id,
      'status': status.toJson(),
      'friendPetName': friendPetName,
      'friendSpeciesKey': friendSpeciesKey,
      'streak': streak,
      'bestStreak': bestStreak,
      'youFedToday': youFedToday,
      'friendFedToday': friendFedToday,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreakBuddyView',
      'id': id,
      'status': status.toJson(),
      'friendPetName': friendPetName,
      'friendSpeciesKey': friendSpeciesKey,
      'streak': streak,
      'bestStreak': bestStreak,
      'youFedToday': youFedToday,
      'friendFedToday': friendFedToday,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _StreakBuddyViewImpl extends StreakBuddyView {
  _StreakBuddyViewImpl({
    required int id,
    required _iwq0twic.StreakBuddyStatus status,
    required String friendPetName,
    required String friendSpeciesKey,
    required int streak,
    required int bestStreak,
    required bool youFedToday,
    required bool friendFedToday,
  }) : super._(
         id: id,
         status: status,
         friendPetName: friendPetName,
         friendSpeciesKey: friendSpeciesKey,
         streak: streak,
         bestStreak: bestStreak,
         youFedToday: youFedToday,
         friendFedToday: friendFedToday,
       );

  /// Returns a shallow copy of this [StreakBuddyView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StreakBuddyView copyWith({
    int? id,
    _iwq0twic.StreakBuddyStatus? status,
    String? friendPetName,
    String? friendSpeciesKey,
    int? streak,
    int? bestStreak,
    bool? youFedToday,
    bool? friendFedToday,
  }) {
    return StreakBuddyView(
      id: id ?? this.id,
      status: status ?? this.status,
      friendPetName: friendPetName ?? this.friendPetName,
      friendSpeciesKey: friendSpeciesKey ?? this.friendSpeciesKey,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      youFedToday: youFedToday ?? this.youFedToday,
      friendFedToday: friendFedToday ?? this.friendFedToday,
    );
  }
}
