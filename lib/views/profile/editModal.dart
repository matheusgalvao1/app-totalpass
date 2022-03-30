import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/components/customButton.dart';
import 'package:totalpass/components/customField.dart';
import 'package:totalpass/repositories/userRepository.dart';

class Modal {
  static void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      //isScrollControlled: true,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        height: 450,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Consumer<UserRepository>(builder: (context, repositorio, child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              CustomField(
                controller: repositorio.editEmail,
                hint: 'Email',
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
                    onTap: () => repositorio.saveEmail(context),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}