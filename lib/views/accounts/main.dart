import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repositories/accountRepository.dart';

import 'accountCard.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = AccountRepository.accounts;

    return ListView.builder(
      itemBuilder: (BuildContext context, int accountIndex) {
        return AccountCard(account: accounts[accountIndex]);
      },
      itemCount: accounts.length,
    );
  }
}
