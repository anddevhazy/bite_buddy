import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/presentation/bloc/streaks_cubit.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Shared streaks with friends, on the buddy home screen
class SharedStreaksCard extends StatefulWidget {
  const SharedStreaksCard({super.key});

  @override
  State<SharedStreaksCard> createState() => _SharedStreaksCardState();
}

class _SharedStreaksCardState extends State<SharedStreaksCard> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<StreaksCubit>();
    if (cubit.state is StreaksInitial) cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StreaksCubit, StreaksState>(
      builder: (context, state) {
        return GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('🤝 Shared streaks', style: AppTextStyles.h3),
                  ),
                  const InfoButton(topics: [GuideTopicId.sharedStreaks]),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ...switch (state) {
                StreaksLoaded(:final streaks) => [
                  if (streaks.isEmpty)
                    Text(
                      'Keep a streak going with a friend: a day counts when '
                      'you both feed your buddies.',
                      style: AppTextStyles.bodyMedium,
                    ),
                  for (final s in streaks) _StreakRow(streak: s),
                  if (streaks.length < 5)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => _pickFriend(context),
                        icon: const Icon(Icons.person_add_alt_1_rounded),
                        label: const Text('Invite a friend'),
                      ),
                    ),
                ],
                StreaksFailed() => [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Couldn't load shared streaks.",
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.read<StreaksCubit>().load(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ],
                _ => [
                  const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ],
              },
            ],
          ),
        );
      },
    );
  }
}

class _StreakRow extends StatelessWidget {
  final SharedStreakEntity streak;

  const _StreakRow({required this.streak});

  @override
  Widget build(BuildContext context) {
    final s = streak;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          GameArt(AppImages.pet(s.friendSpeciesKey), size: 44),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.friendPetName, style: AppTextStyles.bodyLarge),
                Text(switch (s.status) {
                  SharedStreakStatus.invited => 'Invite sent · waiting',
                  SharedStreakStatus.incoming => 'Wants a shared streak!',
                  SharedStreakStatus.active =>
                    '${s.youFedToday ? '✅' : '⏳'} You  '
                        '${s.friendFedToday ? '✅' : '⏳'} Friend'
                        '${s.bestStreak > 0 ? '  · best ${s.bestStreak}' : ''}',
                }, style: AppTextStyles.caption),
              ],
            ),
          ),
          ...switch (s.status) {
            SharedStreakStatus.active => [
              Text(
                '🔥 ${s.streak}',
                style: AppTextStyles.h3.copyWith(color: AppColors.accent),
              ),
              _MoreButton(
                label: 'End streak',
                confirm: 'End your shared streak with ${s.friendPetName}?',
                streakId: s.id,
              ),
            ],
            SharedStreakStatus.invited => [
              _MoreButton(label: 'Cancel invite', streakId: s.id),
            ],
            SharedStreakStatus.incoming => [
              TextButton(
                onPressed: () => _run(
                  context,
                  context.read<StreaksCubit>().accept(s.id),
                  'Shared streak started with ${s.friendPetName}!',
                ),
                child: const Text('Accept'),
              ),
              IconButton(
                tooltip: 'Decline',
                onPressed: () => _run(
                  context,
                  context.read<StreaksCubit>().remove(s.id),
                  null,
                ),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          },
        ],
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  final String label;
  final String? confirm;
  final int streakId;

  const _MoreButton({
    required this.label,
    required this.streakId,
    this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      icon: const Icon(Icons.more_vert_rounded, color: AppColors.textMuted),
      color: AppColors.card,
      itemBuilder: (_) => [
        PopupMenuItem(
          onTap: () async {
            if (confirm != null && !await _confirm(context, confirm!)) return;
            if (!context.mounted) return;
            await _run(
              context,
              context.read<StreaksCubit>().remove(streakId),
              null,
            );
          },
          child: Text(label),
        ),
      ],
    );
  }
}

Future<bool> _confirm(BuildContext context, String question) async =>
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(question, style: AppTextStyles.h3),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep it'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('End it'),
          ),
        ],
      ),
    ) ??
    false;

// Runs an action and shows how it went
Future<void> _run(
  BuildContext context,
  Future<Either<Failure, Object>> action,
  String? success,
) async {
  final result = await action;
  if (!context.mounted) return;
  result.fold(
    (failure) => AppToast.show(
      context: context,
      message: failure.message,
      type: ToastType.error,
    ),
    (_) {
      if (success != null) {
        AppToast.show(
          context: context,
          message: success,
          type: ToastType.success,
        );
      }
    },
  );
}

// Lists league friends without a shared streak, and invites the one picked
Future<void> _pickFriend(BuildContext context) async {
  final cubit = context.read<StreaksCubit>();
  final result = await cubit.candidates();
  if (!context.mounted) return;
  final friends = result.fold((failure) {
    AppToast.show(
      context: context,
      message: failure.message,
      type: ToastType.error,
    );
    return null;
  }, (friends) => friends);
  if (friends == null) return;

  final picked = await showModalBottomSheet<StreakFriendEntity>(
    context: context,
    backgroundColor: AppColors.card,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invite a friend', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.xs),
            Text(
              friends.isEmpty
                  ? 'Shared streaks are with friends from your leagues. Join '
                        'or create a league (Battle tab, then Friends) and '
                        'invite your friends to it first.'
                  : 'Friends from your leagues:',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final f in friends)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GameArt(AppImages.pet(f.speciesKey), size: 40),
                      title: Text(f.petName, style: AppTextStyles.bodyLarge),
                      trailing: const Icon(Icons.send_rounded),
                      onTap: () => Navigator.pop(sheetContext, f),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  if (picked == null || !context.mounted) return;
  await _run(
    context,
    cubit.invite(picked.userId),
    'Invite sent to ${picked.petName}',
  );
}
