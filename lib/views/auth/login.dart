import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../components/CustomBar.dart';
import '../../models/account.dart';
import '../../repositories/accountRepository.dart';

import '../../repositories/userRepository.dart';
import '../../components/customButton.dart';
import '../../services/auth_service.dart';
import '../../views/home/main.dart';
import '../../components/customField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = "Bem vindo";
        actionButton = 'Login';
        toggleButton = 'Cadastrar nova conta';
      } else {
        titulo = "Crie sua conta";
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao login';
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      CustomBar.showAlert(
        title: 'Opss!',
        message: e.message,
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      CustomBar.showAlert(
        title: 'Opss!',
        message: e.message,
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'lib/assets/logo/lock.svg',
                    height: 80,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 10),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Email',
                        errorStyle: TextStyle(fontSize: 15),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Email inválido!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: TextFormField(
                      controller: senha,
                      obscureText: true,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle: TextStyle(fontSize: 15),
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            login();
                          } else {
                            registrar();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (loading)
                            ? [
                                const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SpinKitFadingCircle(
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ]
                            : [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    actionButton,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(
                      toggleButton,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepository>(
      builder: (context, repositorio, child) {
        return SafeArea(
          child: Scaffold(
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
                CustomField(
                  hint: 'Email',
                  controller: repositorio.loginEmail,
                ),
                const SizedBox(height: 10),
                CustomField(
                  hint: 'Senha',
                  password: true,
                  controller: repositorio.loginSenha,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Entrar',
                  onTap: () => repositorio.signIn(context),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
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
          ),
        );
      },
    );
  }
}
*/
