import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

// "HP 115 · ATK 27 · DEF 21", used for your buddy and for opponents so the two
// can be compared at a glance
class StatChips extends StatelessWidget {
  final int hp;
  final int attack;
  final int defense;
  final bool compact;

  const StatChips({
    super.key,
    required this.hp,
    required this.attack,
    required this.defense,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: compact ? AppSpacing.xs : AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        _Chip(
          label: 'HP',
          value: hp,
          color: AppColors.health,
          compact: compact,
        ),
        _Chip(
          label: 'ATK',
          value: attack,
          color: AppColors.accent,
          compact: compact,
        ),
        _Chip(
          label: 'DEF',
          value: defense,
          color: AppColors.nutrition,
          compact: compact,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final bool compact;

  const _Chip({
    required this.label,
    required this.value,
    required this.color,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final style = compact ? AppTextStyles.caption : AppTextStyles.bodyMedium;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: style.copyWith(color: color),
            ),
            TextSpan(
              text: '$value',
              style: style.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
