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
import 'arena_run_status.dart' as _ic5j8p21;

/// One real-time fight against a computer opponent. The fight itself runs on
/// the phone; the server fixes the fighters when it starts and checks the
/// reported result is possible before paying out.
abstract class ArenaRun
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArenaRun._({
    this.id,
    required this.ownerId,
    required this.petId,
    required this.opponentKey,
    required this.petMaxHp,
    required this.petAttack,
    required this.petDefense,
    required this.startedAt,
    required this.status,
    this.finishedAt,
    this.durationMs,
    this.damageDealt,
    this.damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) : verified = verified ?? true,
       coinsEarned = coinsEarned ?? 0,
       xpEarned = xpEarned ?? 0,
       energyChange = energyChange ?? 0;

  factory ArenaRun({
    int? id,
    required _isc.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required DateTime startedAt,
    required _ic5j8p21.ArenaRunStatus status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) = _ArenaRunImpl;

  factory ArenaRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRun(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      petId: jsonSerialization['petId'] as int,
      opponentKey: jsonSerialization['opponentKey'] as String,
      petMaxHp: jsonSerialization['petMaxHp'] as int,
      petAttack: jsonSerialization['petAttack'] as int,
      petDefense: jsonSerialization['petDefense'] as int,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      status: _ic5j8p21.ArenaRunStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['finishedAt'],
            ),
      durationMs: jsonSerialization['durationMs'] as int?,
      damageDealt: jsonSerialization['damageDealt'] as int?,
      damageTaken: jsonSerialization['damageTaken'] as int?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      coinsEarned: jsonSerialization['coinsEarned'] as int?,
      xpEarned: jsonSerialization['xpEarned'] as int?,
      energyChange: jsonSerialization['energyChange'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue ownerId;

  int petId;

  String opponentKey;

  int petMaxHp;

  int petAttack;

  int petDefense;

  DateTime startedAt;

  _ic5j8p21.ArenaRunStatus status;

  DateTime? finishedAt;

  int? durationMs;

  int? damageDealt;

  int? damageTaken;

  /// False when a reported win failed the plausibility check (counted as a
  /// loss).
  bool verified;

  int coinsEarned;

  int xpEarned;

  int energyChange;

  /// Returns a shallow copy of this [ArenaRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArenaRun copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    DateTime? startedAt,
    _ic5j8p21.ArenaRunStatus? status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRun',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'startedAt': startedAt.toJson(),
      'status': status.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      if (durationMs != null) 'durationMs': durationMs,
      if (damageDealt != null) 'damageDealt': damageDealt,
      if (damageTaken != null) 'damageTaken': damageTaken,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRun',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'petId': petId,
      'opponentKey': opponentKey,
      'petMaxHp': petMaxHp,
      'petAttack': petAttack,
      'petDefense': petDefense,
      'startedAt': startedAt.toJson(),
      'status': status.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
      if (durationMs != null) 'durationMs': durationMs,
      if (damageDealt != null) 'damageDealt': damageDealt,
      if (damageTaken != null) 'damageTaken': damageTaken,
      'verified': verified,
      'coinsEarned': coinsEarned,
      'xpEarned': xpEarned,
      'energyChange': energyChange,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArenaRunImpl extends ArenaRun {
  _ArenaRunImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required int petId,
    required String opponentKey,
    required int petMaxHp,
    required int petAttack,
    required int petDefense,
    required DateTime startedAt,
    required _ic5j8p21.ArenaRunStatus status,
    DateTime? finishedAt,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) : super._(
         id: id,
         ownerId: ownerId,
         petId: petId,
         opponentKey: opponentKey,
         petMaxHp: petMaxHp,
         petAttack: petAttack,
         petDefense: petDefense,
         startedAt: startedAt,
         status: status,
         finishedAt: finishedAt,
         durationMs: durationMs,
         damageDealt: damageDealt,
         damageTaken: damageTaken,
         verified: verified,
         coinsEarned: coinsEarned,
         xpEarned: xpEarned,
         energyChange: energyChange,
       );

  /// Returns a shallow copy of this [ArenaRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArenaRun copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    int? petId,
    String? opponentKey,
    int? petMaxHp,
    int? petAttack,
    int? petDefense,
    DateTime? startedAt,
    _ic5j8p21.ArenaRunStatus? status,
    Object? finishedAt = _Undefined,
    Object? durationMs = _Undefined,
    Object? damageDealt = _Undefined,
    Object? damageTaken = _Undefined,
    bool? verified,
    int? coinsEarned,
    int? xpEarned,
    int? energyChange,
  }) {
    return ArenaRun(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      petId: petId ?? this.petId,
      opponentKey: opponentKey ?? this.opponentKey,
      petMaxHp: petMaxHp ?? this.petMaxHp,
      petAttack: petAttack ?? this.petAttack,
      petDefense: petDefense ?? this.petDefense,
      startedAt: startedAt ?? this.startedAt,
      status: status ?? this.status,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
      durationMs: durationMs is int? ? durationMs : this.durationMs,
      damageDealt: damageDealt is int? ? damageDealt : this.damageDealt,
      damageTaken: damageTaken is int? ? damageTaken : this.damageTaken,
      verified: verified ?? this.verified,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      energyChange: energyChange ?? this.energyChange,
    );
  }
}
