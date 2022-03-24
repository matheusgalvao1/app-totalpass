import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../components/customButton.dart';
import '../../views/auth/register.dart';
import '../../views/home/main.dart';
import '../../components/customField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        children: [
          SvgPicture.asset(
            'lib/assets/logo/lock.svg',
            height: 80,
          ),
          const SizedBox(height: 15),
          Text(
            'Login',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 30),
          //TextField(),
          CustomField(
            hint: 'Email',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 10),
          CustomField(
            hint: 'Senha',
            password: true,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Entrar',
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: ((context) => const Home())));
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: ((context) => const RegisterPage())));
            },
            child: Text(
              'Registrar',
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}