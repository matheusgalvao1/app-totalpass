import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totalpass/components/customButton.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    required this.controller,
    this.value = "",
  });

  String value;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 140,
            child: TextField(
              controller: controller,
              cursorColor: Theme.of(context).colorScheme.primary,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                hintText: 'Senha',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.grey),
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
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Aleatória',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white, //.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
