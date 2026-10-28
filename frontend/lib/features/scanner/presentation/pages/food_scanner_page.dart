import 'dart:typed_data';

import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/scanner/presentation/bloc/scanner_cubit.dart';
import 'package:bite_buddy/features/scanner/presentation/pages/camera_capture_page.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FoodScannerPage extends StatelessWidget {
  const FoodScannerPage({super.key});

  static const _tips = [
    ('📸', 'Snap your meal right before you eat it'),
    ('🍽️', 'Get the whole plate in the shot'),
    ('💡', 'Good light helps the AI Chef see clearly'),
    ('🚫', 'Screenshots and downloaded photos are rejected'),
  ];

  Future<void> _snap(BuildContext context) async {
    final bytes = await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<Uint8List>(builder: (_) => const CameraCapturePage()),
    );
    if (bytes == null || !context.mounted) return;
    context.read<ScannerCubit>().analyze(bytes);
    context.pushNamed(Routes.scanResultName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const SizedBox(height: AppSpacing.lg),
          const PageHeader(
            title: 'Food Scanner',
            subtitle: 'Feed your buddy with what you eat',
            trailing: InfoButton(
              topics: [GuideTopicId.scanning, GuideTopicId.grades],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Center(child: Text('🥗', style: TextStyle(fontSize: 110))),
          const SizedBox(height: AppSpacing.xl),
          GlassCard(
            child: Column(
              children: [
                for (final (emoji, tip) in _tips)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(tip, style: AppTextStyles.bodyMedium),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GameButton(
            label: 'Snap Meal',
            style: GameButtonStyle.accent,
            onPressed: () => _snap(context),
          ),
        ],
      ),
    );
  }
}
