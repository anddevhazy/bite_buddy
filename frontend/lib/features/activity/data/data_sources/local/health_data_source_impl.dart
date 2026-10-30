import 'dart:io';

import 'package:bite_buddy/features/activity/data/data_sources/local/health_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';

class HealthDataSourceImpl implements HealthDataSource {
  final Health health;
  final FlutterSecureStorage storage;

  HealthDataSourceImpl({required this.health, required this.storage});

  // Remembered locally: iPhones never tell apps whether read access was
  // granted, so there's nothing to ask the system later
  static const _connectedKey = 'health_connected';

  bool _configured = false;

  // Android trackers write whole sleep sessions; Apple Health has the time
  // actually asleep
  List<HealthDataType> get _types => [
    HealthDataType.STEPS,
    Platform.isAndroid
        ? HealthDataType.SLEEP_SESSION
        : HealthDataType.SLEEP_ASLEEP,
  ];

  Future<void> _configure() async {
    if (_configured) return;
    await health.configure();
    _configured = true;
  }

  @override
  Future<bool> isConnected() async =>
      await storage.read(key: _connectedKey) == 'yes';

  @override
  Future<bool> connect() async {
    await _configure();
    if (Platform.isAndroid && !await health.isHealthConnectAvailable()) {
      // Opens the Play Store page so they can install or update it
      await health.installHealthConnect();
      throw const HealthUnavailableException(
        'Install or update Health Connect from the Play Store, then try '
        'again.',
      );
    }
    final granted = await health.requestAuthorization(
      _types,
      permissions: [for (final _ in _types) HealthDataAccess.READ],
    );
    if (granted) await storage.write(key: _connectedKey, value: 'yes');
    return granted;
  }

  @override
  Future<void> disconnect() => storage.delete(key: _connectedKey);

  @override
  Future<({int steps, int sleepMinutes})> readToday() async {
    await _configure();
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final steps = await health.getTotalStepsInInterval(midnight, now) ?? 0;

    // Last night: anything from 6pm yesterday until now
    final points = await health.getHealthDataFromTypes(
      types: [_types[1]],
      startTime: midnight.subtract(const Duration(hours: 6)),
      endTime: now,
    );
    return (steps: steps, sleepMinutes: _mergedMinutes(points));
  }

  // Several apps can record the same night, so overlapping periods are
  // merged rather than added up
  int _mergedMinutes(List<HealthDataPoint> points) {
    final spans = [
      for (final p in points)
        if (p.dateTo.isAfter(p.dateFrom)) (p.dateFrom, p.dateTo),
    ]..sort((a, b) => a.$1.compareTo(b.$1));
    var total = Duration.zero;
    DateTime? start, end;
    for (final (from, to) in spans) {
      if (end == null || from.isAfter(end)) {
        if (start != null) total += end!.difference(start);
        start = from;
        end = to;
      } else if (to.isAfter(end)) {
        end = to;
      }
    }
    if (start != null) total += end!.difference(start);
    return total.inMinutes;
  }
}
