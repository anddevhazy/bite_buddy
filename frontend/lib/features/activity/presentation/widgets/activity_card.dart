import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/activity/presentation/bloc/activity_cubit.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Steps and sleep on the buddy home screen
class ActivityCard extends StatefulWidget {
  const ActivityCard({super.key});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ActivityCubit>();
    if (cubit.state is ActivityInitial) cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivitySynced) {
          // The sync may have boosted the buddy's stats
          context.read<PetCubit>().updatePet(state.activity.pet);
          final a = state.activity;
          if (a.energyGained > 0 || a.healthGained > 0) {
            AppToast.show(
              context: context,
              message: [
                if (a.energyGained > 0) '+${a.energyGained} energy from steps',
                if (a.healthGained > 0) '+${a.healthGained} health from sleep',
              ].join(' · '),
              type: ToastType.success,
            );
          }
        } else if (state is ActivityFailed) {
          AppToast.show(
            context: context,
            message: state.message,
            type: ToastType.warning,
          );
        }
      },
      builder: (context, state) {
        return GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('👟 Steps and sleep', style: AppTextStyles.h3),
                  ),
                  const InfoButton(topics: [GuideTopicId.activity]),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              switch (state) {
                ActivityNotConnected(:final source, :final connecting) =>
                  _Connect(source: source, connecting: connecting),
                ActivitySynced(:final activity) => _Numbers(activity: activity),
                ActivityFailed() => Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Couldn't read your steps and sleep.",
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.read<ActivityCubit>().sync(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
                _ => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              },
            ],
          ),
        );
      },
    );
  }
}

class _Connect extends StatelessWidget {
  final HealthSource source;
  final bool connecting;

  const _Connect({required this.source, required this.connecting});

  @override
  Widget build(BuildContext context) {
    final app = switch (source) {
      HealthSource.appleHealth => 'Apple Health',
      HealthSource.healthConnect => 'Health Connect',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Walk and sleep well to boost your buddy: 1,000 steps = 1 energy '
          '(up to 10 a day), 7+ hours of sleep = 5 health.',
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: connecting
              ? null
              : () => context.read<ActivityCubit>().connect(),
          icon: connecting
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.favorite_rounded),
          label: Text('Connect $app'),
        ),
      ],
    );
  }
}

class _Numbers extends StatelessWidget {
  final ActivitySyncEntity activity;

  const _Numbers({required this.activity});

  @override
  Widget build(BuildContext context) {
    final a = activity;
    final sleepHours = a.sleepMinutes ~/ 60;
    final sleepRest = a.sleepMinutes % 60;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _Stat(
                emoji: '👟',
                value: '${a.steps}',
                label: 'steps today',
                reward: '⚡ ${a.energyToday}/${a.maxEnergyPerDay} energy',
              ),
            ),
            Expanded(
              child: _Stat(
                emoji: '😴',
                value: a.sleepMinutes == 0
                    ? '–'
                    : '${sleepHours}h ${sleepRest}m',
                label: 'sleep last night',
                reward: '❤️ ${a.healthToday}/${a.maxHealthPerDay} health',
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.read<ActivityCubit>().disconnect(),
            child: const Text('Disconnect'),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final String reward;

  const _Stat({
    required this.emoji,
    required this.value,
    required this.label,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$emoji $value', style: AppTextStyles.h3),
        Text(label, style: AppTextStyles.caption),
        Text(
          reward,
          style: AppTextStyles.caption.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
