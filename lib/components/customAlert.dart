import 'package:flutter/material.dart';
import 'package:totalpass/components/customButton.dart';

class CustomAlert {
  void show(BuildContext context, String title, String content,
      final GestureTapCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.headline2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: () => Navigator.pop(context),
                    text: 'Não',
                    solid: false,
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    onTap: () => onTap,
                    text: 'Sim',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
