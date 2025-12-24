import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/utils.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/widgets/dialog_card.dart';
import 'package:notes_app/widgets/new_tag_dialog.dart';
import 'package:notes_app/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({
    required this.note,
    super.key});

  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Last Modified',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      toLongDate(widget.note!.dateModified),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Created',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      toLongDate(widget.note!.dateCreated),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray500,
                        ),
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        onPressed: () async {
                          final String? tag = await showDialog<String?>(
                            context: context,
                            builder: (context) {
                              return DialogCard(child: NewTagDialog(),);
                            }, 
                          );
                          if(tag!=null){
                            newNoteController.addTag(tag);
                          }
                        },
                         
                        icon: Icon(Icons.add_circle),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        constraints: BoxConstraints(),
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        iconSize: 18,
                        color: gray700,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Selector<NewNoteController,List<String>>(
                    selector: (context, controller) => controller.tags,
                    builder: (context, tags, child) => tags.isEmpty ? Text(
                      'No Tags Added',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ) : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(tags.length, 
                        (index)=>NoteTag(
                          label: tags[index],
                          onClose: (){
                           newNoteController.removeTag(index);
                          },
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
      )],
    );
  }
}