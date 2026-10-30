import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_trophies_usecase.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Your league season wins, on the profile. A one-off read with no state to
// share, so it fetches directly rather than through a cubit.
class TrophyShelf extends StatefulWidget {
  const TrophyShelf({super.key});

  @override
  State<TrophyShelf> createState() => _TrophyShelfState();
}

class _TrophyShelfState extends State<TrophyShelf> {
  late final Future<List<TrophyEntity>> _trophies = sl<FetchTrophiesUseCase>()
      .call()
      .then((result) => result.getOrElse(() => const []));

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMM d');
    return FutureBuilder<List<TrophyEntity>>(
      future: _trophies,
      builder: (context, snapshot) {
        final trophies = snapshot.data ?? const [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trophies', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.md),
            GlassCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : trophies.isEmpty
                  ? Text(
                      'Win a week in a friend league to earn your first '
                      'trophy 🏆',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                    )
                  : Column(
                      children: [
                        for (final t in trophies)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xs,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  '🏆',
                                  style: TextStyle(fontSize: 26),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    t.leagueName,
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                ),
                                Text(
                                  'Week of ${format.format(t.weekStart)} · '
                                  '${t.score} pts',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
