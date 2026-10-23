import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';

// Placeholder art until the pet illustrations are added to assets/
class Species {
  static String emoji(String speciesKey) => switch (speciesKey) {
    'fluffy' => '🐶',
    'sparkle' => '🦝',
    'thunder' => '🐯',
    'mystic' => '🐰',
    _ => '🐾',
  };

  static Color rarityColor(String rarity) => switch (rarity) {
    'rare' => AppColors.rare,
    'epic' => AppColors.epic,
    'legendary' => AppColors.legendary,
    _ => AppColors.common,
  };
}
