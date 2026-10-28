import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:flutter/material.dart';

// Asks for a friend or challenge code. Null if the user cancels.
Future<String?> showCodeDialog(
  BuildContext context, {
  required String title,
  required String hint,
  required String action,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _CodeDialog(title: title, hint: hint, action: action),
  );
}

class _CodeDialog extends StatefulWidget {
  final String title;
  final String hint;
  final String action;

  const _CodeDialog({
    required this.title,
    required this.hint,
    required this.action,
  });

  @override
  State<_CodeDialog> createState() => _CodeDialogState();
}

class _CodeDialogState extends State<_CodeDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.isNotEmpty) Navigator.pop(context, code);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.card,
      title: Text(widget.title, style: AppTextStyles.h3),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        maxLength: 12,
        style: AppTextStyles.h3.copyWith(letterSpacing: 3),
        decoration: InputDecoration(hintText: widget.hint),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _submit, child: Text(widget.action)),
      ],
    );
  }
}
