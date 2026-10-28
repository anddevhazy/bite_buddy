import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/splash_art.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// The illustrated title screen. While it's up, works out where to go next:
// sign in, pick a buddy, or straight to the pet.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Long enough to read as an intro rather than a flicker
  static const _minimumDisplay = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final shownLongEnough = Future<void>.delayed(_minimumDisplay);
    final route = await _decideRoute();
    await shownLongEnough;
    if (mounted && route != null) context.goNamed(route);
  }

  // Null means loading the pet failed; the error view offers a retry
  Future<String?> _decideRoute() async {
    final auth = context.read<AuthCubit>()..start();
    if (auth.state is! Authenticated) return Routes.signInName;

    final pets = context.read<PetCubit>();
    await pets.loadPet();
    return switch (pets.state) {
      PetLoaded() => Routes.petHomeName,
      NoPet() => Routes.chooseBuddyName,
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PetCubit, PetState>(
        builder: (context, state) {
          if (state is PetFailed) {
            return ForestBackground(
              child: AppErrorView(message: state.message, onRetry: _start),
            );
          }
          return const SplashArt();
        },
      ),
    );
  }
}
