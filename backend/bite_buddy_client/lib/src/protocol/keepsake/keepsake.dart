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

/// A minted keepsake NFT. Its id is the token id on the contract.
abstract class Keepsake
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Keepsake._({
    this.id,
    required this.ownerId,
    required this.key,
    required this.editionGroup,
    required this.edition,
    required this.title,
    required this.emoji,
    required this.petName,
    required this.speciesKey,
    this.portraitId,
    bool? showPaw,
    this.stat,
    required this.earnedAt,
    required this.walletAddress,
    this.txHash,
    required this.chainId,
    required this.mintedAt,
  }) : showPaw = showPaw ?? false;

  factory Keepsake({
    int? id,
    required _isc.UuidValue ownerId,
    required String key,
    required String editionGroup,
    required int edition,
    required String title,
    required String emoji,
    required String petName,
    required String speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    required DateTime earnedAt,
    required String walletAddress,
    String? txHash,
    required int chainId,
    required DateTime mintedAt,
  }) = _KeepsakeImpl;

  factory Keepsake.fromJson(Map<String, dynamic> jsonSerialization) {
    return Keepsake(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      key: jsonSerialization['key'] as String,
      editionGroup: jsonSerialization['editionGroup'] as String,
      edition: jsonSerialization['edition'] as int,
      title: jsonSerialization['title'] as String,
      emoji: jsonSerialization['emoji'] as String,
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
      showPaw: jsonSerialization['showPaw'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['showPaw']),
      stat: jsonSerialization['stat'] as String?,
      earnedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['earnedAt'],
      ),
      walletAddress: jsonSerialization['walletAddress'] as String,
      txHash: jsonSerialization['txHash'] as String?,
      chainId: jsonSerialization['chainId'] as int,
      mintedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['mintedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue ownerId;

  /// What it's for: certificate, streak_30, level_10, meals_100, trophy_...
  String key;

  /// Keepsakes of the same kind are numbered in the order they're minted,
  /// e.g. every 30-day streak shares one count.
  String editionGroup;

  int edition;

  String title;

  String emoji;

  String petName;

  String speciesKey;

  /// The pet's photo at mint time, only if the owner allowed it.
  int? portraitId;

  /// A paw instead of a picture: the buddy is the owner's own pet and they
  /// chose not to show its photo.
  bool showPaw;

  /// One line about that moment, e.g. "Avg meal score 82 that month".
  String? stat;

  DateTime earnedAt;

  String walletAddress;

  /// Null while the mint is being sent.
  String? txHash;

  /// 8453 for Base, 84532 for Base Sepolia, 0 for test mode.
  int chainId;

  DateTime mintedAt;

  /// Returns a shallow copy of this [Keepsake]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Keepsake copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    String? key,
    String? editionGroup,
    int? edition,
    String? title,
    String? emoji,
    String? petName,
    String? speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    DateTime? earnedAt,
    String? walletAddress,
    String? txHash,
    int? chainId,
    DateTime? mintedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Keepsake',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'key': key,
      'editionGroup': editionGroup,
      'edition': edition,
      'title': title,
      'emoji': emoji,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (stat != null) 'stat': stat,
      'earnedAt': earnedAt.toJson(),
      'walletAddress': walletAddress,
      if (txHash != null) 'txHash': txHash,
      'chainId': chainId,
      'mintedAt': mintedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Keepsake',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'key': key,
      'editionGroup': editionGroup,
      'edition': edition,
      'title': title,
      'emoji': emoji,
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'showPaw': showPaw,
      if (stat != null) 'stat': stat,
      'earnedAt': earnedAt.toJson(),
      'walletAddress': walletAddress,
      if (txHash != null) 'txHash': txHash,
      'chainId': chainId,
      'mintedAt': mintedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KeepsakeImpl extends Keepsake {
  _KeepsakeImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required String key,
    required String editionGroup,
    required int edition,
    required String title,
    required String emoji,
    required String petName,
    required String speciesKey,
    int? portraitId,
    bool? showPaw,
    String? stat,
    required DateTime earnedAt,
    required String walletAddress,
    String? txHash,
    required int chainId,
    required DateTime mintedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         key: key,
         editionGroup: editionGroup,
         edition: edition,
         title: title,
         emoji: emoji,
         petName: petName,
         speciesKey: speciesKey,
         portraitId: portraitId,
         showPaw: showPaw,
         stat: stat,
         earnedAt: earnedAt,
         walletAddress: walletAddress,
         txHash: txHash,
         chainId: chainId,
         mintedAt: mintedAt,
       );

  /// Returns a shallow copy of this [Keepsake]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Keepsake copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    String? key,
    String? editionGroup,
    int? edition,
    String? title,
    String? emoji,
    String? petName,
    String? speciesKey,
    Object? portraitId = _Undefined,
    bool? showPaw,
    Object? stat = _Undefined,
    DateTime? earnedAt,
    String? walletAddress,
    Object? txHash = _Undefined,
    int? chainId,
    DateTime? mintedAt,
  }) {
    return Keepsake(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      key: key ?? this.key,
      editionGroup: editionGroup ?? this.editionGroup,
      edition: edition ?? this.edition,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
      showPaw: showPaw ?? this.showPaw,
      stat: stat is String? ? stat : this.stat,
      earnedAt: earnedAt ?? this.earnedAt,
      walletAddress: walletAddress ?? this.walletAddress,
      txHash: txHash is String? ? txHash : this.txHash,
      chainId: chainId ?? this.chainId,
      mintedAt: mintedAt ?? this.mintedAt,
    );
  }
}
