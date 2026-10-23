import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

// Email + password sign-in and sign-up, using Serverpod's ready-made widget.
// After signing in, the splash screen works out where to go next.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Center(child: Text('🍱', style: TextStyle(fontSize: 72))),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Welcome to Bite Buddy',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Sign in to meet your buddy',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Theme(
                  data: ThemeData.dark(useMaterial3: true).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: AppColors.primary,
                      surface: AppColors.card,
                    ),
                  ),
                  child: SignInWidget(
                    client: sl<Client>(),
                    onAuthenticated: () => context.goNamed(Routes.splashName),
                    onError:
                        (error) => AppToast.show(
                          context: context,
                          message: 'Sign-in failed. Please try again.',
                          type: ToastType.error,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
