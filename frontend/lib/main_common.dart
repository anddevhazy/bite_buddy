import 'package:bite_buddy/features/activity/presentation/bloc/activity_cubit.dart';
import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:bite_buddy/features/global/components/splash_art.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/global/services/pet_widget_service.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/features/league/presentation/bloc/leagues_cubit.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/scanner/presentation/bloc/scanner_cubit.dart';
import 'package:bite_buddy/features/streak/presentation/bloc/streaks_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main_injection_container.dart' as di;

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Draw the splash art straight away. Set-up (restoring the sign-in and so
  // on) happens behind it; the app then takes over showing the same picture.
  runApp(const BootSplash());

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<PetCubit>()),
        BlocProvider(create: (context) => sl<ScannerCubit>()),
        BlocProvider(create: (context) => sl<CollectionCubit>()),
        BlocProvider(create: (context) => sl<BattleCubit>()),
        BlocProvider(create: (context) => sl<InsightsCubit>()),
        BlocProvider(create: (context) => sl<LeaguesCubit>()),
        BlocProvider(create: (context) => sl<StreaksCubit>()),
        BlocProvider(create: (context) => sl<ActivityCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          // Signing out, or the session expiring, sends the user back to
          // sign in
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                previous is Authenticated && current is Unauthenticated,
            listener: (context, state) {
              context.read<PetCubit>().reset();
              context.read<InsightsCubit>().reset();
              context.read<LeaguesCubit>().reset();
              context.read<StreaksCubit>().reset();
              context.read<ActivityCubit>().reset();
              sl<PetWidgetService>().clear();
              Routes.goToSignIn();
            },
          ),
          // Every time the pet loads or changes, refresh the home widget
          BlocListener<PetCubit, PetState>(
            listenWhen: (previous, current) => current is PetLoaded,
            listener: (context, state) {
              if (state is PetLoaded) sl<PetWidgetService>().update(state.pet);
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Bite Buddy',
              debugShowCheckedModeBanner: false,
              routerConfig: Routes.router,
              theme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: AppTextStyles.body,
                scaffoldBackgroundColor: AppColors.background,
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  secondary: AppColors.accent,
                  surface: AppColors.card,
                ),
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
