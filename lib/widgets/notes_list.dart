import 'package:flutter/material.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/widgets/notes_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    required this.notes,
    super.key});

  final List<Note> notes; 
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return NotesCard(
          note: notes[index],
          isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}
