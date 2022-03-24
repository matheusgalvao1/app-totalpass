import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../repositories/accountRepository.dart';
import '../../components/customButton.dart';
import '../../components/customField.dart';
import '../../components/passwordField.dart';

class SelectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Consumer<AccountRepository>(builder: (context, repositorio, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                repositorio.clearEdit();
              },
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
              Text(
                'Nome',
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomField(
                hint: 'Nome',
                controller: repositorio.nomeEditController,
              ),
              const SizedBox(height: 10),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomField(
                hint: 'Login',
                controller: repositorio.loginEditController,
              ),
              const SizedBox(height: 10),
              Text(
                'Senha',
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              PasswordField(
                controller: repositorio.senhaEditController,
                add: false,
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
                    value: repositorio.editOnline,
                    onChanged: (value) => repositorio.setEditOnline(value),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                      repositorio.clearEdit();
                    },
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
        );
      }),
    );
  }
}
