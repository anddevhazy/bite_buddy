import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// The screens use a pixel font everywhere, so every style is Pixelify Sans
class AppTextStyles {
  // Headlines
  static TextStyle h1 = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w700,
    fontSize: 30,
    height: 1.2,
    letterSpacing: 1,
    color: AppColors.textPrimary,
  );

  static TextStyle h2 = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.25,
    letterSpacing: 0.8,
    color: AppColors.textPrimary,
  );

  static TextStyle h3 = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // Body
  static TextStyle bodyLarge = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static TextStyle caption = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.4,
    color: AppColors.textMuted,
  );

  static TextStyle button = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 2,
    color: AppColors.white,
  );

  static TextStyle stat = GoogleFonts.pixelifySans(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    color: AppColors.primary,
  );
}
