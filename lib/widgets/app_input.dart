import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput(
      {super.key,
      required this.controller,
      this.labelText,
      this.prefixIcon,
      this.validator,
      this.keyboardType,
      this.obscureText = false});
  final TextEditingController controller;
  final String? labelText;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
    );
  }
}
