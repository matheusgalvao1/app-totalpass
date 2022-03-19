import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accountCard.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const CupertinoSearchTextField(
            placeholder: 'Pesquisar',
          ),
        ),
        for (var i = 0; i < 20; i++)
          AccountCard(
            account: 'Instagram',
            login: 'matheusgalvao',
            password: '********',
          ),
      ],
    );
  }
}
