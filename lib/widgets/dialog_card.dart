import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 360,
          ),
          child: Container(
            padding: const EdgeInsets.all(20), 
            decoration: BoxDecoration(
              color: white,
              border: Border.all(width: 2, color: black),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 6,
                  color: black,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
