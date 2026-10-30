import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/presentation/widgets/stat_chips.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

class OpponentCard extends StatelessWidget {
  final OpponentEntity opponent;
  final bool loading;
  final VoidCallback? onBattle;

  const OpponentCard({
    super.key,
    required this.opponent,
    required this.loading,
    required this.onBattle,
  });

  @override
  Widget build(BuildContext context) {
    final o = opponent;
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: GameArt(AppImages.opponent(o.key), size: 64),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(o.name, style: AppTextStyles.h3),
                Text(
                  'Level ${o.level} · ${o.difficulty}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.xs),
                StatChips(
                  hp: o.hp,
                  attack: o.attack,
                  defense: o.defense,
                  compact: true,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '⏱ ${o.reactionTime} to react · 🎭 ${o.fakes}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  '💥 ${o.heavyChance}% heavy attacks',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 104,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('💰 ${o.coinReward}', style: AppTextStyles.h3),
                const SizedBox(height: AppSpacing.sm),
                GameButton(
                  label: 'Battle',
                  style: GameButtonStyle.accent,
                  height: 42,
                  isLoading: loading,
                  onPressed: onBattle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
