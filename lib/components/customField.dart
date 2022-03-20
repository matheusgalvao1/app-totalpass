import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  CustomField({
    this.hint = "",
    this.password = false,
  });

  String hint;
  bool password;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: password,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.blue),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
