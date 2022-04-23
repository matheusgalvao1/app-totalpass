import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../models/account.dart';
import '../components/CustomBar.dart';
import '../database/db.dart';

class AccountRepository extends ChangeNotifier {
  late Database db;

  AccountRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
    List contasDoBanco = await db.query('contas');
    _contasOff.clear();
    for (var c in contasDoBanco) {
      _contasOff.add(Account(
        id: c['id'],
        name: c['nome'],
        login: c['login'],
        password: c['senha'],
      ));
    }
  }

  void addContaBD(String nome, String login, String senha) async {
    int id = await db.insert('contas', {
      'nome': nome,
      'login': login,
      'senha': senha,
    });
    Account c = Account(
      id: id,
      name: nome,
      login: login,
      password: senha,
    );
    _contasOff.add(c);
  }

  void editContaBD(int id, String nome, String login, String senha) async {
    await db.update(
      'contas',
      {
        'nome': nome,
        'login': login,
        'senha': senha,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletarContaBD(int id) async {
    int res = await db.delete('contas', where: 'id = ?', whereArgs: [id]);
    _initRepository();
  }

//----------------------------------------------------------------------------
  final List<Account> _contas = [];

  final List<Account> _contasOff = [];

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

  int cId = -1;
  bool cOn = false;

  void addConta(BuildContext context, {bool feedback = true}) {
    String check = checkAddFields();

    if (check == 'Ok') {
      if (addOnline) {
        _contas.add(
          Account(
            id: nextId(),
            name: nomeAddController.text,
            login: loginAddController.text,
            password: senhaAddController.text,
          ),
        );
      } else {
        addContaBD(nomeAddController.text, loginAddController.text,
            senhaAddController.text);
        /*
        _contasOff.add(
          Account(
            id: nextOff(),
            name: nomeAddController.text,
            login: loginAddController.text,
            password: senhaAddController.text,
          ),
        );
        */
      }
      clearAdd();
      if (feedback) {
        CustomBar.showAlert(
          title: 'Sucesso!',
          message: 'Conta adicionada',
          icon: const Icon(Icons.done_rounded),
          context: context,
        );
      }
      notifyListeners();
    } else {
      CustomBar.showAlert(
        title: 'Opss!',
        message: check + ' não pode ser vazio',
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  void editConta(BuildContext context) {
    String check = checkEditFields();
    if (check == 'Ok') {
      if (cOn != editOnline) {
        nomeAddController.text = nomeEditController.text;
        loginAddController.text = loginEditController.text;
        senhaAddController.text = senhaEditController.text;
        addOnline = editOnline;
        removeConta(context, feedback: false);
        addConta(context, feedback: false);
        CustomBar.showAlert(
          title: 'Sucesso!',
          message: 'Conta editada',
          icon: const Icon(Icons.done_rounded),
          context: context,
        );
      } else {
        if (cOn) {
          // contas[index].name = nomeEditController.text;
          // contas[index].login = loginEditController.text;
          // contas[index].password = senhaEditController.text;
        } else {
          editContaBD(cId, nomeEditController.text, loginEditController.text,
              senhaEditController.text);
          _initRepository();
        }
        clearAdd();
        CustomBar.showAlert(
          title: 'Sucesso!',
          message: 'Conta editada',
          icon: const Icon(Icons.done_rounded),
          context: context,
        );
        notifyListeners();
      }
    } else {
      CustomBar.showAlert(
        title: 'Opss!',
        message: check + ' não pode ser vazio',
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  String checkAddFields() {
    if (nomeAddController.text.isEmpty) {
      return 'Nome';
    }
    if (loginAddController.text.isEmpty) {
      return 'Login';
    }
    if (senhaAddController.text.isEmpty) {
      return 'Senha';
    }
    return 'Ok';
  }

  String checkEditFields() {
    if (nomeEditController.text.isEmpty) {
      return 'Nome';
    }
    if (loginEditController.text.isEmpty) {
      return 'Login';
    }
    if (senhaEditController.text.isEmpty) {
      return 'Senha';
    }
    return 'Ok';
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

  void setSelectedAccount(Account conta, bool on) {
    cId = conta.id;
    editOnline = on;
    nomeEditController.text = conta.name;
    loginEditController.text = conta.login;
    senhaEditController.text = conta.password;
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

  Future<void> removeConta(BuildContext context, {bool feedback = true}) async {
    cOn ? print('fazer') : await deletarContaBD(cId);
    Navigator.pop(context);
    clearEdit();
    notifyListeners();
    if (feedback)
      CustomBar.showAlert(
        title: 'Sucesso!',
        message: 'Conta excluída',
        icon: const Icon(Icons.done_rounded),
        context: context,
      );
  }

  findIndex(List<Account> lista, int id) {
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  int nextId() {
    int id;
    if (contas.isNotEmpty) {
      id = contas[contas.length - 1].id + 1;
      return id;
    }
    return 1;
  }

  int nextOff() {
    int id;
    if (contasOff.isNotEmpty) {
      id = contasOff[contasOff.length - 1].id + 1;
      return id;
    }
    return 1;
  }
}
