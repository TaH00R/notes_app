import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key});

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();

    tagController = TextEditingController();
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Tags Here',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: gray900,
            ),
          ),
          const SizedBox(height: 12),

          NoteFormField(
            hintText: 'Add Tag (<16 Characters)',
            tagController: tagController,
            key: tagKey,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'No Tags Added';
              } else if (value.trim().length > 16) {
                return 'Tag Length Exceeded';
              }
              return null;
            },
            onChanged: (newValue) {
              tagKey.currentState?.validate();
            },
            autofocus: true,
          ),

          const SizedBox(height: 20),

          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(offset: Offset(2, 2), color: black)],
            ),
            child: NoteButton(
              child: Text('Add Tag'),
              onPressed: () {
                if (tagKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, tagController.text.trim());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
