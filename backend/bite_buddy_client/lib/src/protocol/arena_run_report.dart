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

/// What the phone reports when a real-time fight ends.
abstract class ArenaRunReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArenaRunReport._({
    required this.won,
    required this.durationMs,
    required this.damageDealt,
    required this.damageTaken,
    required this.hitsLanded,
  });

  factory ArenaRunReport({
    required bool won,
    required int durationMs,
    required int damageDealt,
    required int damageTaken,
    required int hitsLanded,
  }) = _ArenaRunReportImpl;

  factory ArenaRunReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArenaRunReport(
      won: _isc.BoolJsonExtension.fromJson(jsonSerialization['won']),
      durationMs: jsonSerialization['durationMs'] as int,
      damageDealt: jsonSerialization['damageDealt'] as int,
      damageTaken: jsonSerialization['damageTaken'] as int,
      hitsLanded: jsonSerialization['hitsLanded'] as int,
    );
  }

  bool won;

  int durationMs;

  int damageDealt;

  int damageTaken;

  int hitsLanded;

  /// Returns a shallow copy of this [ArenaRunReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArenaRunReport copyWith({
    bool? won,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    int? hitsLanded,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArenaRunReport',
      'won': won,
      'durationMs': durationMs,
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'hitsLanded': hitsLanded,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArenaRunReport',
      'won': won,
      'durationMs': durationMs,
      'damageDealt': damageDealt,
      'damageTaken': damageTaken,
      'hitsLanded': hitsLanded,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ArenaRunReportImpl extends ArenaRunReport {
  _ArenaRunReportImpl({
    required bool won,
    required int durationMs,
    required int damageDealt,
    required int damageTaken,
    required int hitsLanded,
  }) : super._(
         won: won,
         durationMs: durationMs,
         damageDealt: damageDealt,
         damageTaken: damageTaken,
         hitsLanded: hitsLanded,
       );

  /// Returns a shallow copy of this [ArenaRunReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArenaRunReport copyWith({
    bool? won,
    int? durationMs,
    int? damageDealt,
    int? damageTaken,
    int? hitsLanded,
  }) {
    return ArenaRunReport(
      won: won ?? this.won,
      durationMs: durationMs ?? this.durationMs,
      damageDealt: damageDealt ?? this.damageDealt,
      damageTaken: damageTaken ?? this.damageTaken,
      hitsLanded: hitsLanded ?? this.hitsLanded,
    );
  }
}
