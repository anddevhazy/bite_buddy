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
import 'package:bite_buddy_client/src/protocol/protocol.dart' as _i7z1njky;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../memory/feeding_day.dart' as _i7jl7ahx;
import '../memory/level_point.dart' as _ivyv7mhu;
import '../memory/memory_entry.dart' as _iiz706n9;
import '../memory/nutrient_balance.dart' as _i6w57h76;
import '../memory/progress_snapshot.dart' as _iqucwsux;
import '../memory/week_progress.dart' as _infs1p8k;

/// Everything on the memory book screen: how far the buddy has come.
abstract class MemoryBook
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemoryBook._({
    required this.petName,
    required this.speciesKey,
    this.portraitId,
    required this.adoptedAt,
    required this.daysTogether,
    required this.dayOne,
    required this.today,
    required this.memories,
    required this.feedingDays,
    required this.weeks,
    required this.levels,
    this.firstWeekNutrients,
    this.lastWeekNutrients,
  });

  factory MemoryBook({
    required String petName,
    required String speciesKey,
    int? portraitId,
    required DateTime adoptedAt,
    required int daysTogether,
    required _iqucwsux.ProgressSnapshot dayOne,
    required _iqucwsux.ProgressSnapshot today,
    required List<_iiz706n9.MemoryEntry> memories,
    required List<_i7jl7ahx.FeedingDay> feedingDays,
    required List<_infs1p8k.WeekProgress> weeks,
    required List<_ivyv7mhu.LevelPoint> levels,
    _i6w57h76.NutrientBalance? firstWeekNutrients,
    _i6w57h76.NutrientBalance? lastWeekNutrients,
  }) = _MemoryBookImpl;

  factory MemoryBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemoryBook(
      petName: jsonSerialization['petName'] as String,
      speciesKey: jsonSerialization['speciesKey'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
      adoptedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['adoptedAt'],
      ),
      daysTogether: jsonSerialization['daysTogether'] as int,
      dayOne: _i7z1njky.Protocol().deserialize<_iqucwsux.ProgressSnapshot>(
        jsonSerialization['dayOne'],
      ),
      today: _i7z1njky.Protocol().deserialize<_iqucwsux.ProgressSnapshot>(
        jsonSerialization['today'],
      ),
      memories: _i7z1njky.Protocol().deserialize<List<_iiz706n9.MemoryEntry>>(
        jsonSerialization['memories'],
      ),
      feedingDays: _i7z1njky.Protocol().deserialize<List<_i7jl7ahx.FeedingDay>>(
        jsonSerialization['feedingDays'],
      ),
      weeks: _i7z1njky.Protocol().deserialize<List<_infs1p8k.WeekProgress>>(
        jsonSerialization['weeks'],
      ),
      levels: _i7z1njky.Protocol().deserialize<List<_ivyv7mhu.LevelPoint>>(
        jsonSerialization['levels'],
      ),
      firstWeekNutrients: jsonSerialization['firstWeekNutrients'] == null
          ? null
          : _i7z1njky.Protocol().deserialize<_i6w57h76.NutrientBalance>(
              jsonSerialization['firstWeekNutrients'],
            ),
      lastWeekNutrients: jsonSerialization['lastWeekNutrients'] == null
          ? null
          : _i7z1njky.Protocol().deserialize<_i6w57h76.NutrientBalance>(
              jsonSerialization['lastWeekNutrients'],
            ),
    );
  }

  String petName;

  String speciesKey;

  int? portraitId;

  DateTime adoptedAt;

  /// 1 on the day of adoption.
  int daysTogether;

  _iqucwsux.ProgressSnapshot dayOne;

  _iqucwsux.ProgressSnapshot today;

  /// Oldest first.
  List<_iiz706n9.MemoryEntry> memories;

  /// The last 26 weeks, oldest first, only days since adoption.
  List<_i7jl7ahx.FeedingDay> feedingDays;

  /// Weeks since adoption (up to the last 26), oldest first.
  List<_infs1p8k.WeekProgress> weeks;

  /// Starts with level 1 at adoption.
  List<_ivyv7mhu.LevelPoint> levels;

  /// The first and the last 7 days of meals; null until the buddy is 14
  /// days old, so the two never overlap.
  _i6w57h76.NutrientBalance? firstWeekNutrients;

  _i6w57h76.NutrientBalance? lastWeekNutrients;

  /// Returns a shallow copy of this [MemoryBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemoryBook copyWith({
    String? petName,
    String? speciesKey,
    int? portraitId,
    DateTime? adoptedAt,
    int? daysTogether,
    _iqucwsux.ProgressSnapshot? dayOne,
    _iqucwsux.ProgressSnapshot? today,
    List<_iiz706n9.MemoryEntry>? memories,
    List<_i7jl7ahx.FeedingDay>? feedingDays,
    List<_infs1p8k.WeekProgress>? weeks,
    List<_ivyv7mhu.LevelPoint>? levels,
    _i6w57h76.NutrientBalance? firstWeekNutrients,
    _i6w57h76.NutrientBalance? lastWeekNutrients,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemoryBook',
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'adoptedAt': adoptedAt.toJson(),
      'daysTogether': daysTogether,
      'dayOne': dayOne.toJson(),
      'today': today.toJson(),
      'memories': memories.toJson(valueToJson: (v) => v.toJson()),
      'feedingDays': feedingDays.toJson(valueToJson: (v) => v.toJson()),
      'weeks': weeks.toJson(valueToJson: (v) => v.toJson()),
      'levels': levels.toJson(valueToJson: (v) => v.toJson()),
      if (firstWeekNutrients != null)
        'firstWeekNutrients': firstWeekNutrients?.toJson(),
      if (lastWeekNutrients != null)
        'lastWeekNutrients': lastWeekNutrients?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemoryBook',
      'petName': petName,
      'speciesKey': speciesKey,
      if (portraitId != null) 'portraitId': portraitId,
      'adoptedAt': adoptedAt.toJson(),
      'daysTogether': daysTogether,
      'dayOne': dayOne.toJsonForProtocol(),
      'today': today.toJsonForProtocol(),
      'memories': memories.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'feedingDays': feedingDays.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'weeks': weeks.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'levels': levels.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (firstWeekNutrients != null)
        'firstWeekNutrients': firstWeekNutrients?.toJsonForProtocol(),
      if (lastWeekNutrients != null)
        'lastWeekNutrients': lastWeekNutrients?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryBookImpl extends MemoryBook {
  _MemoryBookImpl({
    required String petName,
    required String speciesKey,
    int? portraitId,
    required DateTime adoptedAt,
    required int daysTogether,
    required _iqucwsux.ProgressSnapshot dayOne,
    required _iqucwsux.ProgressSnapshot today,
    required List<_iiz706n9.MemoryEntry> memories,
    required List<_i7jl7ahx.FeedingDay> feedingDays,
    required List<_infs1p8k.WeekProgress> weeks,
    required List<_ivyv7mhu.LevelPoint> levels,
    _i6w57h76.NutrientBalance? firstWeekNutrients,
    _i6w57h76.NutrientBalance? lastWeekNutrients,
  }) : super._(
         petName: petName,
         speciesKey: speciesKey,
         portraitId: portraitId,
         adoptedAt: adoptedAt,
         daysTogether: daysTogether,
         dayOne: dayOne,
         today: today,
         memories: memories,
         feedingDays: feedingDays,
         weeks: weeks,
         levels: levels,
         firstWeekNutrients: firstWeekNutrients,
         lastWeekNutrients: lastWeekNutrients,
       );

  /// Returns a shallow copy of this [MemoryBook]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemoryBook copyWith({
    String? petName,
    String? speciesKey,
    Object? portraitId = _Undefined,
    DateTime? adoptedAt,
    int? daysTogether,
    _iqucwsux.ProgressSnapshot? dayOne,
    _iqucwsux.ProgressSnapshot? today,
    List<_iiz706n9.MemoryEntry>? memories,
    List<_i7jl7ahx.FeedingDay>? feedingDays,
    List<_infs1p8k.WeekProgress>? weeks,
    List<_ivyv7mhu.LevelPoint>? levels,
    Object? firstWeekNutrients = _Undefined,
    Object? lastWeekNutrients = _Undefined,
  }) {
    return MemoryBook(
      petName: petName ?? this.petName,
      speciesKey: speciesKey ?? this.speciesKey,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
      adoptedAt: adoptedAt ?? this.adoptedAt,
      daysTogether: daysTogether ?? this.daysTogether,
      dayOne: dayOne ?? this.dayOne.copyWith(),
      today: today ?? this.today.copyWith(),
      memories: memories ?? this.memories.map((e0) => e0.copyWith()).toList(),
      feedingDays:
          feedingDays ?? this.feedingDays.map((e0) => e0.copyWith()).toList(),
      weeks: weeks ?? this.weeks.map((e0) => e0.copyWith()).toList(),
      levels: levels ?? this.levels.map((e0) => e0.copyWith()).toList(),
      firstWeekNutrients: firstWeekNutrients is _i6w57h76.NutrientBalance?
          ? firstWeekNutrients
          : this.firstWeekNutrients?.copyWith(),
      lastWeekNutrients: lastWeekNutrients is _i6w57h76.NutrientBalance?
          ? lastWeekNutrients
          : this.lastWeekNutrients?.copyWith(),
    );
  }
}
