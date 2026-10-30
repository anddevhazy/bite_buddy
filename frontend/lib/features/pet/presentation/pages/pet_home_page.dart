import 'package:bite_buddy/features/activity/presentation/bloc/activity_cubit.dart';
import 'package:bite_buddy/features/activity/presentation/widgets/activity_card.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/stat_bar.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/features/insights/presentation/widgets/insights_card.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/pet/presentation/widgets/pet_avatar.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/streak/presentation/bloc/streaks_cubit.dart';
import 'package:bite_buddy/features/streak/presentation/widgets/shared_streaks_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PetHomePage extends StatelessWidget {
  const PetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PetCubit, PetState>(
        builder: (context, state) {
          if (state is PetFailed) {
            return AppErrorView(
              message: state.message,
              onRetry: () => context.read<PetCubit>().loadPet(),
            );
          }
          if (state is! PetLoaded) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => _refresh(context),
            child: _PetHome(pet: state.pet),
          );
        },
      ),
    );
  }
}

Future<void> _refresh(BuildContext context) async {
  await (
    context.read<PetCubit>().loadPet(silent: true),
    context.read<InsightsCubit>().load(),
    context.read<StreaksCubit>().load(),
    context.read<ActivityCubit>().load(),
  ).wait;
}

class _PetHome extends StatelessWidget {
  final PetEntity pet;

  const _PetHome({required this.pet});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Level ${pet.level}', style: AppTextStyles.h3),
                Text(
                  'XP: ${pet.xp}/${pet.xpToNextLevel}',
                  style: AppTextStyles.caption,
                ),
                Text('🪙 ${pet.coins}', style: AppTextStyles.caption),
                if (pet.streak > 0)
                  Text(
                    '🔥 ${pet.streak}-day streak',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            const InfoButton(
              topics: [
                GuideTopicId.health,
                GuideTopicId.energy,
                GuideTopicId.nutrition,
                GuideTopicId.levels,
                GuideTopicId.streak,
                GuideTopicId.coins,
              ],
            ),
            IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () => _refresh(context),
              icon: const Icon(Icons.refresh_rounded, color: AppColors.white),
            ),
          ],
        ),
        Center(
          child: PetAvatar(
            speciesKey: pet.speciesKey,
            portraitId: pet.portraitId,
            interactive: true,
          ),
        ),
        Center(child: Text(pet.name, style: AppTextStyles.h2)),
        Center(
          child: TextButton.icon(
            onPressed: () => context.pushNamed(Routes.myPetPhotoName),
            icon: const Icon(Icons.photo_camera_rounded, size: 18),
            label: Text(
              pet.portraitId == null ? 'Use my own pet' : 'Change picture',
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.glass.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _mood(pet),
              style: AppTextStyles.caption.copyWith(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        StatBar(
          emoji: '❤️',
          label: 'Health',
          value: pet.health,
          color: AppColors.health,
        ),
        const SizedBox(height: AppSpacing.md),
        StatBar(
          emoji: '⚡',
          label: 'Energy',
          value: pet.energy,
          color: AppColors.energy,
        ),
        const SizedBox(height: AppSpacing.md),
        StatBar(
          emoji: '🍽️',
          label: 'Nutrition',
          value: pet.nutrition,
          color: AppColors.nutrition,
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: GameButton(
                label: 'Scan Meal',
                style: GameButtonStyle.accent,
                onPressed: () => context.goNamed(Routes.scannerName),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: GameButton(
                label: 'Go to Battle',
                style: GameButtonStyle.battle,
                onPressed: () => context.goNamed(Routes.battleArenaName),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const SharedStreaksCard(),
        const SizedBox(height: AppSpacing.lg),
        const ActivityCard(),
        const SizedBox(height: AppSpacing.lg),
        const InsightsCard(),
      ],
    );
  }

  String _mood(PetEntity pet) {
    if (pet.mealsEaten == 0) return 'Hungry! Scan your first meal 🍽️';
    if (pet.health < 30) return 'Feeling sick... needs good food';
    if (pet.energy < 20) return 'Sleepy... a meal would help';
    if (pet.nutrition >= 75) return 'Thriving on your healthy eating!';
    return 'Tap your buddy to say hi!';
  }
}
