import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/utils.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/pages/new_edit_page.dart';
import 'package:notes_app/widgets/dialog_card.dart';
import 'package:notes_app/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({required this.note, required this.isInGrid, super.key});

  final Note note;
  final bool isInGrid;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  bool toDelete = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => 
              ChangeNotifierProvider(
                create: (context) => NewNoteController()..note = widget.note,
                child: NewEditPage(isNewNote: false,))),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: primary, offset: Offset(4, 4)),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.note.title!=null)...[
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              widget.note.title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: gray900,
              ),
            ),
            SizedBox(height: 4),],

            if(widget.note.tags != null)...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.note.tags!.length,
                  (index) => NoteTag(label: widget.note.tags![index],
                  onClose: null,),
                ),
              ),
            ),
            SizedBox(height: 4),],

            if(widget.note.content != null)
            widget.isInGrid ?
              Expanded(
                child: Text(widget.note.content!, style: TextStyle(color: gray700)),
              )
            :
              Text(
                widget.note.content!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: gray700),
              ),
              if(widget.isInGrid) Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(widget.note.dateModified),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogCard(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Are you sure you want to delete this note?"),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: gray300,
                                      ),
                                      child: Text("CANCEL", style: TextStyle(color: black),),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        context.read<NotesProvider>().deleteNote(widget.note);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Text("DELETE", style: TextStyle(color: white),),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete),
                  color: gray500,
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


