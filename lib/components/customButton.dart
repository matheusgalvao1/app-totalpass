import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.text,
    required this.onTap,
    this.solid = true,
  });

  bool solid;
  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        constraints: const BoxConstraints(
          minWidth: 130,
          minHeight: 60,
        ),
        decoration: BoxDecoration(
          color: solid
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: !solid
              ? Border.all(
                  color: Colors.grey.withOpacity(.5),
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: solid ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
