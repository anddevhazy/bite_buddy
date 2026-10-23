import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';

// Night-forest gradient with a few twinkling sparkles, behind every screen.
// Swap the gradient for the illustrated background image once it's in assets/.
class ForestBackground extends StatelessWidget {
  final Widget child;

  const ForestBackground({super.key, required this.child});

  static const List<Offset> _sparkles = [
    Offset(0.80, 0.08),
    Offset(0.18, 0.22),
    Offset(0.92, 0.42),
    Offset(0.08, 0.55),
    Offset(0.70, 0.66),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundTop,
            AppColors.background,
            AppColors.backgroundBottom,
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              for (final s in _sparkles)
                Positioned(
                  left: s.dx * constraints.maxWidth,
                  top: s.dy * constraints.maxHeight,
                  child: Icon(
                    Icons.auto_awesome,
                    size: 22,
                    color: AppColors.gold.withValues(alpha: 0.55),
                  ),
                ),
              Positioned.fill(child: child),
            ],
          );
        },
      ),
    );
  }
}
