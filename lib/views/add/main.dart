import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/customButton.dart';
import '../../components/customField.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Nova Conta',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          CustomField(
            hint: 'Nome',
          ),
          const SizedBox(height: 10),
          CustomField(
            hint: 'Login',
          ),
          const SizedBox(height: 10),
          CustomField(
            hint: 'Senha',
            password: true,
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
                color: Colors.green,
                text: 'Adicionar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
