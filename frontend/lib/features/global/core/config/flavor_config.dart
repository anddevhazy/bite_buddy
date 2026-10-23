import 'package:bite_buddy/features/global/core/config/environment.dart';

class FlavorConfig {
  // Which environment the app is running in
  final Environment environment;

  // The Serverpod server URL for this environment (must end with a slash)
  final String serverUrl;

  static late FlavorConfig _instance;

  FlavorConfig._internal({required this.environment, required this.serverUrl});

  // Called once at startup from main.dart / main_prod.dart
  static void init({
    required Environment environment,
    required String serverUrl,
  }) {
    _instance = FlavorConfig._internal(
      environment: environment,
      serverUrl: serverUrl,
    );
  }

  static FlavorConfig get instance => _instance;

  bool get isDev => environment.isDev;
  bool get isProd => environment.isProd;
}
