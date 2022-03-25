import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/account.dart';

class AccountRepository extends ChangeNotifier {
//----------------------------------------------------------------------------
  final List<Account> _contas = [];

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

  TextEditingController nomeEditController = TextEditingController();
  TextEditingController loginEditController = TextEditingController();
  TextEditingController senhaEditController = TextEditingController();

  bool addOnline = true;
  bool editOnline = true;
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
    clearAdd();
    notifyListeners();
  }

  void clearAdd() {
    nomeAddController.clear();
    loginAddController.clear();
    senhaAddController.clear();
    setAddOnline(true);
    notifyListeners();
  }

  void clearEdit() {
    nomeEditController.clear();
    loginEditController.clear();
    senhaEditController.clear();
    setEditOnline(true);
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

  void setEditOnline(bool value) {
    if (editOnline != value) {
      editOnline = value;
      notifyListeners();
    }
  }

  void setAddRandom() {
    senhaAddController.text = randomPassword();
    notifyListeners();
  }

  void setEditRandom() {
    senhaEditController.text = randomPassword();
    notifyListeners();
  }

  void setSelectedAccount(Account conta) {
    nomeEditController.text = conta.name;
    loginEditController.text = conta.login;
    senhaEditController.text = conta.password;
    editOnline = conta.online;
    notifyListeners();
  }

  String randomPassword() {
    String letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@#_';
    var randomLetter = Random();
    var randomNum = Random();
    var randomBool = Random();
    String pass = '';
    int size = 8 + randomNum.nextInt(15);
    for (int i = 0; i < size; i++) {
      if (randomBool.nextBool()) {
        pass = pass + letters[randomLetter.nextInt(letters.length)];
      } else {
        pass = pass + randomNum.nextInt(10).toString();
      }
    }

    return pass;
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
