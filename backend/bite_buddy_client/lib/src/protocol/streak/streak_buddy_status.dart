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

enum StreakBuddyStatus implements _isc.SerializableModel {
  /// Both friends accepted; the streak is running.
  active,

  /// The caller sent the invite and is waiting for the friend.
  invited,

  /// The friend invited the caller, who can accept or decline.
  incoming;

  static StreakBuddyStatus fromJson(String name) {
    switch (name) {
      case 'active':
        return StreakBuddyStatus.active;
      case 'invited':
        return StreakBuddyStatus.invited;
      case 'incoming':
        return StreakBuddyStatus.incoming;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "StreakBuddyStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
