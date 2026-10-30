import 'package:bite_buddy/features/battle/presentation/pages/battle_arena_page.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/league/presentation/bloc/leagues_cubit.dart';
import 'package:bite_buddy/features/league/presentation/widgets/leagues_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// The Battle tab: the Arena against the computer, or Friends (leagues and
// friend battles)
class BattleTabPage extends StatefulWidget {
  const BattleTabPage({super.key});

  @override
  State<BattleTabPage> createState() => _BattleTabPageState();
}

class _BattleTabPageState extends State<BattleTabPage> {
  int _section = 0;

  @override
  Widget build(BuildContext context) {
    final waiting = context.select<LeaguesCubit, int>((c) => c.yourTurnCount);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppSpacing.radius),
              ),
              child: Row(
                children: [
                  _Segment(
                    label: '⚔️ Arena',
                    selected: _section == 0,
                    onTap: () => setState(() => _section = 0),
                  ),
                  _Segment(
                    label: waiting > 0 ? '🏆 Friends ($waiting)' : '🏆 Friends',
                    selected: _section == 1,
                    highlight: waiting > 0,
                    onTap: () => setState(() => _section = 1),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _section,
              children: const [BattleArenaPage(), LeaguesView()],
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final bool selected;
  final bool highlight;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : null,
            borderRadius: BorderRadius.circular(AppSpacing.radius - 4),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: !selected && highlight ? AppColors.accent : null,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
