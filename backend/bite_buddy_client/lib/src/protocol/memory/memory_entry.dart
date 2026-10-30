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

/// One milestone in the memory book, e.g. a first meal or a 7-day streak.
abstract class MemoryEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemoryEntry._({
    required this.key,
    required this.emoji,
    required this.title,
    this.detail,
    required this.happenedAt,
    this.keepsake,
  });

  factory MemoryEntry({
    required String key,
    required String emoji,
    required String title,
    String? detail,
    required DateTime happenedAt,
    String? keepsake,
  }) = _MemoryEntryImpl;

  factory MemoryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemoryEntry(
      key: jsonSerialization['key'] as String,
      emoji: jsonSerialization['emoji'] as String,
      title: jsonSerialization['title'] as String,
      detail: jsonSerialization['detail'] as String?,
      happenedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['happenedAt'],
      ),
      keepsake: jsonSerialization['keepsake'] as String?,
    );
  }

  /// Stable id for the kind of milestone, e.g. meals_50, streak_7, level_5.
  String key;

  String emoji;

  String title;

  String? detail;

  DateTime happenedAt;

  /// "mintable" or "minted" for milestones that can become a keepsake NFT,
  /// otherwise null.
  String? keepsake;

  /// Returns a shallow copy of this [MemoryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemoryEntry copyWith({
    String? key,
    String? emoji,
    String? title,
    String? detail,
    DateTime? happenedAt,
    String? keepsake,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemoryEntry',
      'key': key,
      'emoji': emoji,
      'title': title,
      if (detail != null) 'detail': detail,
      'happenedAt': happenedAt.toJson(),
      if (keepsake != null) 'keepsake': keepsake,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemoryEntry',
      'key': key,
      'emoji': emoji,
      'title': title,
      if (detail != null) 'detail': detail,
      'happenedAt': happenedAt.toJson(),
      if (keepsake != null) 'keepsake': keepsake,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryEntryImpl extends MemoryEntry {
  _MemoryEntryImpl({
    required String key,
    required String emoji,
    required String title,
    String? detail,
    required DateTime happenedAt,
    String? keepsake,
  }) : super._(
         key: key,
         emoji: emoji,
         title: title,
         detail: detail,
         happenedAt: happenedAt,
         keepsake: keepsake,
       );

  /// Returns a shallow copy of this [MemoryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemoryEntry copyWith({
    String? key,
    String? emoji,
    String? title,
    Object? detail = _Undefined,
    DateTime? happenedAt,
    Object? keepsake = _Undefined,
  }) {
    return MemoryEntry(
      key: key ?? this.key,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      detail: detail is String? ? detail : this.detail,
      happenedAt: happenedAt ?? this.happenedAt,
      keepsake: keepsake is String? ? keepsake : this.keepsake,
    );
  }
}
