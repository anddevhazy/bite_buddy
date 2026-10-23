import 'package:bite_buddy/features/global/core/config/environment.dart';
import 'package:bite_buddy/features/global/core/config/flavor_config.dart';
import 'package:bite_buddy/main_common.dart';

// Local development. On a physical phone or the Android emulator, pass your
// computer's address: flutter run --dart-define=SERVER_URL=http://192.168.x.x:8080/
// (the Android emulator reaches your computer at http://10.0.2.2:8080/)
void main() async {
  FlavorConfig.init(
    environment: Environment.dev,
    serverUrl: const String.fromEnvironment(
      'SERVER_URL',
      defaultValue: 'http://localhost:8080/',
    ),
  );

  await mainCommon();
}
