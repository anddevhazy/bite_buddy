import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:flutter/material.dart';

// Frosted card used for buddy tiles, opponents, leaderboard rows and wallet info
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.glass.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(
              color: borderColor ?? AppColors.glassBorder,
              width: borderColor == null ? 1 : 2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
