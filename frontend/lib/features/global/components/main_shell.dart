import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/league/presentation/bloc/leagues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// The five bottom tabs: My Pet, Collection, Scan, Battle, Profile. Battle
// shows a dot when a friend battle is waiting for your move.
class MainShell extends StatefulWidget {
  final StatefulNavigationShell shell;

  const MainShell({super.key, required this.shell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _battleTab = 3;

  static const _tabs = [
    (Icons.pets_rounded, 'My Pet'),
    (Icons.style_rounded, 'Collection'),
    (Icons.qr_code_scanner_rounded, 'Scan'),
    (Icons.sports_martial_arts_rounded, 'Battle'),
    (Icons.person_rounded, 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    // Load leagues once at start so the "your move" dot is right straight away
    context.read<LeaguesCubit>().load();
  }

  void _select(int index) {
    final shell = widget.shell;
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
    // Refresh turns whenever the Battle tab is opened
    if (index == _battleTab) context.read<LeaguesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final shell = widget.shell;
    final waiting = context.select<LeaguesCubit, int>((c) => c.yourTurnCount);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ForestBackground(child: shell),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.95),
          border: const Border(top: BorderSide(color: AppColors.glassBorder)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (final (i, (icon, label)) in _tabs.indexed)
                  Expanded(
                    child: InkWell(
                      onTap: () => _select(i),
                      child: _NavItem(
                        icon: icon,
                        label: label,
                        selected: i == shell.currentIndex,
                        dot: i == _battleTab && waiting > 0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool dot;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Badge(
          isLabelVisible: dot,
          backgroundColor: AppColors.accent,
          smallSize: 10,
          child: Icon(icon, color: color, size: selected ? 30 : 26),
        ),
        if (selected)
          Text(label, style: AppTextStyles.caption.copyWith(color: color)),
      ],
    );
  }
}
