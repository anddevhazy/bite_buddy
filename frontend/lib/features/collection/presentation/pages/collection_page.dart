import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  int _tab = 1; // Leaders first, like the demo

  @override
  void initState() {
    super.initState();
    context.read<CollectionCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            const PageHeader(
              title: 'My Collection',
              subtitle: 'Meals, achievements & more',
            ),
            const SizedBox(height: AppSpacing.lg),
            _Tabs(selected: _tab, onSelect: (i) => setState(() => _tab = i)),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  if (state is CollectionFailed) {
                    return AppErrorView(
                      message: state.message,
                      onRetry: () => context.read<CollectionCubit>().load(),
                    );
                  }
                  if (state is! CollectionLoaded) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () => context.read<CollectionCubit>().load(),
                    child: _tab == 0
                        ? _MealList(meals: state.meals)
                        : _Leaderboard(entries: state.leaderboard),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const _Tabs({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const tabs = ['🍽️ Meals', '🏆 Leaders'];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Row(
        children: [
          for (final (i, label) in tabs.indexed)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: i == selected ? AppColors.primary : null,
                    borderRadius: BorderRadius.circular(AppSpacing.radius - 4),
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MealList extends StatelessWidget {
  final List<MealEntity> meals;

  const _MealList({required this.meals});

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          const Center(child: Text('🍽️', style: TextStyle(fontSize: 56))),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No meals yet. Scan your first one!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      );
    }
    final dateFormat = DateFormat('MMM d, h:mm a');
    return ListView.separated(
      itemCount: meals.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, i) {
        final meal = meals[i];
        return GlassCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.accent,
                child: Text(meal.grade, style: AppTextStyles.h3),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal.name, style: AppTextStyles.h3),
                    Text(
                      '${meal.calories} kcal · ${dateFormat.format(meal.createdAt)}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${meal.healthScore}', style: AppTextStyles.stat),
                  Text(
                    meal.fed ? 'Fed' : 'Not fed',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Leaderboard extends StatelessWidget {
  final List<LeaderboardEntryEntity> entries;

  const _Leaderboard({required this.entries});

  static const _medals = ['🥇', '🥈', '🥉'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('🏆 Nutrition Leaderboard', style: AppTextStyles.h2),
        Text(
          'Top buddies ranked by nutrition score',
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: AppSpacing.md),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xl),
            child: Text(
              'Nobody has eaten yet. Be the first!',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: GlassCard(
              borderColor: e.isYou ? AppColors.gold : null,
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      e.rank <= 3 ? _medals[e.rank - 1] : '#${e.rank}',
                      textAlign: TextAlign.center,
                      style: e.rank <= 3
                          ? const TextStyle(fontSize: 26)
                          : AppTextStyles.h3,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GameArt(AppImages.pet(e.speciesKey), size: 40),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.isYou ? '${e.petName} (You)' : e.petName,
                          style: AppTextStyles.h3,
                        ),
                        Text('Level ${e.level}', style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${e.nutrition}', style: AppTextStyles.stat),
                      Text('Nutrition', style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
