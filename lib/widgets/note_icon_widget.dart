import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NotesIconButton extends StatelessWidget {
  const NotesIconButton({
    required this.icon,
    this.onPressed,
    this.color,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed; 
  final Color? color; 

  bool get _isDisabled => onPressed == null;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: _isDisabled
            ? gray300 
            : primary,
        foregroundColor: _isDisabled
            ? Colors.white
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
