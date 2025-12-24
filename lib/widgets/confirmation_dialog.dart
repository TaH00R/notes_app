import 'package:flutter/material.dart';

import 'dialog_card.dart';
import 'note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0), // ✅ breathing space
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: 12),

            const Divider(height: 1),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NoteButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                const SizedBox(width: 12),
                NoteButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
