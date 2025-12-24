import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/widgets/back_button.dart';
import 'package:notes_app/widgets/note_icon_widget.dart';
import 'package:notes_app/widgets/note_metadata.dart';
import 'package:notes_app/widgets/note_toolbar.dart';
import 'package:provider/provider.dart';

class NewEditPage extends StatefulWidget {
  const NewEditPage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewEditPage> createState() => _NewEditPageState();
}

class _NewEditPageState extends State<NewEditPage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final FocusNode focusNode;

  late final QuillController quillController = QuillController.basic()
    ..addListener(() {
      newNoteController.content = quillController.document;
    });

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNewNote) {
        newNoteController.readOnly = false;
        focusNode.requestFocus();
      } else {
        newNoteController.readOnly = true;
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NoteBackButton(),
        title: Text(widget.isNewNote ? "NEW NOTE" : "EDIT NOTE", style: GoogleFonts.kaushanScript(),),
        actions: [
          Selector<NewNoteController, bool>(
            selector: (_, controller) => controller.readOnly,
            builder: (_, readOnly, __) => NotesIconButton(
              icon: readOnly ? Icons.remove_red_eye : Icons.edit,
              onPressed: () {
                newNoteController.readOnly = !readOnly;
                !readOnly
                    ? FocusScope.of(context).unfocus()
                    : focusNode.requestFocus();
              },
            ),
          ),

          Selector<NewNoteController, bool>(
            selector: (_, controller) => controller.canSaveNote,
            builder: (_, canSave, __) => NotesIconButton(
              icon: Icons.check,
              color: canSave ? black : gray300,
              onPressed: canSave
                  ? () {
                      newNoteController.saveNote(context);
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Selector<NewNoteController, bool>(
              selector: (_, controller) => controller.readOnly,
              builder: (_, readOnly, __) => TextFormField(
                controller: titleController,
                readOnly: readOnly,
                canRequestFocus: !readOnly,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'TITLE HERE',
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  newNoteController.title = value;
                },
              ),
            ),

            
            NoteMetadata(note: newNoteController.note),

            const SizedBox(height: 8),
            Divider(color: gray700, thickness: 2),

            Expanded(
              child: Selector<NewNoteController, bool>(
                selector: (_, controller) => controller.readOnly,
                builder: (_, readOnly, __) => Focus(
                  canRequestFocus: !readOnly,
                  child: Column(
                    children: [
                      Flexible(
                        child: QuillEditor.basic(
                          controller: quillController,
                          focusNode: focusNode,
                          config: const QuillEditorConfig(
                            placeholder: 'Note Here...',
                            expands: true,
                          ),
                        ),
                      ),
                  
                      if (!readOnly)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: NoteToolbar(
                            quillController: quillController,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

