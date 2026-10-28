import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';

// The illustrated forest behind every screen, darkened slightly toward the
// top and bottom so text and cards stay readable on it.
class ForestBackground extends StatelessWidget {
  final Widget child;
  final String image;

  const ForestBackground({
    super.key,
    required this.child,
    this.image = AppImages.appBackground,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.35),
              Colors.black.withValues(alpha: 0.10),
              Colors.black.withValues(alpha: 0.45),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}
