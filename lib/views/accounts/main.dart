import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totalpass/components/customField.dart';

import '../../repositories/accountRepository.dart';

import 'accountCard.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = AccountRepository.accounts;

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
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int accountIndex) {
              return AccountCard(account: accounts[accountIndex]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF329239),
                ),
              );
            },
            itemCount: accounts.length,
          ),
        ),
      ],
    );
  }
}
