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
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: search
            ? Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.primary,
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
          borderSide: BorderSide(
            width: 3,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
