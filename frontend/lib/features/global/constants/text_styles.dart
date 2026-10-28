import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/painting.dart';

// Fredoka (round and bubbly, like the logo) for headings, buttons and numbers;
// Nunito (rounded but built for reading) for everything else. Both are bundled
// in assets/fonts/, so nothing is downloaded at runtime.
class AppTextStyles {
  static const String display = 'Fredoka';
  static const String body = 'Nunito';

  // The bundled files are variable fonts: the weight has to be set on the
  // 'wght' axis as well as through fontWeight
  static TextStyle _style(
    String family,
    int weight, {
    required double size,
    double? height,
    double? letterSpacing,
    Color color = AppColors.textPrimary,
  }) => TextStyle(
    fontFamily: family,
    fontWeight: FontWeight.values[(weight ~/ 100) - 1],
    fontVariations: [FontVariation('wght', weight.toDouble())],
    fontSize: size,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  // Headlines
  static final TextStyle h1 = _style(display, 600, size: 30, height: 1.2);
  static final TextStyle h2 = _style(display, 600, size: 22, height: 1.25);
  static final TextStyle h3 = _style(display, 500, size: 18, height: 1.3);

  // Body
  static final TextStyle bodyLarge = _style(body, 600, size: 16, height: 1.5);
  static final TextStyle bodyMedium = _style(body, 600, size: 15, height: 1.45);
  static final TextStyle caption = _style(
    body,
    600,
    size: 13,
    height: 1.4,
    color: AppColors.textMuted,
  );

  static final TextStyle button = _style(
    display,
    600,
    size: 17,
    letterSpacing: 0.5,
    color: AppColors.white,
  );

  static final TextStyle stat = _style(
    display,
    600,
    size: 22,
    color: AppColors.primary,
  );
}
