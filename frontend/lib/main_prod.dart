import 'package:bite_buddy/features/global/core/config/environment.dart';
import 'package:bite_buddy/features/global/core/config/flavor_config.dart';
import 'package:bite_buddy/main_common.dart';

// The live server on Serverpod Cloud
void main() async {
  FlavorConfig.init(
    environment: Environment.prod,
    serverUrl: const String.fromEnvironment(
      'SERVER_URL',
      defaultValue: 'https://bite-buddy.api.serverpod.space/',
    ),
  );

  await mainCommon();
}
