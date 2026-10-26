import 'package:bite_buddy/features/auth/auth_injection_container.dart';
import 'package:bite_buddy/features/battle/battle_injection_container.dart';
import 'package:bite_buddy/features/collection/collection_injection_container.dart';
import 'package:bite_buddy/features/global/core/config/flavor_config.dart';
import 'package:bite_buddy/features/pet/pet_injection_container.dart';
import 'package:bite_buddy/features/scanner/scanner_injection_container.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

Future<void> init() async {
  // The generated Serverpod client. It plays the part Dio + ApiClient play in
  // Attend: every remote data source talks to the server through it. The
  // auth session manager stores the tokens securely and refreshes them.
  final client =
      Client(
          FlavorConfig.instance.serverUrl,
          // A food scan uploads a photo and waits for the AI, which can take
          // well over the 20 s default on a slow connection
          connectionTimeout: const Duration(seconds: 90),
        )
        ..connectivityMonitor = FlutterConnectivityMonitor()
        ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();
  sl.registerLazySingleton<Client>(() => client);

  await authInjectionContainer();
  await petInjectionContainer();
  await scannerInjectionContainer();
  await collectionInjectionContainer();
  await battleInjectionContainer();
}
