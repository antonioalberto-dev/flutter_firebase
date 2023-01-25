import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldItem extends StatelessWidget {
  final labelText, hinterText;
  final TextEditingController controller;
  final IconData icon;

  const TextFieldItem({super.key, 
    required this.labelText,
    this.hinterText,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: (value) {
      //   if (value!.isEmpty) return "The $labelText is required";
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hinterText,
        labelStyle: GoogleFonts.ubuntu(),
        hintStyle: GoogleFonts.ubuntu(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.red),
        ),
        prefixIcon: Icon(icon, color: Colors.blue[600]),
      ),
    );
  }
}
