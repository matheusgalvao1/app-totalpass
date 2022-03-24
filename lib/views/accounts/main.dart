import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../selected/main.dart';
import '../../components/customField.dart';
import '../../repositories/accountRepository.dart';

import 'accountCard.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = AccountRepository.accounts;

    return Consumer<AccountRepository>(
      builder: (context, repositorio, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 15,
                right: 15,
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 147,
                    child: CustomField(
                      hint: 'Pesquisar',
                      search: true,
                      controller: TextEditingController(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: false
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50.0,
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int accountIndex) {
                        return AccountCard(
                          account: repositorio.contas[accountIndex],
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: ((context) => SelectedPage(
                                      account: repositorio.contas[accountIndex],
                                    )),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                      itemCount: repositorio.contas.length,
                    ),
            ),
          ],
        );
      },
    );
  }
}
