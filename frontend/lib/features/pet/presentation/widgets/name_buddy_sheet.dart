import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

// Asks for the new buddy's name; pops with it
class NameBuddySheet extends StatefulWidget {
  final Widget picture;
  final String initialName;

  const NameBuddySheet({
    super.key,
    required this.picture,
    this.initialName = '',
  });

  @override
  State<NameBuddySheet> createState() => _NameBuddySheetState();
}

class _NameBuddySheetState extends State<NameBuddySheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialName,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.picture,
          Text('Name your buddy', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            maxLength: 20,
            textAlign: TextAlign.center,
            style: AppTextStyles.h3,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              counterStyle: AppTextStyles.caption,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.glassBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          GameButton(
            label: 'Adopt',
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) Navigator.pop(context, name);
            },
          ),
        ],
      ),
    );
  }
}
