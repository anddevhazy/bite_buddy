import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/data/guide_content.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/guide_topic_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// "How to play": every topic, collapsed to its title until tapped
class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.white,
                      ),
                    ),
                    const Spacer(),
                    Text('How to play', style: AppTextStyles.h2),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: GuideContent.topics.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, i) => _TopicCard(
                    topic: GuideContent.topics[i],
                    // The basics start open so first-timers see them
                    initiallyOpen: i == 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicCard extends StatefulWidget {
  final GuideTopic topic;
  final bool initiallyOpen;

  const _TopicCard({required this.topic, required this.initiallyOpen});

  @override
  State<_TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<_TopicCard> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    return GlassCard(
      onTap: () => setState(() => _open = !_open),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(topic.emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(topic.title, style: AppTextStyles.h3)),
              Icon(
                _open ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _open
                ? Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: GuideTopicDetails(topic: topic),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
