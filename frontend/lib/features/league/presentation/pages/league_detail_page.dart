import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/presentation/bloc/league_detail_cubit.dart';
import 'package:bite_buddy/features/league/presentation/widgets/time_left.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LeagueDetailPage extends StatelessWidget {
  final int leagueId;

  const LeagueDetailPage({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LeagueDetailCubit>()..load(leagueId),
      child: const _LeagueDetailView(),
    );
  }
}

class _LeagueDetailView extends StatelessWidget {
  const _LeagueDetailView();

  Future<void> _openDuel(BuildContext context, int duelId) async {
    await context.pushNamed(Routes.duelName, pathParameters: {'id': '$duelId'});
    if (context.mounted) context.read<LeagueDetailCubit>().refresh();
  }

  Future<void> _challenge(BuildContext context, StandingEntity friend) async {
    final result = await context.read<LeagueDetailCubit>().challenge(
      friend.memberId,
    );
    if (!context.mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (duel) => _openDuel(context, duel.id),
    );
  }

  Future<void> _leave(BuildContext context, LeagueDetailEntity league) async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('Leave ${league.name}?', style: AppTextStyles.h2),
        content: Text(
          'Any friend battles still going in this league will count as '
          'losses.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('Leave', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (sure != true || !context.mounted) return;
    final result = await context.read<LeagueDetailCubit>().leave();
    if (!context.mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (_) => context.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: BlocBuilder<LeagueDetailCubit, LeagueDetailState>(
            builder: (context, state) {
              final league = switch (state) {
                LeagueDetailLoaded(:final league) => league,
                _ => null,
              };
              return Column(
                children: [
                  _TopBar(title: league?.name ?? 'League'),
                  Expanded(
                    child: switch (state) {
                      LeagueDetailFailed(:final message) => AppErrorView(
                        message: message,
                        onRetry: () =>
                            context.read<LeagueDetailCubit>().refresh(),
                      ),
                      LeagueDetailLoaded(
                        :final league,
                        :final challengingMemberId,
                      ) =>
                        RefreshIndicator(
                          color: AppColors.primary,
                          onRefresh: () =>
                              context.read<LeagueDetailCubit>().refresh(),
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              0,
                              AppSpacing.lg,
                              AppSpacing.xl,
                            ),
                            children: [
                              _SeasonCard(league: league),
                              const SizedBox(height: AppSpacing.md),
                              _ChallengeCard(league: league),
                              const SizedBox(height: AppSpacing.md),
                              _InviteCard(code: league.inviteCode),
                              if (league.duels.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.lg),
                                Text('Your battles', style: AppTextStyles.h2),
                                const SizedBox(height: AppSpacing.sm),
                                for (final d in league.duels)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.sm,
                                    ),
                                    child: _DuelTile(
                                      duel: d,
                                      onTap: () => _openDuel(context, d.id),
                                    ),
                                  ),
                              ],
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                "This week's table",
                                style: AppTextStyles.h2,
                              ),
                              Text(
                                'Score = 70% feeding + 30% battles',
                                style: AppTextStyles.caption,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              for (final s in league.standings)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.sm,
                                  ),
                                  child: _StandingRow(
                                    standing: s,
                                    challenging:
                                        challengingMemberId == s.memberId,
                                    onChallenge:
                                        s.isYou || challengingMemberId != null
                                        ? null
                                        : () => _challenge(context, s),
                                  ),
                                ),
                              if (league.standings.length < 2)
                                Text(
                                  'Invite a friend to start competing!',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyMedium,
                                ),
                              const SizedBox(height: AppSpacing.xl),
                              GameButton(
                                label: 'Leave league',
                                style: GameButtonStyle.danger,
                                height: 48,
                                onPressed: () => _leave(context, league),
                              ),
                            ],
                          ),
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
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;

  const _TopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h2,
            ),
          ),
          const InfoButton(
            topics: [GuideTopicId.leagues, GuideTopicId.friendBattles],
          ),
        ],
      ),
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final LeagueDetailEntity league;

  const _SeasonCard({required this.league});

  @override
  Widget build(BuildContext context) {
    final winner = league.lastSeasonWinner;
    final myRank = league.lastSeasonYourRank;
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(
            '⏳ Season ends in ${timeLeft(league.seasonEndsAt)}',
            style: AppTextStyles.h3,
          ),
          Text(
            'The winner gets 500 coins and a trophy 🏆',
            style: AppTextStyles.caption,
          ),
          if (winner != null || myRank != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              [
                if (winner != null) "Last week's winner: $winner",
                if (myRank != null) 'you placed #$myRank',
              ].join(' · '),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.gold),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final LeagueDetailEntity league;

  const _ChallengeCard({required this.league});

  @override
  Widget build(BuildContext context) {
    final c = league.challenge;
    final lastWeek = league.lastChallengeCompleted;
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('🎯 Team challenge', style: AppTextStyles.caption),
              ),
              const InfoButton(topics: [GuideTopicId.teamChallenges]),
            ],
          ),
          Text(c.title, style: AppTextStyles.h3),
          Text(c.description, style: AppTextStyles.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: c.target == 0 ? 0 : c.progress / c.target,
              minHeight: 10,
              color: c.completed ? AppColors.gold : AppColors.primary,
              backgroundColor: AppColors.glass.withValues(alpha: 0.15),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            c.completed
                ? '✅ Done! Everyone gets ${c.rewardCoins} coins when the '
                      'season ends'
                : '${c.progress} / ${c.target} · everyone gets '
                      '${c.rewardCoins} coins if you make it',
            style: AppTextStyles.caption.copyWith(
              color: c.completed ? AppColors.gold : null,
            ),
          ),
          if (lastWeek != null)
            Text(
              lastWeek
                  ? "Last week's challenge was met: +${c.rewardCoins} coins 🎉"
                  : "Last week's challenge wasn't met",
              style: AppTextStyles.caption,
            ),
        ],
      ),
    );
  }
}

class _InviteCard extends StatelessWidget {
  final String code;

  const _InviteCard({required this.code});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Invite code', style: AppTextStyles.caption),
                Text(code, style: AppTextStyles.h2.copyWith(letterSpacing: 4)),
                Text(
                  'Friends join with this code (Battle → Friends → Join)',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Copy code',
            icon: const Icon(Icons.copy_rounded, color: AppColors.white),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: code));
              if (context.mounted) {
                AppToast.show(
                  context: context,
                  message: 'Code copied. Send it to your friends!',
                  type: ToastType.success,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final StandingEntity standing;
  final bool challenging;
  final VoidCallback? onChallenge;

  const _StandingRow({
    required this.standing,
    required this.challenging,
    required this.onChallenge,
  });

  @override
  Widget build(BuildContext context) {
    final s = standing;
    return GlassCard(
      borderColor: s.isYou ? AppColors.gold : null,
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              s.rank <= 3 ? ['🥇', '🥈', '🥉'][s.rank - 1] : '#${s.rank}',
              textAlign: TextAlign.center,
              style: s.rank <= 3
                  ? const TextStyle(fontSize: 22)
                  : AppTextStyles.h3,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GameArt(AppImages.pet(s.speciesKey), size: 40),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.isYou ? '${s.petName} (You)' : s.petName,
                  style: AppTextStyles.h3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '🍽️ ${s.feedingScore} (avg ${s.averageMealScore}, '
                  '${s.daysFed}/7 days) · ⚔️ ${s.battleScore} '
                  '(${s.wins} ${s.wins == 1 ? 'win' : 'wins'})',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${s.totalScore}', style: AppTextStyles.stat),
              if (!s.isYou)
                SizedBox(
                  width: 76,
                  child: GameButton(
                    label: 'Battle',
                    style: GameButtonStyle.accent,
                    height: 30,
                    isLoading: challenging,
                    onPressed: onChallenge,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DuelTile extends StatelessWidget {
  final DuelEntity duel;
  final VoidCallback onTap;

  const _DuelTile({required this.duel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (status, color) = switch (duel.result) {
      DuelResult.won => ('🏆 You won · ${duel.endReason}', AppColors.primary),
      DuelResult.lost => ('Lost · ${duel.endReason}', AppColors.error),
      DuelResult.draw => ('Draw · ${duel.endReason}', AppColors.textMuted),
      null when duel.yourTurn => (
        'Your move! ${timeLeft(duel.roundDeadline)} left',
        AppColors.accent,
      ),
      null => (
        'Waiting for ${duel.theirPetName} · ${timeLeft(duel.roundDeadline)}',
        AppColors.textMuted,
      ),
    };
    return GlassCard(
      onTap: onTap,
      borderColor: duel.yourTurn ? AppColors.accent : null,
      child: Row(
        children: [
          GameArt(AppImages.pet(duel.theirSpeciesKey), size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('vs ${duel.theirPetName}', style: AppTextStyles.h3),
                Text(
                  status,
                  style: AppTextStyles.caption.copyWith(color: color),
                ),
              ],
            ),
          ),
          Text(
            'Round ${duel.round + (duel.isOver ? 0 : 1)}',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
