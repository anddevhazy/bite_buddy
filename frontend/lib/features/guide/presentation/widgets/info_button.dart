import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/guide/data/guide_content.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/guide_topic_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// A small "?" that explains what's on the current screen, with a link to the
// full guide
class InfoButton extends StatelessWidget {
  final List<GuideTopicId> topics;

  const InfoButton({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'What does this mean?',
      onPressed: () => showGuideSheet(context, topics),
      icon: const Icon(
        Icons.help_outline_rounded,
        color: AppColors.white,
        size: 26,
      ),
    );
  }
}

Future<void> showGuideSheet(BuildContext context, List<GuideTopicId> ids) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: AppColors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      builder: (_, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          for (final id in ids) ...[
            _TopicHeading(topic: GuideContent.byId(id)),
            const SizedBox(height: AppSpacing.sm),
            GuideTopicDetails(topic: GuideContent.byId(id)),
            const SizedBox(height: AppSpacing.lg),
          ],
          GameButton(
            label: 'Full guide',
            onPressed: () {
              Navigator.pop(sheetContext);
              context.pushNamed(Routes.guideName);
            },
          ),
        ],
      ),
    ),
  );
}

class _TopicHeading extends StatelessWidget {
  final GuideTopic topic;

  const _TopicHeading({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(topic.emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(topic.title, style: AppTextStyles.h2)),
      ],
    );
  }
}
