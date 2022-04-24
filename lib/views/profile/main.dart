import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/components/customAlert.dart';
import 'package:totalpass/services/auth_service.dart';
import 'package:totalpass/views/profile/editModal.dart';

import '../../components/customButton.dart';
import '../../repositories/userRepository.dart';
import '../auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                    child: Text(
                      context.read<AuthService>().getEmail(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: Colors.grey),
                    ),
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
                      content: Text(
                        'Todos os seus dados serão perdidos',
                        style: Theme.of(context).textTheme.headline2,
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
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onTap: () => Navigator.pop(context),
                                text: 'Não',
                                solid: false,
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: () {},
                                text: 'Sim',
                              ),
                            ],
                          ),
                        ),
                      ],
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
