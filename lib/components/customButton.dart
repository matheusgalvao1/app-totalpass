import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.text,
    this.color = Colors.blue,
    required this.onTap,
    this.solid = true,
  });

  bool solid;
  String text;
  Color color;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          color: solid ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: !solid
              ? Border.all(
                  color: Colors.grey,
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
