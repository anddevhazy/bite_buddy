import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/features/battle/presentation/widgets/opponent_card.dart';
import 'package:bite_buddy/features/battle/presentation/widgets/stat_chips.dart';
import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BattleArenaPage extends StatefulWidget {
  const BattleArenaPage({super.key});

  @override
  State<BattleArenaPage> createState() => _BattleArenaPageState();
}

class _BattleArenaPageState extends State<BattleArenaPage> {
  @override
  void initState() {
    super.initState();
    context.read<BattleCubit>().loadOpponents();
  }

  @override
  Widget build(BuildContext context) {
    final pet = context.watch<PetCubit>().pet;
    return SafeArea(
      child: BlocConsumer<BattleCubit, BattleState>(
        listener: (context, state) {
          if (state is FightReady) {
            context.pushNamed(Routes.fightName, extra: state.config);
          }
          if (state is BattleFailed) {
            AppToast.show(
              context: context,
              message: state.message,
              type: ToastType.error,
            );
          }
        },
        // A failure is shown as a toast; keep the list on screen
        buildWhen: (_, state) => state is! BattleFailed && state is! FightReady,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const SizedBox(height: AppSpacing.md),
              const PageHeader(
                title: '⚔️ Battle Arena',
                subtitle: 'Challenge opponents to earn coins and XP',
                trailing: InfoButton(
                  topics: [GuideTopicId.battles, GuideTopicId.coins],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (pet != null)
                GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Text(
                        '${pet.name} · Level ${pet.level} · '
                        '⚡ ${pet.energy}/100',
                        style: AppTextStyles.bodyMedium,
                      ),
                      if (state is OpponentsLoaded &&
                          state.arena.petStats.hp > 0) ...[
                        const SizedBox(height: AppSpacing.sm),
                        StatChips(
                          hp: state.arena.petStats.hp,
                          attack: state.arena.petStats.attack,
                          defense: state.arena.petStats.defense,
                        ),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Text('Choose Your Opponent', style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.md),
              if (state is OpponentsLoaded && state.opponents.isEmpty)
                AppErrorView(
                  message: 'Could not load opponents.',
                  onRetry: () => context.read<BattleCubit>().loadOpponents(),
                )
              else if (state is OpponentsLoaded)
                for (final o in state.opponents)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: OpponentCard(
                      opponent: o,
                      loading:
                          state is BattleStarting && state.opponentKey == o.key,
                      onBattle: state is BattleStarting
                          ? null
                          : () => context.read<BattleCubit>().start(o.key),
                    ),
                  )
              else
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
