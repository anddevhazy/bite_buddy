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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;

/// A freshly made portrait for the user to look at before using it.
abstract class PortraitDraft
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PortraitDraft._({
    required this.id,
    required this.image,
    required this.animal,
    required this.triesLeftToday,
  });

  factory PortraitDraft({
    required int id,
    required _idt.ByteData image,
    required String animal,
    required int triesLeftToday,
  }) = _PortraitDraftImpl;

  factory PortraitDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return PortraitDraft(
      id: jsonSerialization['id'] as int,
      image: _is.ByteDataJsonExtension.fromJson(jsonSerialization['image']),
      animal: jsonSerialization['animal'] as String,
      triesLeftToday: jsonSerialization['triesLeftToday'] as int,
    );
  }

  int id;

  _idt.ByteData image;

  String animal;

  /// Redraws left today, after this one.
  int triesLeftToday;

  /// Returns a shallow copy of this [PortraitDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PortraitDraft copyWith({
    int? id,
    _idt.ByteData? image,
    String? animal,
    int? triesLeftToday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PortraitDraft',
      'id': id,
      'image': image.toJson(),
      'animal': animal,
      'triesLeftToday': triesLeftToday,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PortraitDraft',
      'id': id,
      'image': image.toJson(),
      'animal': animal,
      'triesLeftToday': triesLeftToday,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PortraitDraftImpl extends PortraitDraft {
  _PortraitDraftImpl({
    required int id,
    required _idt.ByteData image,
    required String animal,
    required int triesLeftToday,
  }) : super._(
         id: id,
         image: image,
         animal: animal,
         triesLeftToday: triesLeftToday,
       );

  /// Returns a shallow copy of this [PortraitDraft]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PortraitDraft copyWith({
    int? id,
    _idt.ByteData? image,
    String? animal,
    int? triesLeftToday,
  }) {
    return PortraitDraft(
      id: id ?? this.id,
      image: image ?? this.image.clone(),
      animal: animal ?? this.animal,
      triesLeftToday: triesLeftToday ?? this.triesLeftToday,
    );
  }
}
