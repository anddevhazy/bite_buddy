import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BattlePage extends StatelessWidget {
  const BattlePage({super.key});

  Future<void> _leave(BuildContext context) async {
    // Rewards and energy changed on the server; pull the fresh pet
    context.read<PetCubit>().loadPet(silent: true);
    context.read<BattleCubit>().leave();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ForestBackground(
          image: AppImages.arenaBackground,
          child: SafeArea(
            child: BlocConsumer<BattleCubit, BattleState>(
              listenWhen: (previous, _) => previous is InBattle,
              listener: (context, state) {
                if (state is BattleFailed) {
                  AppToast.show(
                    context: context,
                    message: state.message,
                    type: ToastType.error,
                  );
                }
              },
              buildWhen: (_, state) => state is InBattle,
              builder: (context, state) {
                if (state is! InBattle) return const SizedBox.shrink();
                final battle = state.battle;
                return Stack(
                  children: [
                    _Arena(battle: battle, resolving: state.resolving),
                    if (battle.isOver)
                      _ResultOverlay(
                        battle: battle,
                        onDone: () => _leave(context),
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

class _Arena extends StatelessWidget {
  final BattleEntity battle;
  final bool resolving;

  const _Arena({required this.battle, required this.resolving});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          children: [
            const SizedBox(width: 48),
            Expanded(
              child: Text(
                battle.round == 0 ? 'Battle started!' : 'Round ${battle.round}',
                textAlign: TextAlign.center,
                style: AppTextStyles.h2,
              ),
            ),
            const InfoButton(topics: [GuideTopicId.battleMoves]),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Fighter(
                image: AppImages.opponent(battle.opponent.key),
                name: battle.opponent.name,
                hp: battle.opponentHp,
                maxHp: battle.opponentMaxHp,
                color: AppColors.error,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primaryDark,
                child: Text('VS', style: AppTextStyles.h3),
              ),
            ),
            Expanded(
              child: _Fighter(
                image: AppImages.pet(battle.petSpeciesKey),
                name: battle.petName,
                hp: battle.petHp,
                maxHp: battle.petMaxHp,
                color: AppColors.health,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _RoundResult(battle: battle),
        const SizedBox(height: AppSpacing.lg),
        if (!battle.isOver && battle.opponentTell != null)
          _Tell(battle: battle),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Choose Your Move',
          textAlign: TextAlign.center,
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: AppSpacing.md),
        for (final move in BattleMove.values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _MoveButton(
              move: move,
              cooldown: move == BattleMove.special ? battle.specialCooldown : 0,
              enabled: !resolving && !battle.isOver,
            ),
          ),
      ],
    );
  }
}

// What happened last round: how the moves met, then the play-by-play
class _RoundResult extends StatelessWidget {
  final BattleEntity battle;

  const _RoundResult({required this.battle});

  @override
  Widget build(BuildContext context) {
    final last = battle.lastRound;
    if (last == null) {
      return GlassCard(
        child: Text(
          'Your ${battle.petName} is battling ${battle.opponent.name}. '
          'Watch for its tell, then pick the move that beats it!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    // Did the player come out ahead this round?
    final good = last.damageDealt > last.damageTaken;
    final even = last.damageDealt == last.damageTaken;
    return GlassCard(
      borderColor: even
          ? null
          : good
          ? AppColors.primary
          : AppColors.error,
      child: Column(
        children: [
          Text(
            '${last.playerMove.emoji} ${last.playerMove.label}  vs  '
            '${last.opponentMove.emoji} ${last.opponentMove.label}',
            style: AppTextStyles.caption.copyWith(color: AppColors.white),
          ),
          if (last.clash.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              last.clash,
              style: AppTextStyles.h3.copyWith(
                color: even
                    ? AppColors.white
                    : good
                    ? AppColors.primary
                    : AppColors.error,
              ),
            ),
          ],
          if (last.playerCritical || last.opponentCritical) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              last.playerCritical && last.opponentCritical
                  ? '💥 Critical hits on both sides!'
                  : last.playerCritical
                  ? '💥 You landed a critical hit!'
                  : '💥 ${battle.opponent.name} landed a critical hit!',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.gold),
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          Text(
            last.message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// The opponent's tell for the coming round. Usually true; some opponents bluff.
class _Tell extends StatelessWidget {
  final BattleEntity battle;

  const _Tell({required this.battle});

  @override
  Widget build(BuildContext context) {
    final tell = battle.opponentTell!;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          Text(tell.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tell.tellFor(battle.opponent.name),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${battle.opponent.bluffs}. Pick the move that beats it.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Fighter extends StatelessWidget {
  final String image;
  final String name;
  final int hp;
  final int maxHp;
  final Color color;

  const _Fighter({
    required this.image,
    required this.name,
    required this.hp,
    required this.maxHp,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameArt(image, size: 110),
        Text(
          name,
          style: AppTextStyles.h3,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.sm),
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
        const SizedBox(height: AppSpacing.xs),
        Text('$hp/$maxHp', style: AppTextStyles.caption),
      ],
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
            ? () => context.read<BattleCubit>().play(move)
            : null,
        child: Row(
          children: [
            Text(move.emoji, style: const TextStyle(fontSize: 28)),
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

class _ResultOverlay extends StatelessWidget {
  final BattleEntity battle;
  final VoidCallback onDone;

  const _ResultOverlay({required this.battle, required this.onDone});

  @override
  Widget build(BuildContext context) {
    final won = battle.status == BattleStatus.won;
    final energy = battle.energyChange;
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(AppSpacing.lg),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: won ? AppColors.primary : AppColors.error,
              width: 3,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(won ? '🏆' : '💫', style: const TextStyle(fontSize: 64)),
              Text(won ? 'Victory!' : 'Defeat', style: AppTextStyles.h1),
              const SizedBox(height: AppSpacing.sm),
              Text(
                won
                    ? '${battle.petName} beat ${battle.opponent.name}!'
                    : '${battle.opponent.name} was too strong this time.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '💰 +${battle.coinsEarned}   ⭐ +${battle.xpEarned} XP   '
                '⚡ ${energy >= 0 ? '+' : ''}$energy',
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              GameButton(
                label: 'Back to arena',
                style: won ? GameButtonStyle.battle : GameButtonStyle.accent,
                onPressed: onDone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
