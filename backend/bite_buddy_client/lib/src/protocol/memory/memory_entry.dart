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
  });

  factory MemoryEntry({
    required String key,
    required String emoji,
    required String title,
    String? detail,
    required DateTime happenedAt,
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
    );
  }

  /// Stable id for the kind of milestone, e.g. meals_50, streak_7, level_5.
  String key;

  String emoji;

  String title;

  String? detail;

  DateTime happenedAt;

  /// Returns a shallow copy of this [MemoryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemoryEntry copyWith({
    String? key,
    String? emoji,
    String? title,
    String? detail,
    DateTime? happenedAt,
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
  }) : super._(
         key: key,
         emoji: emoji,
         title: title,
         detail: detail,
         happenedAt: happenedAt,
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
  }) {
    return MemoryEntry(
      key: key ?? this.key,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      detail: detail is String? ? detail : this.detail,
      happenedAt: happenedAt ?? this.happenedAt,
    );
  }
}
