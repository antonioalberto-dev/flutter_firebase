import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final labelText, hinterText;
  final TextEditingController controller;

  TextFieldItem({
    required this.labelText,
    this.hinterText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) return "The $labelText is required";
      },
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hinterText,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
          prefixIcon: const Icon(Icons.email, color: Colors.purple)),
    );
  }
}
