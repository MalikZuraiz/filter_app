import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final Widget? suffixIcon; // Optional suffix icon parameter

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false, // Default is not a password field
    this.suffixIcon, // Optional suffix icon parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        border: const UnderlineInputBorder(), // Bottom border when unfocused
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Color when unfocused
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.blue, width: 2), // Color when focused
        ),
        suffixIcon: suffixIcon, // Add the suffixIcon here
      ),
    );
  }
}
