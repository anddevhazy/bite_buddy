import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/species.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:flutter/material.dart';

class FriendTile extends StatelessWidget {
  final FriendEntity friend;
  final bool busy;
  final VoidCallback onAccept;
  // Unfriend, decline or cancel, depending on the status
  final VoidCallback onRemove;

  const FriendTile({
    super.key,
    required this.friend,
    required this.busy,
    required this.onAccept,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final f = friend;
    return GlassCard(
      borderColor: f.status == FriendStatus.incoming ? AppColors.accent : null,
      child: Row(
        children: [
          Text(
            Species.emoji(f.speciesKey),
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.petName, style: AppTextStyles.h3),
                Text(
                  switch (f.status) {
                    FriendStatus.friends =>
                      'Level ${f.level} · 🍽️ ${f.nutrition} · 🔥 ${f.streak}',
                    FriendStatus.incoming => 'Wants to be your friend',
                    FriendStatus.outgoing => 'Request sent',
                  },
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          ...switch (f.status) {
            FriendStatus.friends => [
              if (f.sharedStreak > 0)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.xs),
                  child: Text(
                    '🔥 ${f.sharedStreak}',
                    style: AppTextStyles.h3.copyWith(color: AppColors.accent),
                  ),
                ),
              IconButton(
                tooltip: 'Remove friend',
                onPressed: busy ? null : () => _confirmRemove(context),
                icon: const Icon(
                  Icons.person_remove_rounded,
                  color: AppColors.textMuted,
                ),
              ),
            ],
            FriendStatus.incoming => [
              IconButton.filled(
                tooltip: 'Accept',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: busy ? null : onAccept,
                icon: const Icon(Icons.check_rounded, color: AppColors.white),
              ),
              IconButton(
                tooltip: 'Decline',
                onPressed: busy ? null : onRemove,
                icon: const Icon(Icons.close_rounded, color: AppColors.error),
              ),
            ],
            FriendStatus.outgoing => [
              TextButton(
                onPressed: busy ? null : onRemove,
                child: const Text('Cancel'),
              ),
            ],
          },
        ],
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('Remove ${friend.petName}?', style: AppTextStyles.h3),
        content: Text(
          'Your shared streak will be lost.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Remove',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) onRemove();
  }
}
