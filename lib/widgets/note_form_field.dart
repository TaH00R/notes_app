import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    this.hintText,
    this.tagController,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.fillColor,
    this.filled,
    this.labelText,
    this.suffixIcon,
    this.obscureText,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController? tagController;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final Color? fillColor;
  final bool? filled;
  final String? labelText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      key: key,
      controller: tagController,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor ,
        labelText: labelText,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
    );
  }
}
