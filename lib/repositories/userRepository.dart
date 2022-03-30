import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/CustomBar.dart';
import '../models/user.dart';
import '../views/auth/login.dart';
import '../views/home/main.dart';

class UserRepository extends ChangeNotifier {
  ModelUser usuario = ModelUser(
    email: 'emailPadrao',
    senha: 'senhaPadrao',
    uid: 1,
  );

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginSenha = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerSenha = TextEditingController();

  void signIn(BuildContext context) {
    if (loginEmail.text == usuario.email && loginSenha.text == usuario.senha) {
      clearLogin();
      Navigator.push(
          context, CupertinoPageRoute(builder: ((context) => const Home())));
    } else {
      CustomBar.showAlert(
        title: 'Opss!',
        message: 'Email ou senha inválido',
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  void signUp(BuildContext context) {
    if (checkSignUp() == 'Ok') {
      usuario.email = registerEmail.text;
      usuario.senha = registerSenha.text;
      clearRegister();
      Navigator.push(context,
          CupertinoPageRoute(builder: ((context) => const LoginPage())));
    } else {
      CustomBar.showAlert(
        title: 'Opss!',
        message: checkSignUp(),
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  String checkSignUp() {
    if (registerEmail.text.isEmpty) return 'Email não pode ser vazio';
    if (registerSenha.text.isEmpty) return 'Senha não pode ser vazia';
    if (!validEmail(registerEmail.text)) return 'Email inválido';
    if (registerSenha.text.length < 6)
      return 'Senha deve conter pelo menos 6 caractéres';
    return 'Ok';
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void logOut(BuildContext context) {
    Navigator.push(
        context, CupertinoPageRoute(builder: ((context) => const LoginPage())));
  }

  void deleteAccount(BuildContext context) {
    usuario.email = 'emailPadrao';
    usuario.senha = 'senhaPadrao';
    notifyListeners();
    Navigator.push(
        context, CupertinoPageRoute(builder: ((context) => const LoginPage())));
    CustomBar.showAlert(
      title: 'Sucesso!',
      message: 'Sua conta foi excluída',
      icon: const Icon(Icons.error),
      context: context,
    );
  }

  void editEmail() {}

  void clearLogin() {
    loginEmail.clear();
    loginSenha.clear();
    notifyListeners();
  }

  void clearRegister() {
    registerEmail.clear();
    registerSenha.clear();
    notifyListeners();
  }
}
