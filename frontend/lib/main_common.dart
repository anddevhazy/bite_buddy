import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/scanner/presentation/bloc/scanner_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main_injection_container.dart' as di;

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      // Signing out, or the session expiring, sends the user back to sign in
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous is Authenticated && current is Unauthenticated,
        listener: (context, state) {
          context.read<PetCubit>().reset();
          context.read<InsightsCubit>().reset();
          Routes.goToSignIn();
        },
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
