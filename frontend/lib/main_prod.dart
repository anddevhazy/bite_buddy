import 'package:bite_buddy/features/global/core/config/environment.dart';
import 'package:bite_buddy/features/global/core/config/flavor_config.dart';
import 'package:bite_buddy/main_common.dart';

// TODO: point this at the deployed server once it's live
void main() async {
  FlavorConfig.init(
    environment: Environment.prod,
    serverUrl: const String.fromEnvironment(
      'SERVER_URL',
      defaultValue: 'https://api.bitebuddy.example/',
    ),
  );

  await mainCommon();
}
