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

/// A keepsake the caller has minted, or can mint now.
abstract class KeepsakeView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  KeepsakeView._({
    required this.key,
    required this.title,
    required this.emoji,
    required this.kind,
    required this.earnedAt,
    required this.minted,
    this.tokenId,
    this.edition,
    this.stat,
    required this.petName,
    required this.speciesKey,
    this.portraitId,
    required this.showPaw,
    this.isTest,
    this.txUrl,
    this.metadataUrl,
    this.imageUrl,
  });

  factory KeepsakeView({
    required String key,
    required String title,
    required String emoji,
    required String kind,
    required DateTime earnedAt,
    required bool minted,
    int? tokenId,
    int? edition,
    String? stat,
    required String petName,
    required String speciesKey,
    int? portraitId,
    required bool showPaw,
    bool? isTest,
    String? txUrl,
    String? metadataUrl,
    String? imageUrl,
  }) = _KeepsakeViewImpl;

  factory KeepsakeView.fromJson(Map<String, dynamic> jsonSerialization) {
    return KeepsakeView(
      key: jsonSerialization['key'] as String,
      title: jsonSerialization['title'] as String,
      emoji: jsonSerialization['emoji'] as String,
      kind: jsonSerialization['kind'] as String,
      earnedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['earnedAt'],
      ),
      minted: _is.BoolJsonExtension.fromJson(jsonSerialization['minted']),
      tokenId: jsonSerialization['tokenId'] as int?,
      edition: jsonSerialization['edition'] as int?,
      stat: jsonSerialization['stat'] as String?,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
      showPaw: _is.BoolJsonExtension.fromJson(jsonSerialization['showPaw']),
      isTest: jsonSerialization['isTest'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isTest']),
      txUrl: jsonSerialization['txUrl'] as String?,
      metadataUrl: jsonSerialization['metadataUrl'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
    );
  }

  String key;

  String title;

  String emoji;

  /// certificate, streak, level, meals or trophy, for the card's colours.
  String kind;

  DateTime earnedAt;

  bool minted;

  /// Set once minted.
  int? tokenId;

  int? edition;

  String? stat;

  String petName;

  String speciesKey;

  int? portraitId;

  /// Show a paw instead of the buddy's picture (see Keepsake.showPaw).
  bool showPaw;

  bool? isTest;

  /// The mint transaction on a block explorer; null in test mode.
  String? txUrl;

  /// The NFT's metadata and card image, as wallets see them.
  String? metadataUrl;

  String? imageUrl;

  /// Returns a shallow copy of this [KeepsakeView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  KeepsakeView copyWith({
    String? key,
    String? title,
    String? emoji,
    String? kind,
    DateTime? earnedAt,
    bool? minted,
    int? tokenId,
    int? edition,
    String? stat,
    String? petName,
    String? speciesKey,
    int? portraitId,
    bool? showPaw,
    bool? isTest,
    String? txUrl,
    String? metadataUrl,
    String? imageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KeepsakeView',
      'key': key,
      'title': title,
      'emoji': emoji,
      'kind': kind,
      'earnedAt': earnedAt.toJson(),
      'minted': minted,
      if (tokenId != null) 'tokenId': tokenId,
      if (edition != null) 'edition': edition,
      if (stat != null) 'stat': stat,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (isTest != null) 'isTest': isTest,
      if (txUrl != null) 'txUrl': txUrl,
      if (metadataUrl != null) 'metadataUrl': metadataUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KeepsakeView',
      'key': key,
      'title': title,
      'emoji': emoji,
      'kind': kind,
      'earnedAt': earnedAt.toJson(),
      'minted': minted,
      if (tokenId != null) 'tokenId': tokenId,
      if (edition != null) 'edition': edition,
      if (stat != null) 'stat': stat,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (isTest != null) 'isTest': isTest,
      if (txUrl != null) 'txUrl': txUrl,
      if (metadataUrl != null) 'metadataUrl': metadataUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KeepsakeViewImpl extends KeepsakeView {
  _KeepsakeViewImpl({
    required String key,
    required String title,
    required String emoji,
    required String kind,
    required DateTime earnedAt,
    required bool minted,
    int? tokenId,
    int? edition,
    String? stat,
    required String petName,
    required String speciesKey,
    int? portraitId,
    required bool showPaw,
    bool? isTest,
    String? txUrl,
    String? metadataUrl,
    String? imageUrl,
  }) : super._(
         key: key,
         title: title,
         emoji: emoji,
         kind: kind,
         earnedAt: earnedAt,
         minted: minted,
         tokenId: tokenId,
         edition: edition,
         stat: stat,
         petName: petName,
         speciesKey: speciesKey,
         portraitId: portraitId,
         showPaw: showPaw,
         isTest: isTest,
         txUrl: txUrl,
         metadataUrl: metadataUrl,
         imageUrl: imageUrl,
       );

  /// Returns a shallow copy of this [KeepsakeView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  KeepsakeView copyWith({
    String? key,
    String? title,
    String? emoji,
    String? kind,
    DateTime? earnedAt,
    bool? minted,
    Object? tokenId = _Undefined,
    Object? edition = _Undefined,
    Object? stat = _Undefined,
    String? petName,
    String? speciesKey,
    Object? portraitId = _Undefined,
    bool? showPaw,
    Object? isTest = _Undefined,
    Object? txUrl = _Undefined,
    Object? metadataUrl = _Undefined,
    Object? imageUrl = _Undefined,
  }) {
    return KeepsakeView(
      key: key ?? this.key,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      kind: kind ?? this.kind,
      earnedAt: earnedAt ?? this.earnedAt,
      minted: minted ?? this.minted,
      tokenId: tokenId is int? ? tokenId : this.tokenId,
      edition: edition is int? ? edition : this.edition,
      stat: stat is String? ? stat : this.stat,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
      showPaw: showPaw ?? this.showPaw,
      isTest: isTest is bool? ? isTest : this.isTest,
      txUrl: txUrl is String? ? txUrl : this.txUrl,
      metadataUrl: metadataUrl is String? ? metadataUrl : this.metadataUrl,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
    );
  }
}
