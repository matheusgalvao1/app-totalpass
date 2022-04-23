import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../selected/main.dart';
import '../../components/customField.dart';
import '../../repositories/accountRepository.dart';

import 'accountCard.dart';
import 'offAccountCard.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late AccountRepository contas; //////////////////////
  List<Account> contasLocais = []; ////////////////////

  @override
  Widget build(BuildContext context) {
    contas = context.watch<AccountRepository>(); //////////////////////

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
                    value: repositorio.showOnline,
                    onChanged: (value) => repositorio.setShowOnline(value),
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
                        return repositorio.showOnline
                            ? AccountCard(
                                account: repositorio.contas[accountIndex],
                                onTap: () {
                                  repositorio.setSelectedAccount(
                                      repositorio.contas[accountIndex]);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: ((context) => SelectedPage()),
                                    ),
                                  );
                                },
                              )
                            : OffAccountCard(
                                account: repositorio.contasOff[accountIndex],
                                onTap: () {
                                  repositorio.setSelectedAccount(
                                      repositorio.contasOff[accountIndex]);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: ((context) => SelectedPage()),
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
                      itemCount: repositorio.showOnline
                          ? repositorio.contas.length
                          : repositorio.contasOff.length,
                    ),
            ),
          ],
        );
      },
    );
  }

  loadContas() {
    contasLocais = contas.contasLocais;
  }
}
