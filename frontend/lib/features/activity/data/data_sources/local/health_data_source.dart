// Reads steps and sleep from the phone's health app
abstract class HealthDataSource {
  Future<bool> isConnected();

  // Throws HealthUnavailableException if the health app is missing, and
  // returns false if the user didn't allow access
  Future<bool> connect();

  Future<void> disconnect();

  // Steps since midnight, and sleep in the night that ended this morning
  Future<({int steps, int sleepMinutes})> readToday();
}

class HealthUnavailableException implements Exception {
  final String message;

  const HealthUnavailableException(this.message);

  @override
  String toString() => message;
}
