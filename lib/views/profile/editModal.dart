import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/components/customButton.dart';
import 'package:totalpass/components/customField.dart';
import 'package:totalpass/repositories/userRepository.dart';

import '../../components/CustomBar.dart';
import '../../services/auth_service.dart';

class Modal {
  static void showModal(BuildContext context) {
    final email = TextEditingController();
    final senha = TextEditingController();
    final formKey = GlobalKey<FormState>();

    updateEmail() async {
      try {
        await context.read<AuthService>().updateEmail(email.text, senha.text);
        Navigator.pop(context);
      } on AuthException catch (e) {
        CustomBar.showAlert(
          title: 'Opss!',
          message: e.message,
          icon: const Icon(Icons.error),
          context: context,
        );
      }
    }

    showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height - 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                'Editar email',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: email,
                style: Theme.of(context).textTheme.headline2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Novo email',
                  errorStyle: TextStyle(fontSize: 15),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o email corretamente!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: senha,
                style: Theme.of(context).textTheme.headline2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Sua senha',
                  errorStyle: TextStyle(fontSize: 15),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite sua senha!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: 'Cancelar',
                    solid: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    text: 'Salvar',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await updateEmail();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
