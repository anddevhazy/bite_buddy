import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/presentation/bloc/leagues_cubit.dart';
import 'package:bite_buddy/features/league/presentation/widgets/time_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// The "Friends" side of the Battle tab: your leagues, and creating or joining
class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key});

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {
  @override
  void initState() {
    super.initState();
    context.read<LeaguesCubit>().load();
  }

  Future<void> _create() async {
    final name = await _askForText(
      context,
      title: 'Name your league',
      hint: 'e.g. Lunch Crew',
      action: 'Create',
      maxLength: 30,
    );
    if (name == null || !mounted) return;
    final result = await context.read<LeaguesCubit>().create(name);
    if (!mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (league) => _open(league.id),
    );
  }

  Future<void> _join() async {
    final code = await _askForText(
      context,
      title: 'Join a league',
      hint: 'Invite code, e.g. K7Q2MX',
      action: 'Join',
      maxLength: 6,
      capitals: true,
    );
    if (code == null || !mounted) return;
    final result = await context.read<LeaguesCubit>().join(code);
    if (!mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (league) => _open(league.id),
    );
  }

  Future<void> _open(int leagueId) async {
    await context.pushNamed(
      Routes.leagueName,
      pathParameters: {'id': '$leagueId'},
    );
    // Scores and turns may have changed while it was open
    if (mounted) context.read<LeaguesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaguesCubit, LeaguesState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<LeaguesCubit>().load(),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const PageHeader(
                title: '🏆 Friend Leagues',
                subtitle: 'Weekly seasons: eat well and beat your friends',
                trailing: InfoButton(
                  topics: [GuideTopicId.leagues, GuideTopicId.friendBattles],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: GameButton(
                      label: 'Create',
                      style: GameButtonStyle.accent,
                      height: 48,
                      onPressed: _create,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: GameButton(
                      label: 'Join',
                      height: 48,
                      onPressed: _join,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              switch (state) {
                LeaguesLoaded(:final leagues) when leagues.isEmpty =>
                  const _NoLeagues(),
                LeaguesLoaded(:final leagues) => Column(
                  children: [
                    for (final l in leagues)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _LeagueCard(league: l, onTap: () => _open(l.id)),
                      ),
                  ],
                ),
                LeaguesFailed(:final message) => AppErrorView(
                  message: message,
                  onRetry: () => context.read<LeaguesCubit>().load(),
                ),
                _ => const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              },
            ],
          ),
        );
      },
    );
  }
}

class _NoLeagues extends StatelessWidget {
  const _NoLeagues();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Text('🤝', style: TextStyle(fontSize: 48)),
          const SizedBox(height: AppSpacing.sm),
          Text('No leagues yet', style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Create a league and share its code with friends, or join theirs. '
            'Each week, whoever feeds their buddy best (and wins the most '
            'friend battles) takes the trophy.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _LeagueCard extends StatelessWidget {
  final LeagueSummaryEntity league;
  final VoidCallback onTap;

  const _LeagueCard({required this.league, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final waiting = league.yourTurnCount;
    return GlassCard(
      onTap: onTap,
      borderColor: waiting > 0 ? AppColors.accent : null,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryDark,
            child: Text('#${league.myRank}', style: AppTextStyles.h3),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(league.name, style: AppTextStyles.h3),
                Text(
                  '${league.memberCount} members · ${league.myScore} pts · '
                  'ends in ${timeLeft(league.seasonEndsAt)}',
                  style: AppTextStyles.caption,
                ),
                if (waiting > 0)
                  Text(
                    waiting == 1
                        ? '⚔️ A battle is waiting for your move'
                        : '⚔️ $waiting battles are waiting for your move',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

// A small dialog with one text field; returns the text, or null if cancelled
Future<String?> _askForText(
  BuildContext context, {
  required String title,
  required String hint,
  required String action,
  required int maxLength,
  bool capitals = false,
}) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.card,
      title: Text(title, style: AppTextStyles.h2),
      content: TextField(
        controller: controller,
        autofocus: true,
        maxLength: maxLength,
        textCapitalization: capitals
            ? TextCapitalization.characters
            : TextCapitalization.sentences,
        style: AppTextStyles.bodyLarge,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final text = controller.text.trim();
            if (text.isNotEmpty) Navigator.pop(dialogContext, text);
          },
          child: Text(action),
        ),
      ],
    ),
  );
}
