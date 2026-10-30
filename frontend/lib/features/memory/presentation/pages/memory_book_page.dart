import 'dart:math';

import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/buddy_picture.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy/features/memory/presentation/bloc/memory_book_cubit.dart';
import 'package:bite_buddy/features/memory/presentation/widgets/progress_charts.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// The memory book: how far the buddy has come since day 1, with charts of
// its progress and a timeline of milestones
class MemoryBookPage extends StatelessWidget {
  const MemoryBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MemoryBookCubit>()..load(),
      child: Scaffold(
        body: ForestBackground(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Memory book',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2,
                        ),
                      ),
                      const InfoButton(topics: [GuideTopicId.memoryBook]),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<MemoryBookCubit, MemoryBookState>(
                    builder: (context, state) => switch (state) {
                      MemoryBookLoaded(:final book) => RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () => context.read<MemoryBookCubit>().load(),
                        child: _Book(book: book),
                      ),
                      MemoryBookFailed(:final message) => AppErrorView(
                        message: message,
                        onRetry: () => context.read<MemoryBookCubit>().load(),
                      ),
                      _ => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Book extends StatelessWidget {
  final MemoryBookEntity book;

  const _Book({required this.book});

  @override
  Widget build(BuildContext context) {
    final short = DateFormat('d MMM');
    final weeks = book.weeks;
    final fedDays = book.feedingDays.where((d) => d.meals > 0).length;
    final scored = weeks.where((w) => w.averageScore != null).toList();
    final totalWins = weeks.fold(0, (n, w) => n + w.wins);
    double weekX(int i) => weeks.length == 1 ? 0.5 : i / (weeks.length - 1);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        // Hero: the buddy and how long you've been together
        Center(
          child: BuddyPicture(
            speciesKey: book.speciesKey,
            portraitId: book.portraitId,
            size: 110,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Text(
            '${book.daysTogether}',
            style: AppTextStyles.h1.copyWith(
              fontSize: 56,
              height: 1,
              color: AppColors.gold,
            ),
          ),
        ),
        Center(
          child: Text(
            book.daysTogether == 1
                ? 'day with ${book.petName}'
                : 'days with ${book.petName}',
            style: AppTextStyles.bodyLarge,
          ),
        ),
        Center(
          child: Text(
            'Since ${DateFormat('d MMMM y').format(book.adoptedAt)}',
            style: AppTextStyles.caption,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        _DayOneVsToday(book: book),
        const SizedBox(height: AppSpacing.md),

        ChartCard(
          title: 'Feeding calendar',
          summary:
              'Fed on $fedDays of the last ${book.feedingDays.length} '
              'day${book.feedingDays.length == 1 ? '' : 's'}',
          child: FeedingCalendar(days: book.feedingDays),
        ),
        const SizedBox(height: AppSpacing.md),

        ChartCard(
          title: 'Meal score by week',
          summary: scored.isEmpty
              ? 'Feed ${book.petName} to start this chart'
              : _scoreSummary(scored),
          child: scored.isEmpty
              ? const SizedBox.shrink()
              : TrendChart(
                  semanticLabel:
                      'Average meal score by week, latest '
                      '${scored.last.averageScore}',
                  yMax: 100,
                  yTicks: const [0, 50, 100],
                  startLabel: short.format(weeks.first.weekStart),
                  endLabel: 'This week',
                  points: [
                    for (final (i, w) in weeks.indexed)
                      ChartPoint(
                        x: weekX(i),
                        y: w.averageScore?.toDouble(),
                        caption:
                            'Week of ${short.format(w.weekStart)} · avg '
                            '${w.averageScore ?? '-'} · ${w.meals} meals',
                      ),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.md),

        ChartCard(
          title: 'Level journey',
          summary: book.levels.length == 1
              ? 'Level 1 so far. Meals and battle wins earn XP'
              : 'Level 1 to ${book.levels.last.level}',
          child: TrendChart(
            semanticLabel:
                'Level over time, now level ${book.levels.last.level}',
            step: true,
            yMax: book.levels.last.level + 1.0,
            yTicks: {1.0, book.levels.last.level.toDouble()}.toList(),
            startLabel: short.format(book.adoptedAt),
            endLabel: 'Today',
            points: _levelPoints(book, short),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        ChartCard(
          title: 'Battles won by week',
          summary: totalWins == 0
              ? 'Win an arena or friend battle to start this chart'
              : '$totalWins win${totalWins == 1 ? '' : 's'} since '
                    '${short.format(weeks.first.weekStart)}',
          child: totalWins == 0
              ? const SizedBox.shrink()
              : WeeklyBars(
                  semanticLabel: '$totalWins battles won',
                  values: [for (final w in weeks) w.wins],
                  captions: [
                    for (final w in weeks)
                      'Week of ${short.format(w.weekStart)} · ${w.wins} '
                          'win${w.wins == 1 ? '' : 's'}',
                  ],
                  startLabel: short.format(weeks.first.weekStart),
                  endLabel: 'This week',
                ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (book.firstWeekNutrients case final first?)
          if (book.lastWeekNutrients case final last?) ...[
            ChartCard(
              title: 'Then and now',
              summary: 'Daily average, as % of the target',
              child: NutrientDumbbells(first: first, last: last),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

        Text('Memories', style: AppTextStyles.h2),
        const SizedBox(height: AppSpacing.sm),
        for (final (i, m) in book.memories.reversed.indexed)
          _MemoryTile(memory: m, isLast: i == book.memories.length - 1),
      ],
    );
  }

  String _scoreSummary(List<WeekProgressEntity> scored) {
    final now = scored.last.averageScore!;
    if (scored.length == 1) return 'Average score $now this week';
    final then = scored.first.averageScore!;
    final change = now - then;
    return change == 0
        ? 'Steady at $now'
        : '${change > 0 ? 'Up' : 'Down'} ${change.abs()} points since '
              'your first week ($then → $now)';
  }

  // Levels spread over the time since adoption
  List<ChartPoint> _levelPoints(MemoryBookEntity book, DateFormat short) {
    final start = book.adoptedAt;
    final span = max(1, DateTime.now().difference(start).inMinutes);
    return [
      for (final l in book.levels)
        ChartPoint(
          x: (l.reachedAt.difference(start).inMinutes / span).clamp(0.0, 1.0),
          y: l.level.toDouble(),
          caption: 'Level ${l.level} · ${short.format(l.reachedAt)}',
        ),
    ];
  }
}

class _DayOneVsToday extends StatelessWidget {
  final MemoryBookEntity book;

  const _DayOneVsToday({required this.book});

  @override
  Widget build(BuildContext context) {
    final a = book.dayOne;
    final b = book.today;
    final tiles = [
      ('⬆️', 'Level', a.level, b.level),
      ('🍽️', 'Meals', a.mealsEaten, b.mealsEaten),
      ('🔥', 'Best streak', a.bestStreak, b.bestStreak),
      ('⚔️', 'Wins', a.wins, b.wins),
      if (b.trophies > 0) ('🏆', 'Trophies', a.trophies, b.trophies),
    ];
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Day 1 vs today', style: AppTextStyles.h3),
          Text(
            'Green shows how much each has grown since day 1',
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final (emoji, label, then, now) in tiles)
                Container(
                  width: 96,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.glass.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$emoji $label',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption,
                      ),
                      // Shrinks rather than overflowing with large text
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text('$now', style: AppTextStyles.h2),
                            const SizedBox(width: 6),
                            if (now > then)
                              Text(
                                '+${now - then}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  final MemoryEntryEntity memory;
  final bool isLast;

  const _MemoryTile({required this.memory, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The timeline's spine
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.glass.withValues(alpha: 0.15),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Text(
                    memory.emoji,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: AppColors.glassBorder),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(memory.title, style: AppTextStyles.bodyLarge),
                  if (memory.detail case final detail?)
                    Text(detail, style: AppTextStyles.bodyMedium),
                  Text(
                    DateFormat('d MMM y').format(memory.happenedAt),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
