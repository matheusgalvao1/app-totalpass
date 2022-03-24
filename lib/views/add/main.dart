import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/models/account.dart';

import '../../components/customButton.dart';
import '../../components/customField.dart';
import '../../components/passwordField.dart';
import '../../repositories/accountRepository.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child:
          Consumer<AccountRepository>(builder: (context, repositorio, child) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/logo/lock.svg',
                  height: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  'Nova Conta',
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
              controller: repositorio.nomeAddController,
            ),
            const SizedBox(height: 10),
            CustomField(
              hint: 'Login',
              controller: repositorio.loginAddController,
            ),
            const SizedBox(height: 10),
            PasswordField(
              controller: repositorio.senhaAddController,
              add: true,
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
                  value: repositorio.addOnline,
                  onChanged: (value) => repositorio.setAddOnline(value),
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
                  onTap: () {
                    repositorio.addConta();
                  },
                  text: 'Adicionar',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
