import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  CustomField({
    this.hint = "",
    this.password = false,
    this.search = false,
    this.value = "",
  });

  String hint, value;
  bool password, search;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: value),
      obscureText: password,
      cursorColor: Theme.of(context).colorScheme.primary,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        hintText: hint,
        hintStyle:
            Theme.of(context).textTheme.headline3?.copyWith(color: Colors.grey),
        prefixIcon: search
            ? Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
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
