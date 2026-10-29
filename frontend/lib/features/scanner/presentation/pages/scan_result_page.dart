import 'package:bite_buddy/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/pet/presentation/widgets/pet_avatar.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy/features/scanner/presentation/bloc/scanner_cubit.dart';
import 'package:bite_buddy/features/scanner/presentation/widgets/nutrient_tile.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key});

  void _close(BuildContext context) {
    context.read<ScannerCubit>().reset();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: BlocConsumer<ScannerCubit, ScannerState>(
            listener: (context, state) {
              if (state is MealFed) {
                context.read<PetCubit>().updatePet(state.result.pet);
                context.read<InsightsCubit>().load();
                context.read<CollectionCubit>().load();
              }
              if (state is ScannerFailed && state.meal != null) {
                AppToast.show(
                  context: context,
                  message: state.message,
                  type: ToastType.error,
                );
              }
            },
            builder: (context, state) {
              final body = switch (state) {
                Analyzing() => const _Analyzing(),
                MealRejected(:final reason) => _Rejected(
                  reason: reason,
                  onRetry: () => _close(context),
                ),
                MealFed(:final meal, :final result) => _Fed(
                  meal: meal,
                  result: result,
                  onDone: () {
                    context.read<ScannerCubit>().reset();
                    context.goNamed(Routes.petHomeName);
                  },
                ),
                MealAnalyzed(:final meal) => _Results(
                  meal: meal,
                  feeding: state is Feeding,
                ),
                ScannerFailed(meal: final meal?) => _Results(
                  meal: meal,
                  feeding: false,
                ),
                ScannerFailed(:final message) => _Rejected(
                  reason: message,
                  title: 'Scan failed',
                  onRetry: () => _close(context),
                ),
                _ => const SizedBox.shrink(),
              };
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () => _close(context),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.white,
                          ),
                        ),
                        const Spacer(),
                        Text('Scan Results', style: AppTextStyles.h2),
                        const Spacer(),
                        const InfoButton(
                          topics: [GuideTopicId.grades, GuideTopicId.scanning],
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: body),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MealPhoto extends StatelessWidget {
  const _MealPhoto();

  @override
  Widget build(BuildContext context) {
    final photo = context.read<ScannerCubit>().photo;
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 4),
        ),
        child: ClipOval(
          child: photo == null
              ? const ColoredBox(
                  color: AppColors.card,
                  child: Center(
                    child: Text('🍽️', style: TextStyle(fontSize: 80)),
                  ),
                )
              : Image.memory(photo, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _Analyzing extends StatelessWidget {
  const _Analyzing();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _MealPhoto(),
        const SizedBox(height: AppSpacing.xl),
        const Text('👨‍🍳', style: TextStyle(fontSize: 56)),
        const SizedBox(height: AppSpacing.md),
        Text('AI Chef is analyzing...', style: AppTextStyles.h3),
        const SizedBox(height: AppSpacing.sm),
        Text('Reading calories, macros and more', style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.lg),
        const CircularProgressIndicator(color: AppColors.primary),
      ],
    );
  }
}

class _Rejected extends StatelessWidget {
  final String reason;
  final String title;
  final VoidCallback onRetry;

  const _Rejected({
    required this.reason,
    required this.onRetry,
    this.title = 'Validation failed',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _MealPhoto(),
          const SizedBox(height: AppSpacing.xl),
          GlassCard(
            borderColor: AppColors.error,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const Text('🚫', style: TextStyle(fontSize: 44)),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  reason,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GameButton(
            label: 'Try again',
            style: GameButtonStyle.accent,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

class _Results extends StatelessWidget {
  final MealEntity meal;
  final bool feeding;

  const _Results({required this.meal, required this.feeding});

  @override
  Widget build(BuildContext context) {
    final petName = context.read<PetCubit>().pet?.name ?? 'your buddy';
    String pct(int v) => '$v%';
    final tiles = [
      (
        '🔥',
        'Calories',
        '${meal.calories}',
        NutrientTile.levelForCalories(meal.calories),
      ),
      (
        '💪',
        'Protein',
        pct(meal.proteinPct),
        NutrientTile.levelForPct(meal.proteinPct),
      ),
      (
        '🌾',
        'Carbs',
        pct(meal.carbsPct),
        NutrientTile.levelForPct(meal.carbsPct),
      ),
      ('🥑', 'Fats', pct(meal.fatsPct), NutrientTile.levelForPct(meal.fatsPct)),
      (
        '🍊',
        'Vitamins',
        pct(meal.vitaminsPct),
        NutrientTile.levelForPct(meal.vitaminsPct),
      ),
      (
        '⚡',
        'Minerals',
        pct(meal.mineralsPct),
        NutrientTile.levelForPct(meal.mineralsPct),
      ),
      (
        '🌿',
        'Fiber',
        pct(meal.fiberPct),
        NutrientTile.levelForPct(meal.fiberPct),
      ),
      ('❤️', 'Health Score', '${meal.healthScore}', 'out of 100'),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const _MealPhoto(),
        const SizedBox(height: AppSpacing.lg),
        GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(meal.name, style: AppTextStyles.h2)),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.accent,
                    child: Text(meal.grade, style: AppTextStyles.h2),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(meal.description, style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.15,
                children: [
                  for (final (emoji, label, value, level) in tiles)
                    NutrientTile(
                      emoji: emoji,
                      label: label,
                      value: value,
                      level: level,
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GameButton(
          label: 'Feed $petName',
          style: GameButtonStyle.battle,
          isLoading: feeding,
          onPressed: () => context.read<ScannerCubit>().feed(),
        ),
      ],
    );
  }
}

class _Fed extends StatelessWidget {
  final MealEntity meal;
  final FeedResultEntity result;
  final VoidCallback onDone;

  const _Fed({required this.meal, required this.result, required this.onDone});

  String _signed(int v) => v >= 0 ? '+$v' : '$v';

  // "+0" looks like the meal did nothing, so say why the stat didn't move
  String _describe(String label, int change, PetEntity pet) {
    if (change != 0) return _signed(change);
    return switch (label) {
      'Health' when pet.health == 100 => 'Full',
      'Energy' when pet.energy == 100 => 'Full',
      'Nutrition' => 'Steady',
      _ => _signed(change),
    };
  }

  @override
  Widget build(BuildContext context) {
    final pet = result.pet;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Center(child: PetAvatar(speciesKey: pet.speciesKey, interactive: true)),
        Text(
          'Feeding successful!',
          textAlign: TextAlign.center,
          style: AppTextStyles.h1,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${pet.name} enjoyed the ${meal.name}',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
        ),
        if (result.leveledUp) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            '🎉 Level up! Now level ${pet.level}',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: AppColors.gold),
          ),
        ],
        if (result.streakExtended) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            pet.streak == 1
                ? '🔥 Streak started! Feed ${pet.name} again tomorrow'
                : '🔥 ${pet.streak}-day streak! +${result.streakBonusXp} bonus XP',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: AppColors.accent),
          ),
        ],
        if (result.fullHealthBonusXp > 0) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            '💪 Health already full! +${result.fullHealthBonusXp} bonus XP',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: AppColors.primary),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              for (final (emoji, label, change) in [
                ('❤️', 'Health', result.healthChange),
                ('⚡', 'Energy', result.energyChange),
                ('🍽️', 'Nutrition', result.nutritionChange),
                ('⭐', 'XP', result.xpGained),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    children: [
                      Text(emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: AppSpacing.md),
                      Text(label, style: AppTextStyles.bodyLarge),
                      const Spacer(),
                      Text(
                        _describe(label, change, pet),
                        style: AppTextStyles.h3.copyWith(
                          color: change >= 0
                              ? AppColors.primary
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        GameButton(label: 'Back to buddy', onPressed: onDone),
      ],
    );
  }
}
