import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  CustomField({
    this.hint = "",
    this.password = false,
    this.search = false,
  });

  String hint;
  bool password, search;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: password,
      cursorColor: const Color(0xFF329239),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: search
            ? const Icon(
                CupertinoIcons.search,
                color: Color(0xFF329239),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 3,
            color: const Color(0xFF329239),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
