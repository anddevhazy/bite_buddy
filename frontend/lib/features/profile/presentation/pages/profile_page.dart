import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = context.watch<PetCubit>().pet;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const SizedBox(height: AppSpacing.md),
          const PageHeader(title: 'Profile', subtitle: 'You and your buddy'),
          const SizedBox(height: AppSpacing.xl),
          if (pet != null) ...[
            Text('Buddy Stats', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.md),
            GlassCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Row(
                    children: [
                      GameArt(AppImages.pet(pet.speciesKey), size: 64),
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pet.name, style: AppTextStyles.h2),
                          Text(
                            'Level ${pet.level} · Pet #${pet.id}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (final (label, value) in [
                    ('🍽️ Meals eaten', '${pet.mealsEaten}'),
                    ('🔥 Current streak', _days(pet.streak)),
                    ('⭐ Best streak', _days(pet.bestStreak)),
                    ('🏆 Battles won', '${pet.wins}'),
                    ('💫 Battles lost', '${pet.losses}'),
                    ('💰 Coins', '${pet.coins}'),
                  ])
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xs,
                      ),
                      child: Row(
                        children: [
                          Text(label, style: AppTextStyles.bodyLarge),
                          const Spacer(),
                          Text(value, style: AppTextStyles.h3),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
          Text('Wallet', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.md),
          GlassCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                const Text('🔐', style: TextStyle(fontSize: 32)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Coming soon: your buddy as an NFT on Base, '
                    'with no seed phrase to manage.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GameButton(
            label: 'How to play',
            onPressed: () => context.pushNamed(Routes.guideName),
          ),
          const SizedBox(height: AppSpacing.md),
          GameButton(
            label: 'Sign out',
            style: GameButtonStyle.danger,
            onPressed: () => context.read<AuthCubit>().signOut(),
          ),
        ],
      ),
    );
  }
}

String _days(int n) => n == 1 ? '1 day' : '$n days';
