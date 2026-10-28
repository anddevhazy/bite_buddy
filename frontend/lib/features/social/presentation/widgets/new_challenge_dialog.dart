import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

typedef NewChallenge = ({String name, int days});

// Asks for a challenge name and length. Null if the user cancels.
Future<NewChallenge?> showNewChallengeDialog(BuildContext context) {
  return showDialog<NewChallenge>(
    context: context,
    builder: (context) => const _NewChallengeDialog(),
  );
}

class _NewChallengeDialog extends StatefulWidget {
  const _NewChallengeDialog();

  @override
  State<_NewChallengeDialog> createState() => _NewChallengeDialogState();
}

class _NewChallengeDialogState extends State<_NewChallengeDialog> {
  // The server allows 1-30 days
  static const _lengths = [3, 7, 14, 30];

  final _controller = TextEditingController(text: 'Healthy Week');
  int _days = 7;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) Navigator.pop(context, (name: name, days: _days));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.card,
      title: Text('New challenge', style: AppTextStyles.h3),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 30,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Length', style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final days in _lengths)
                ChoiceChip(
                  label: Text('$days days'),
                  selected: _days == days,
                  selectedColor: AppColors.primary,
                  onSelected: (_) => setState(() => _days = days),
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _submit, child: const Text('Create')),
      ],
    );
  }
}
