import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/core/constants.dart';

class NoteToolbar extends StatelessWidget {
  const NoteToolbar({super.key, required this.quillController});

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: primary, offset: Offset(4, 4))],
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconData: Icons.rotate_left,
              iconSize: 22,
              tooltip: 'Undo',
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconData: Icons.rotate_right,
              iconSize: 22,
              tooltip: 'Redo',
            ),
            bold: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            italic: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            underLine: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            strikeThrough: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            color: QuillToolbarColorButtonOptions(iconSize: 22),
            backgroundColor: QuillToolbarColorButtonOptions(iconSize: 22),
            clearFormat: QuillToolbarClearFormatButtonOptions(iconSize: 22),
            listNumbers: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            listBullets: QuillToolbarToggleStyleButtonOptions(iconSize: 22),
            search: QuillToolbarSearchButtonOptions(iconSize: 22),
          ),
        ),
      ),
    );
  }
}
