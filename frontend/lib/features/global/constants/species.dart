import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:flutter/material.dart';

class Species {
  static Color rarityColor(String rarity) => switch (rarity) {
    'rare' => AppColors.rare,
    'epic' => AppColors.epic,
    'legendary' => AppColors.legendary,
    _ => AppColors.common,
  };
}
