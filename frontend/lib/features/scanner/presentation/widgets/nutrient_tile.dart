import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

class NutrientTile extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final String level;

  const NutrientTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.value,
    required this.level,
  });

  // How much of a daily target this portion covers, in words
  static String levelForPct(int pct) {
    if (pct < 15) return 'Low';
    if (pct < 35) return 'Medium';
    if (pct < 60) return 'High';
    return 'Very High';
  }

  static String levelForCalories(int kcal) {
    if (kcal < 300) return 'Light';
    if (kcal < 700) return 'Moderate';
    return 'Hearty';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.white),
          ),
          Text(value, style: AppTextStyles.stat),
          Text(level, style: AppTextStyles.caption.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}
