import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/features/insights/presentation/widgets/meal_ideas_section.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// The weekly summary and tips on the buddy home screen
class InsightsCard extends StatefulWidget {
  const InsightsCard({super.key});

  @override
  State<InsightsCard> createState() => _InsightsCardState();
}

class _InsightsCardState extends State<InsightsCard> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<InsightsCubit>();
    if (cubit.state is InsightsInitial) cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsightsCubit, InsightsState>(
      builder: (context, state) {
        return GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: switch (state) {
            InsightsLoaded(:final insights) => _Summary(insights: insights),
            InsightsFailed() => Row(
              children: [
                Expanded(
                  child: Text(
                    "Couldn't load this week's summary.",
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () => context.read<InsightsCubit>().load(),
                  child: const Text('Retry'),
                ),
              ],
            ),
            _ => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          },
        );
      },
    );
  }
}

class _Summary extends StatelessWidget {
  final NutritionInsightsEntity insights;

  const _Summary({required this.insights});

  @override
  Widget build(BuildContext context) {
    final nutrients = [
      ('💪', 'Protein', insights.proteinPct),
      ('🌾', 'Carbs', insights.carbsPct),
      ('🥑', 'Fats', insights.fatsPct),
      ('🍊', 'Vitamins', insights.vitaminsPct),
      ('⚡', 'Minerals', insights.mineralsPct),
      ('🌿', 'Fiber', insights.fiberPct),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('This week', style: AppTextStyles.h3)),
            const InfoButton(topics: [GuideTopicId.weeklySummary]),
          ],
        ),
        if (insights.mealsCounted > 0) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${insights.mealsCounted} meals on ${insights.daysWithMeals} of 7 '
            'days · avg score ${insights.averageHealthScore}',
            style: AppTextStyles.caption,
          ),
          if (insights.bestMealName != null)
            Text(
              '⭐ Best: ${insights.bestMealName}',
              style: AppTextStyles.caption.copyWith(color: AppColors.gold),
            ),
          const SizedBox(height: AppSpacing.md),
          Text('Daily average', style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final (emoji, label, pct) in nutrients)
                _NutrientChip(emoji: emoji, label: label, pct: pct),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        for (final tip in insights.tips)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡 '),
                Expanded(child: Text(tip, style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        const MealIdeasSection(),
      ],
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final String emoji;
  final String label;
  final int pct;

  const _NutrientChip({
    required this.emoji,
    required this.label,
    required this.pct,
  });

  @override
  Widget build(BuildContext context) {
    // Same 50% line the server uses for "low" tips
    final color = pct < 50 ? AppColors.accent : AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        '$emoji $label $pct%',
        style: AppTextStyles.caption.copyWith(color: AppColors.white),
      ),
    );
  }
}
