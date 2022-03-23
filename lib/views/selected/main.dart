import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/customButton.dart';
import '../../components/customField.dart';
import '../../components/passwordField.dart';
import '../../models/account.dart';

class SelectedPage extends StatelessWidget {
  SelectedPage({required this.account});

  Account account;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/logo/lock.svg',
                  height: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  'Editar Conta',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomField(
              hint: 'Nome',
              value: account.name,
            ),
            const SizedBox(height: 10),
            CustomField(
              hint: 'Login',
              value: account.login,
            ),
            const SizedBox(height: 10),
            PasswordField(
              value: account.password,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Armazenar online',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {},
                  solid: false,
                  text: 'Cancelar',
                ),
                const SizedBox(width: 15),
                CustomButton(
                  onTap: () {},
                  text: 'Salvar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
