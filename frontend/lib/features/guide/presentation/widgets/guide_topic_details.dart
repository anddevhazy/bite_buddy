import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';

// A topic's summary and bullet points
class GuideTopicDetails extends StatelessWidget {
  final GuideTopic topic;

  const GuideTopicDetails({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topic.summary,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final point in topic.points)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•  ', style: AppTextStyles.bodyMedium),
                Expanded(child: Text(point, style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
      ],
    );
  }
}
