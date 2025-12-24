import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/dialogs.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/pages/new_edit_page.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widgets/no_notes.dart';
import 'package:notes_app/widgets/note_icon_widget.dart';
import 'package:notes_app/widgets/notes_grid.dart';
import 'package:notes_app/widgets/notes_list.dart';
import 'package:notes_app/widgets/search_field.dart';
import 'package:notes_app/widgets/view_options.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> dropdownOptions = ['Date Modified', 'Date Created'];
  late String dropdownValue = dropdownOptions.first;
  bool isDescending = true;
  bool isGrid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES',
        style: GoogleFonts.caveat(),),
        actions: [
          NotesIconButton(icon: FontAwesomeIcons.arrowRightToBracket, onPressed: () async {
            final bool shouldLogout = await showConfirmationDialog(context: context, title: "Are you sure you want to log out?") ?? false;
            if (shouldLogout) {
              AuthService.logout();
            }
          }),
        ],
      ),
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: black, offset: Offset(4, 4))],
          borderRadius: BorderRadius.circular(16),
        ),

        child: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: NewEditPage(isNewNote: true,))),
            );
          },
          backgroundColor: primary,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
            side: BorderSide(color: black),
          ),
          child: Icon(Icons.add),
        ),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) { 
          final List<Note> notes = notesProvider.notes;
          return  Padding(
          padding: const EdgeInsets.all(16.0),
          child: notes.isEmpty && notesProvider.searchTerm.isEmpty ? NoNotes(): Column(
            children: [
              SearchField(),
              if(notes.isNotEmpty)...[
              ViewOptions(),
              Expanded(child: notesProvider.isGrid ? NotesGrid(notes: notes,) : NotesList(notes: notes,)),
            ]
            else ...[
             Expanded(
              child: Center(
                child: Text('No notes found matching "${notesProvider.searchTerm}"',
                style: TextStyle(
                  color: gray700,
                  fontSize: 16,
                ),),
              ),
            )
            ]]
          ),
        );}
      ),
    );
  }
}


