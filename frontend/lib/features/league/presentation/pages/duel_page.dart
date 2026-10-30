import 'package:bite_buddy/features/battle/presentation/widgets/stat_chips.dart';
import 'package:bite_buddy/features/global/components/buddy_picture.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/presentation/bloc/duel_cubit.dart';
import 'package:bite_buddy/features/league/presentation/widgets/time_left.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// A friend battle. Each round you both pick a move in secret; it plays out
// once both are in. There are no tells here: read your friend instead.
class DuelPage extends StatelessWidget {
  final int duelId;

  const DuelPage({super.key, required this.duelId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DuelCubit>()..load(duelId),
      child: Scaffold(
        body: ForestBackground(
          image: AppImages.arenaBackground,
          child: SafeArea(
            child: BlocConsumer<DuelCubit, DuelState>(
              listener: (context, state) {
                if (state is DuelFailed) {
                  AppToast.show(
                    context: context,
                    message: state.message,
                    type: ToastType.error,
                  );
                }
              },
              buildWhen: (_, state) => state is! DuelFailed,
              builder: (context, state) => Column(
                children: [
                  const _TopBar(),
                  Expanded(
                    child: state is DuelLoaded
                        ? RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () =>
                                context.read<DuelCubit>().refresh(),
                            child: _DuelView(
                              duel: state.duel,
                              submitting: state.submitting,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

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
              'Friend battle',
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            ),
          ),
          const InfoButton(
            topics: [GuideTopicId.friendBattles, GuideTopicId.battleMoves],
          ),
        ],
      ),
    );
  }
}

class _DuelView extends StatelessWidget {
  final DuelEntity duel;
  final bool submitting;

  const _DuelView({required this.duel, required this.submitting});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Fighter(
                name: duel.theirPetName,
                speciesKey: duel.theirSpeciesKey,
                portraitId: duel.theirPortraitId,
                hp: duel.theirHp,
                maxHp: duel.theirMaxHp,
                attack: duel.theirAttack,
                defense: duel.theirDefense,
                color: AppColors.error,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryDark,
                child: Text('VS', style: AppTextStyles.h3),
              ),
            ),
            Expanded(
              child: _Fighter(
                name: '${duel.myPetName} (You)',
                speciesKey: duel.mySpeciesKey,
                portraitId: duel.myPortraitId,
                hp: duel.myHp,
                maxHp: duel.myMaxHp,
                attack: duel.myAttack,
                defense: duel.myDefense,
                color: AppColors.health,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _Status(duel: duel),
        if (duel.lastRound != null) ...[
          const SizedBox(height: AppSpacing.md),
          _LastRound(round: duel.lastRound!, theirName: duel.theirPetName),
        ],
        if (duel.theirRecentMoves.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _TheirHabits(duel: duel),
        ],
        if (!duel.isOver) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            duel.yourTurn ? 'Choose your move' : 'Your move is locked in',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final move in BattleMove.values)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _MoveButton(
                move: move,
                cooldown: move == BattleMove.special
                    ? duel.mySpecialCooldown
                    : 0,
                enabled: duel.yourTurn && !submitting,
              ),
            ),
        ],
      ],
    );
  }
}

class _Fighter extends StatelessWidget {
  final String name;
  final String speciesKey;
  final int? portraitId;
  final int hp;
  final int maxHp;
  final int attack;
  final int defense;
  final Color color;

  const _Fighter({
    required this.name,
    required this.speciesKey,
    required this.portraitId,
    required this.hp,
    required this.maxHp,
    required this.attack,
    required this.defense,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuddyPicture(speciesKey: speciesKey, portraitId: portraitId, size: 96),
        Text(
          name,
          style: AppTextStyles.h3,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: maxHp == 0 ? 0 : hp / maxHp),
            duration: const Duration(milliseconds: 400),
            builder: (context, v, _) => LinearProgressIndicator(
              value: v,
              minHeight: 10,
              backgroundColor: AppColors.track,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        Text('$hp/$maxHp HP', style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.xs),
        StatChips(hp: maxHp, attack: attack, defense: defense, compact: true),
      ],
    );
  }
}

// Whose turn it is, the deadline, or how the battle ended
class _Status extends StatelessWidget {
  final DuelEntity duel;

  const _Status({required this.duel});

  @override
  Widget build(BuildContext context) {
    final them = duel.theirPetName;
    final (emoji, title, detail, color) = switch (duel.result) {
      DuelResult.won => (
        '🏆',
        'Victory!',
        '${duel.endReason}. This win counts toward your season score.',
        AppColors.primary,
      ),
      DuelResult.lost => (
        '💫',
        'Defeat',
        '${duel.endReason}. $them takes this one.',
        AppColors.error,
      ),
      DuelResult.draw => (
        '🤝',
        'Draw',
        '${duel.endReason}. Nobody gets the win.',
        AppColors.textMuted,
      ),
      null when duel.yourTurn => (
        '⚔️',
        'Your move!',
        [
          if (duel.theyHaveMoved) '$them has already picked.',
          'Pick within ${timeLeft(duel.roundDeadline)}.',
          if (duel.youMissed > 0)
            'You missed last round: miss another and you forfeit!',
        ].join(' '),
        duel.youMissed > 0 ? AppColors.error : AppColors.accent,
      ),
      null => (
        '⏳',
        'Waiting for $them',
        'They have ${timeLeft(duel.roundDeadline)} to move. Pull down to '
            'refresh.',
        AppColors.textMuted,
      ),
    };
    return GlassCard(
      borderColor: color,
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3.copyWith(color: color)),
                Text(detail, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LastRound extends StatelessWidget {
  final DuelRoundEntity round;
  final String theirName;

  const _LastRound({required this.round, required this.theirName});

  String _label(BattleMove? move) =>
      move == null ? '⏳ Missed' : '${move.emoji} ${move.label}';

  @override
  Widget build(BuildContext context) {
    final good = round.damageDealt > round.damageTaken;
    final even = round.damageDealt == round.damageTaken;
    final color = even
        ? AppColors.white
        : good
        ? AppColors.primary
        : AppColors.error;
    return GlassCard(
      borderColor: even ? null : color,
      child: Column(
        children: [
          Text('Round ${round.round}', style: AppTextStyles.caption),
          Text(
            '${_label(round.myMove)}  vs  ${_label(round.theirMove)}',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
          ),
          if (round.clash.isNotEmpty)
            Text(round.clash, style: AppTextStyles.h3.copyWith(color: color)),
          if (round.myCritical || round.theirCritical)
            Text(
              round.myCritical && round.theirCritical
                  ? '💥 Critical hits on both sides!'
                  : round.myCritical
                  ? '💥 You landed a critical hit!'
                  : '💥 $theirName landed a critical hit!',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.gold),
            ),
          Text(
            round.message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// Your friend's last few moves: there are no tells against a real person, so
// spotting their habits is how you get the edge
class _TheirHabits extends StatelessWidget {
  final DuelEntity duel;

  const _TheirHabits({required this.duel});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${duel.theirPetName}'s last moves",
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              for (final m in duel.theirRecentMoves)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text(
                    m?.emoji ?? '⏳',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              const Spacer(),
              Text('oldest → newest', style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoveButton extends StatelessWidget {
  final BattleMove move;
  final int cooldown;
  final bool enabled;

  const _MoveButton({
    required this.move,
    required this.cooldown,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final ready = cooldown == 0;
    return Opacity(
      opacity: enabled && ready ? 1 : 0.45,
      child: GlassCard(
        onTap: enabled && ready
            ? () => context.read<DuelCubit>().play(move)
            : null,
        child: Row(
          children: [
            Text(move.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(move.label, style: AppTextStyles.h3),
                  Text(
                    ready ? move.hint : 'Recharging: $cooldown more rounds',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
