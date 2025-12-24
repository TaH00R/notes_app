import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        disabledBackgroundColor: gray300,
        disabledForegroundColor: black,
        side: BorderSide(color: black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: child,
    );
  }
}
