import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';

// The title-screen picture: valley art, logo and a spinner. Drawn by the
// boot splash before the app is set up, then by the splash screen, so the
// two look like one continuous screen.
class SplashArt extends StatelessWidget {
  const SplashArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppImages.splashBackground, fit: BoxFit.cover),
        SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset(AppImages.logo),
              ),
              const Spacer(flex: 4),
              const CircularProgressIndicator(color: AppColors.white),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}

// Shown with runApp before anything else is ready (no MaterialApp yet), so it
// supplies the MediaQuery and text direction the art needs itself.
class BootSplash extends StatelessWidget {
  const BootSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.fromView(
      view: View.of(context),
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: SplashArt(),
      ),
    );
  }
}
