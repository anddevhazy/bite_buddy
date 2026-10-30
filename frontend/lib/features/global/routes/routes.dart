import 'package:bite_buddy/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bite_buddy/features/battle/presentation/pages/battle_tab_page.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/presentation/pages/fight_page.dart';
import 'package:bite_buddy/features/collection/presentation/pages/collection_page.dart';
import 'package:bite_buddy/features/global/components/main_shell.dart';
import 'package:bite_buddy/features/global/pages/splash_screen.dart';
import 'package:bite_buddy/features/guide/presentation/pages/guide_page.dart';
import 'package:bite_buddy/features/league/presentation/pages/duel_page.dart';
import 'package:bite_buddy/features/league/presentation/pages/league_detail_page.dart';
import 'package:bite_buddy/features/pet/presentation/pages/choose_buddy_page.dart';
import 'package:bite_buddy/features/pet/presentation/pages/pet_home_page.dart';
import 'package:bite_buddy/features/profile/presentation/pages/profile_page.dart';
import 'package:bite_buddy/features/scanner/presentation/pages/food_scanner_page.dart';
import 'package:bite_buddy/features/scanner/presentation/pages/scan_result_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splashPath = '/splash';
  static const String splashName = 'splash';

  static const String signInPath = '/signIn';
  static const String signInName = 'signIn';

  static const String chooseBuddyPath = '/chooseBuddy';
  static const String chooseBuddyName = 'chooseBuddy';

  // Bottom-nav tabs
  static const String petHomePath = '/pet';
  static const String petHomeName = 'petHome';

  static const String collectionPath = '/collection';
  static const String collectionName = 'collection';

  static const String scannerPath = '/scan';
  static const String scannerName = 'scanner';

  static const String battleArenaPath = '/battle';
  static const String battleArenaName = 'battleArena';

  static const String profilePath = '/profile';
  static const String profileName = 'profile';

  // Full-screen pages pushed over the tabs
  static const String scanResultPath = '/scanResult';
  static const String scanResultName = 'scanResult';

  // A real-time arena fight; pass its ArenaRunConfigEntity as `extra`
  static const String fightPath = '/fight';
  static const String fightName = 'fight';

  static const String guidePath = '/guide';
  static const String guideName = 'guide';

  static const String leaguePath = '/league/:id';
  static const String leagueName = 'league';

  static const String duelPath = '/duel/:id';
  static const String duelName = 'duel';

  static void goToSignIn() {
    if (router.state.matchedLocation != signInPath) {
      router.goNamed(signInName);
    }
  }

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: splashPath,
    routes: [
      GoRoute(
        path: splashPath,
        name: splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: signInPath,
        name: signInName,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: chooseBuddyPath,
        name: chooseBuddyName,
        builder: (context, state) => const ChooseBuddyPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: petHomePath,
                name: petHomeName,
                builder: (context, state) => const PetHomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: collectionPath,
                name: collectionName,
                builder: (context, state) => const CollectionPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: scannerPath,
                name: scannerName,
                builder: (context, state) => const FoodScannerPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: battleArenaPath,
                name: battleArenaName,
                builder: (context, state) => const BattleTabPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profilePath,
                name: profileName,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: scanResultPath,
        name: scanResultName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ScanResultPage(),
      ),
      GoRoute(
        path: leaguePath,
        name: leagueName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            LeagueDetailPage(leagueId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: duelPath,
        name: duelName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            DuelPage(duelId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: guidePath,
        name: guideName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const GuidePage(),
      ),
      GoRoute(
        path: fightPath,
        name: fightName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            FightPage(config: state.extra! as ArenaRunConfigEntity),
      ),
    ],
  );
}
