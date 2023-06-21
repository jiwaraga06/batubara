import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hint, label, messageError;
  bool? obscureText;
  Widget? prefixIcon, suffixIcon;
  Color? color;
  CustomFormField({
    super.key,
    this.controller,
    this.hint,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.messageError,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint!,
        labelText: label!,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color!, width: 2),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return messageError;
        }
        return null;
      },
    );
  }
}
