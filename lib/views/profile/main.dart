import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/components/customAlert.dart';
import 'package:totalpass/services/auth_service.dart';
import 'package:totalpass/views/profile/editModal.dart';

import '../../components/CustomBar.dart';
import '../../components/customButton.dart';
import '../../repositories/userRepository.dart';
import '../auth/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  delete() async {
    try {
      await context.read<AuthService>().delete(senha.text);
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

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          'TotalPass',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Consumer<AuthService>(
                        builder: (context, repositorio, child) {
                      return Text(
                        repositorio.getEmail() ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: Colors.grey),
                      );
                    }),
                  ),
                ],
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Modal.showModal(context);
              },
              child: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Excluir',
              solid: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Tem certeza?',
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      titlePadding: const EdgeInsets.only(top: 15, left: 15),
                      contentPadding: const EdgeInsets.all(15),
                      content: Form(
                        key: formKey,
                        child: SizedBox(
                          height: 215,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Todos os seus dados ser??o perdidos',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              TextFormField(
                                controller: senha,
                                style: Theme.of(context).textTheme.headline2,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelText: 'Senha',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    onTap: () => Navigator.pop(context),
                                    text: 'N??o',
                                    solid: false,
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        delete();
                                      }
                                    },
                                    text: 'Sim',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      // actions: <Widget>[
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //       bottom: 10,
                      //       left: 10,
                      //       right: 10,
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         CustomButton(
                      //           onTap: () => Navigator.pop(context),
                      //           text: 'N??o',
                      //           solid: false,
                      //         ),
                      //         const SizedBox(width: 10),
                      //         CustomButton(
                      //           color: Theme.of(context).colorScheme.secondary,
                      //           onTap: () async => delete(),
                      //           text: 'Sim',
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ],
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 15),
            CustomButton(
              onTap: () => context.read<AuthService>().logout(),
              text: 'Sair',
            ),
          ],
        ),
      ],
    );
  }
}
