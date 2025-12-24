import 'package:flutter/material.dart';
import 'package:notes_app/widgets/note_icon_widget.dart';

class NoteBackButton extends StatelessWidget {
  const NoteBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NotesIconButton(
        icon: Icons.chevron_left,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
