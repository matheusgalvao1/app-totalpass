import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/components/CustomBar.dart';
import 'package:totalpass/views/profile/editModal.dart';

import '../../components/customButton.dart';
import '../../repositories/userRepository.dart';
import '../auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepository>(builder: (context, repositorio, child) {
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
                        repositorio.usuario.email,
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
                  repositorio.openEdit();
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
                onTap: () => repositorio.deleteAccount(context),
              ),
              const SizedBox(width: 15),
              CustomButton(
                onTap: () => repositorio.logOut(context),
                text: 'Sair',
              ),
            ],
          ),
        ],
      );
    });
  }
}
