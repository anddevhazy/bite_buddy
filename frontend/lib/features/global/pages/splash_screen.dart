import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Decides where to go on launch: sign in, pick a buddy, or straight to the pet
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthCubit>()..start();

    // start() emits right away, before the listeners below are attached, so
    // act on the current state once the first frame is up
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (auth.state is Authenticated) {
        context.read<PetCubit>().loadPet();
      } else {
        context.goNamed(Routes.signInName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is Unauthenticated) context.goNamed(Routes.signInName);
            },
          ),
          BlocListener<PetCubit, PetState>(
            listener: (context, state) {
              if (state is PetLoaded) context.goNamed(Routes.petHomeName);
              if (state is NoPet) context.goNamed(Routes.chooseBuddyName);
            },
          ),
        ],
        child: ForestBackground(
          child: BlocBuilder<PetCubit, PetState>(
            builder: (context, state) {
              if (state is PetFailed) {
                return AppErrorView(
                  message: state.message,
                  onRetry: () => context.read<PetCubit>().loadPet(),
                );
              }
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🍱', style: TextStyle(fontSize: 88)),
                    const SizedBox(height: AppSpacing.lg),
                    Text('Bite Buddy', style: AppTextStyles.h1),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Eat well. Raise a champion.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const CircularProgressIndicator(color: AppColors.primary),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
