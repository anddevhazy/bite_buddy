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

/// One season week (Monday UTC) of progress.
abstract class WeekProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WeekProgress._({
    required this.weekStart,
    required this.meals,
    this.averageScore,
    required this.wins,
  });

  factory WeekProgress({
    required DateTime weekStart,
    required int meals,
    int? averageScore,
    required int wins,
  }) = _WeekProgressImpl;

  factory WeekProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeekProgress(
      weekStart: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['weekStart'],
      ),
      meals: jsonSerialization['meals'] as int,
      averageScore: jsonSerialization['averageScore'] as int?,
      wins: jsonSerialization['wins'] as int,
    );
  }

  DateTime weekStart;

  int meals;

  /// Average health score of the week's meals, null with no meals.
  int? averageScore;

  /// Arena and friend battle wins.
  int wins;

  /// Returns a shallow copy of this [WeekProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WeekProgress copyWith({
    DateTime? weekStart,
    int? meals,
    int? averageScore,
    int? wins,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeekProgress',
      'weekStart': weekStart.toJson(),
      'meals': meals,
      if (averageScore != null) 'averageScore': averageScore,
      'wins': wins,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WeekProgress',
      'weekStart': weekStart.toJson(),
      'meals': meals,
      if (averageScore != null) 'averageScore': averageScore,
      'wins': wins,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeekProgressImpl extends WeekProgress {
  _WeekProgressImpl({
    required DateTime weekStart,
    required int meals,
    int? averageScore,
    required int wins,
  }) : super._(
         weekStart: weekStart,
         meals: meals,
         averageScore: averageScore,
         wins: wins,
       );

  /// Returns a shallow copy of this [WeekProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WeekProgress copyWith({
    DateTime? weekStart,
    int? meals,
    Object? averageScore = _Undefined,
    int? wins,
  }) {
    return WeekProgress(
      weekStart: weekStart ?? this.weekStart,
      meals: meals ?? this.meals,
      averageScore: averageScore is int? ? averageScore : this.averageScore,
      wins: wins ?? this.wins,
    );
  }
}
