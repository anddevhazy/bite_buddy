import 'package:bite_buddy/features/activity/activity_injection_container.dart';
import 'package:bite_buddy/features/auth/auth_injection_container.dart';
import 'package:bite_buddy/features/battle/battle_injection_container.dart';
import 'package:bite_buddy/features/collection/collection_injection_container.dart';
import 'package:bite_buddy/features/global/core/config/flavor_config.dart';
import 'package:bite_buddy/features/insights/insights_injection_container.dart';
import 'package:bite_buddy/features/league/league_injection_container.dart';
import 'package:bite_buddy/features/memory/memory_injection_container.dart';
import 'package:bite_buddy/features/pet/pet_injection_container.dart';
import 'package:bite_buddy/features/portrait/portrait_injection_container.dart';
import 'package:bite_buddy/features/scanner/scanner_injection_container.dart';
import 'package:bite_buddy/features/streak/streak_injection_container.dart';
import 'package:bite_buddy/features/global/services/pet_widget_service.dart';
import 'package:bite_buddy/features/global/services/portrait_cache.dart';
import 'package:bite_buddy/features/global/services/sound_service.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

Future<void> init() async {
  // Game sounds (and the mute setting, kept in secure storage)
  final sounds = SoundService(const FlutterSecureStorage());
  await sounds.init();
  sl.registerSingleton<SoundService>(sounds);

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

  // Photos of users' own pets, shared by every screen that shows a buddy
  final portraits = PortraitCache(client: client);
  sl.registerSingleton<PortraitCache>(portraits);

  // The home-screen widget showing the buddy's mood
  final widget = PetWidgetService(portraits: portraits);
  await widget.init();
  sl.registerSingleton<PetWidgetService>(widget);

  await authInjectionContainer();
  await petInjectionContainer();
  await scannerInjectionContainer();
  await collectionInjectionContainer();
  await battleInjectionContainer();
  await insightsInjectionContainer();
  await leagueInjectionContainer();
  await streakInjectionContainer();
  await activityInjectionContainer();
  await portraitInjectionContainer();
  await memoryInjectionContainer();
}
