import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _entry;

  static void show(BuildContext context, {String? message}) {
    if (_entry != null) return;

    _entry = OverlayEntry(
      builder:
          (_) => Material(
            color: Colors.black.withValues(alpha: 0.6),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.xl),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 42,
                      height: 42,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ),
                    if (message != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
