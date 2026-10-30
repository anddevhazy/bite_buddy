import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/meal_ideas_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// AI meal ideas for the gaps in the week, at the bottom of the weekly
// summary. Loaded only when tapped.
class MealIdeasSection extends StatelessWidget {
  const MealIdeasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MealIdeasCubit>(),
      child: BlocBuilder<MealIdeasCubit, MealIdeasState>(
        builder: (context, state) {
          return switch (state) {
            MealIdeasLoaded(:final ideas) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '🥗 Meal ideas for today',
                        style: AppTextStyles.h3,
                      ),
                    ),
                    const InfoButton(topics: [GuideTopicId.mealIdeas]),
                  ],
                ),
                for (final idea in ideas) _IdeaTile(idea: idea),
              ],
            ),
            MealIdeasLoading() => const Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
            MealIdeasFailed(:final message) => Row(
              children: [
                Expanded(child: Text(message, style: AppTextStyles.bodyMedium)),
                TextButton(
                  onPressed: () => context.read<MealIdeasCubit>().load(),
                  child: const Text('Retry'),
                ),
              ],
            ),
            _ => OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
              ),
              onPressed: () => context.read<MealIdeasCubit>().load(),
              icon: const Icon(Icons.auto_awesome_rounded),
              label: const Text('Meal ideas'),
            ),
          };
        },
      ),
    );
  }
}

class _IdeaTile extends StatelessWidget {
  final MealIdeaEntity idea;

  const _IdeaTile({required this.idea});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            idea.name,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.gold),
          ),
          Text(idea.reason, style: AppTextStyles.bodyMedium),
          if (idea.boosts.isNotEmpty)
            Text(
              'Boosts ${idea.boosts.join(', ')}',
              style: AppTextStyles.caption.copyWith(color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}
