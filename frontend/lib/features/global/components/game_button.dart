import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

enum GameButtonStyle { primary, accent, battle, danger }

// Chunky glossy pill button ("SCAN MEAL", "GO TO BATTLE", "FIGHT!")
class GameButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final GameButtonStyle style;
  final bool isLoading;
  final double height;

  const GameButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = GameButtonStyle.primary,
    this.isLoading = false,
    this.height = 60,
  });

  (Color, Color) get _colors => switch (style) {
    GameButtonStyle.primary => (AppColors.primary, AppColors.primaryDark),
    GameButtonStyle.accent => (AppColors.accent, AppColors.accentDark),
    GameButtonStyle.battle => (AppColors.battle, AppColors.battleDark),
    GameButtonStyle.danger => (AppColors.error, const Color(0xFF9E1C22)),
  };

  @override
  Widget build(BuildContext context) {
    final (top, bottom) = _colors;
    final disabled = onPressed == null || isLoading;

    return Opacity(
      opacity: disabled && !isLoading ? 0.5 : 1,
      child: GestureDetector(
        onTap: disabled ? null : onPressed,
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2.6),
            border: Border.all(color: bottom, width: 3),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.lerp(top, Colors.white, 0.25)!, top],
            ),
            boxShadow: [
              BoxShadow(
                color: top.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child:
              isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.white,
                    ),
                  )
                  : Text(label.toUpperCase(), style: AppTextStyles.button),
        ),
      ),
    );
  }
}
