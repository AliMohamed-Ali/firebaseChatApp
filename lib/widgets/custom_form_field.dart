import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.validationRegex,
    this.obsecureText = false,
    this.onSaved,
  });
  final String hintText;
  final double height;
  final RegExp validationRegex;
  final bool obsecureText;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obsecureText,
        validator: (value) {
          if (value == null || validationRegex.hasMatch(value)) {
            return null;
          }
          return 'Please enter valid ${hintText.toLowerCase()}';
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
