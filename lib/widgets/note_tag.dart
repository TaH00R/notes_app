import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    required this.label,
    required this.onClose,
    super.key,
  });

  final String label;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: gray100,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.only(right: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: gray700),
          ),
          if(onClose!= null)...[
            SizedBox(width: 4),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: 12,
                color: gray700,
              ),
            ),
          ]
        ],
      ),
    );
  }
}