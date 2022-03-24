import 'dart:collection';

import 'package:flutter/material.dart';

import '../../models/account.dart';

class AccountRepository extends ChangeNotifier {
//----------------------------------------------------------------------------
  final List<Account> _contas = [
    Account(
      name: 'Biscoint',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: true,
    ),
  ];

  final List<Account> _contasOff = [
    Account(
      name: 'Binance',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: false,
    ),
  ];

  UnmodifiableListView<Account> get contas => UnmodifiableListView(_contas);
  UnmodifiableListView<Account> get contasOff =>
      UnmodifiableListView(_contasOff);

  TextEditingController nomeAddController = TextEditingController();
  TextEditingController loginAddController = TextEditingController();
  TextEditingController senhaAddController = TextEditingController();

  bool addOnline = true;
  bool showOnline = true;

  void addConta() {
    if (addOnline) {
      _contas.add(
        Account(
          name: nomeAddController.text,
          login: loginAddController.text,
          password: senhaAddController.text,
          online: addOnline,
        ),
      );
    } else {
      _contasOff.add(
        Account(
          name: nomeAddController.text,
          login: loginAddController.text,
          password: senhaAddController.text,
          online: addOnline,
        ),
      );
    }
    nomeAddController.clear();
    loginAddController.clear();
    senhaAddController.clear();
    setAddOnline(true);
    notifyListeners();
  }

  void setAddOnline(bool value) {
    if (addOnline != value) {
      addOnline = value;
      notifyListeners();
    }
  }

  void setShowOnline(bool value) {
    if (showOnline != value) {
      showOnline = value;
      notifyListeners();
    }
  }

  void removeConta(Account conta) {
    _contas.remove(conta);
    notifyListeners();
  }

//----------------------------------------------------------------------------
  static List<Account> accounts = accountsOffline + accountsOnline;

  static List<Account> accountsOffline = [
    Account(
      name: 'Biscoint',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: false,
    ),
    Account(
      name: 'Coinbase',
      login: 'matheusgalvao@email.com',
      password: 'goodam',
      online: false,
    ),
    Account(
      name: 'Binance',
      login: 'matheusgalvao@gmail.com',
      password: 'facesss',
      online: false,
    ),
  ];

  static List<Account> accountsOnline = [
    Account(
      name: 'Instagram',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: true,
    ),
    Account(
      name: 'Facebook',
      login: 'matheusgalvao@email.com',
      password: 'goodam',
      online: true,
    ),
    Account(
      name: 'Google',
      login: 'matheusgalvao@gmail.com',
      password: 'facesss',
      online: true,
    ),
    Account(
      name: 'Moodle',
      login: 'matheusgalvao@utfpr.com',
      password: 'sortasas',
      online: true,
    ),
    Account(
      name: 'Twitter',
      login: 'galvao',
      password: 'fdsafdafddas',
      online: true,
    ),
  ];
}
