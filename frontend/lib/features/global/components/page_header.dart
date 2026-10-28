import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

// Centered title + green subtitle used at the top of each tab, with an
// optional button (usually the "?" info button) in the top-right corner
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final header = Column(
      children: [
        Text(title, style: AppTextStyles.h1, textAlign: TextAlign.center),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
        ],
      ],
    );
    if (trailing == null) return header;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Full width, and kept clear of the button on narrow screens
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(width: double.infinity, child: header),
        ),
        Positioned(top: -8, right: -12, child: trailing!),
      ],
    );
  }
}
