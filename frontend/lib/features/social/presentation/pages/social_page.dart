import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/social/presentation/bloc/social_cubit.dart';
import 'package:bite_buddy/features/social/presentation/widgets/challenge_card.dart';
import 'package:bite_buddy/features/social/presentation/widgets/code_dialog.dart';
import 'package:bite_buddy/features/social/presentation/widgets/friend_tile.dart';
import 'package:bite_buddy/features/social/presentation/widgets/new_challenge_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  void initState() {
    super.initState();
    context.read<SocialCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: ForestBackground(
          child: SafeArea(
            child: BlocConsumer<SocialCubit, SocialState>(
              listener: (context, state) {
                if (state is SocialActionDone) {
                  AppToast.show(
                    context: context,
                    message: state.message,
                    type: ToastType.success,
                  );
                  // Friends show up as opponents in the arena
                  context.read<BattleCubit>().loadOpponents();
                }
                if (state is SocialActionFailed) {
                  AppToast.show(
                    context: context,
                    message: state.message,
                    type: ToastType.error,
                  );
                }
              },
              buildWhen: (_, state) =>
                  state is! SocialActionDone && state is! SocialActionFailed,
              builder: (context, state) {
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
                            onPressed: () => context.pop(),
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.white,
                            ),
                          ),
                          const Spacer(),
                          Text('Friends', style: AppTextStyles.h2),
                          const Spacer(),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    TabBar(
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textMuted,
                      labelStyle: AppTextStyles.h3,
                      dividerColor: AppColors.glassBorder,
                      tabs: const [
                        Tab(text: 'Friends'),
                        Tab(text: 'Challenges'),
                      ],
                    ),
                    Expanded(
                      child: switch (state) {
                        SocialLoaded() => TabBarView(
                          children: [
                            _FriendsTab(state: state),
                            _ChallengesTab(state: state),
                          ],
                        ),
                        SocialFailed(:final message) => AppErrorView(
                          message: message,
                          onRetry: () => context.read<SocialCubit>().load(),
                        ),
                        _ => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _FriendsTab extends StatelessWidget {
  final SocialLoaded state;

  const _FriendsTab({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialCubit>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: cubit.load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Text('Your friend code', style: AppTextStyles.caption),
                const SizedBox(height: AppSpacing.xs),
                InkWell(
                  onTap: () => _copy(context, state.friendCode),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.friendCode,
                        style: AppTextStyles.h1.copyWith(letterSpacing: 4),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(Icons.copy_rounded, color: AppColors.textMuted),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Share it so friends can add you',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                GameButton(
                  label: 'Add a friend',
                  style: GameButtonStyle.accent,
                  isLoading: state.busy,
                  onPressed: () async {
                    final code = await showCodeDialog(
                      context,
                      title: 'Add a friend',
                      hint: "Their friend code",
                      action: 'Send request',
                    );
                    if (code != null) cubit.addFriend(code);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (state.friends.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'No friends yet. Add one to battle their buddy, build a '
                'shared streak and start challenges together!',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            )
          else ...[
            Text(
              'Battle friends from the Battle tab. Feed your buddies on the '
              'same day to grow your shared 🔥 streak.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final friend in state.friends)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: FriendTile(
                  friend: friend,
                  busy: state.busy,
                  onAccept: () => cubit.accept(friend),
                  onRemove: () => cubit.remove(friend),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _ChallengesTab extends StatelessWidget {
  final SocialLoaded state;

  const _ChallengesTab({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialCubit>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: cubit.load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            'Whoever feeds the most healthy meals (score 70+) before the end '
            'wins.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: GameButton(
                  label: 'New',
                  style: GameButtonStyle.accent,
                  isLoading: state.busy,
                  onPressed: () async {
                    final choice = await showNewChallengeDialog(context);
                    if (choice != null) {
                      cubit.createChallenge(choice.name, choice.days);
                    }
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: GameButton(
                  label: 'Join',
                  isLoading: state.busy,
                  onPressed: () async {
                    final code = await showCodeDialog(
                      context,
                      title: 'Join a challenge',
                      hint: 'Challenge code',
                      action: 'Join',
                    );
                    if (code != null) cubit.joinChallenge(code);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (state.challenges.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                'No challenges yet. Start one and share the code with your '
                'friends.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            )
          else
            for (final challenge in state.challenges)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: ChallengeCard(
                  challenge: challenge,
                  busy: state.busy,
                  onCopyCode: () => _copy(context, challenge.code),
                  onLeave: () => cubit.leaveChallenge(challenge),
                ),
              ),
        ],
      ),
    );
  }
}

void _copy(BuildContext context, String code) {
  Clipboard.setData(ClipboardData(text: code));
  AppToast.show(
    context: context,
    message: 'Copied $code',
    type: ToastType.success,
  );
}
