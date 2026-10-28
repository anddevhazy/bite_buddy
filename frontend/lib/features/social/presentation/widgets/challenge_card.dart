import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/species.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeEntity challenge;
  final bool busy;
  final VoidCallback onCopyCode;
  final VoidCallback onLeave;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.busy,
    required this.onCopyCode,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final c = challenge;
    return GlassCard(
      borderColor: c.isOver ? null : AppColors.primary,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(c.name, style: AppTextStyles.h3)),
              Text(
                _timeLeft(c),
                style: AppTextStyles.caption.copyWith(
                  color: c.isOver ? AppColors.textMuted : AppColors.accent,
                ),
              ),
            ],
          ),
          if (!c.isOver)
            InkWell(
              onTap: onCopyCode,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  children: [
                    Text(
                      'Code: ${c.code}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(
                      Icons.copy_rounded,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          for (final s in c.standings)
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.xs),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: s.isYou
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Text(_medal(s.rank), style: AppTextStyles.h3),
                  ),
                  Text(
                    Species.emoji(s.speciesKey),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      s.isYou ? '${s.petName} (you)' : s.petName,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  Text('${s.score} 🥗', style: AppTextStyles.h3),
                ],
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: busy ? null : onLeave,
              child: Text(
                'Leave',
                style: AppTextStyles.caption.copyWith(color: AppColors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _medal(int rank) => switch (rank) {
    1 => '🥇',
    2 => '🥈',
    3 => '🥉',
    _ => '$rank',
  };

  String _timeLeft(ChallengeEntity c) {
    if (c.isOver) return 'Ended';
    final left = c.endsAt.difference(DateTime.now());
    if (left.inDays >= 1) {
      return left.inDays == 1 ? '1 day left' : '${left.inDays} days left';
    }
    if (left.inHours >= 1) return '${left.inHours}h left';
    return '${left.inMinutes}m left';
  }
}
