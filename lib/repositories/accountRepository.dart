import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../models/account.dart';
import '../components/CustomBar.dart';
import '../database/db.dart';
import '../database/db_firestore.dart';
import '../services/auth_service.dart';

class AccountRepository extends ChangeNotifier {
  late Database db;

  AccountRepository({required this.auth}) {
    _initRepository();
  }

  _initRepository() async {
    await _startFirestore();
    await _readContas();

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

//--------------------------- SQLite -----------------------------------------

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

//--------------------------- Firestore --------------------------------------

  late FirebaseFirestore dbFire;
  late AuthService auth;

  _startFirestore() {
    dbFire = DBFirestore.get();
  }

  _readContas() async {
    if (auth.usuario != null && _contas.isEmpty) {
      final snapshot =
          await dbFire.collection('usuarios/${auth.usuario!.uid}/contas').get();
      snapshot.docs.forEach((doc) {
        Account contaAux = Account(
          id: int.parse(doc.id),
          name: doc.get('nome'),
          login: doc.get('login'),
          password: doc.get('senha'),
        );
        _contas.add(contaAux);
        setFireLoading(false);
        notifyListeners();
      });
    }
  }

  Future<String> proximoID() async {
    final snapshot =
        await dbFire.collection('usuarios/${auth.usuario!.uid}/contas').get();
    if (snapshot.size > 0) {
      String ultimoID = snapshot.docs.last.id;
      int novoID = int.parse(ultimoID) + 1;
      return novoID.toString();
    } else {
      return '1';
    }
  }

  recarregaContas() async {
    setFireLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _contas.clear();
    await _readContas();
    notifyListeners();
    setAddLoading(false);
  }

  addContaFire(String nome, String login, String senha) async {
    await dbFire
        .collection('usuarios/${auth.usuario!.uid}/contas')
        .doc(await proximoID())
        .set({'nome': nome, 'login': login, 'senha': senha});
  }

  editContaFire(int id, String nome, String login, String senha) async {
    await dbFire
        .collection('usuarios/${auth.usuario!.uid}/contas')
        .doc(id.toString())
        .set({'nome': nome, 'login': login, 'senha': senha});
  }

  removeContaFire(int id) async {
    await dbFire
        .collection('usuarios/${auth.usuario!.uid}/contas')
        .doc(id.toString())
        .delete();
    await recarregaContas();
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

  bool addLoading = false;
  bool loadingFireAccount = true;

  int cId = -1;
  bool cOn = false;

  void addConta(BuildContext context, {bool feedback = true}) async {
    String check = checkAddFields();

    if (check == 'Ok') {
      setAddLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));
      if (addOnline) {
        await addContaFire(nomeAddController.text, loginAddController.text,
            senhaAddController.text);
        await recarregaContas();
      } else {
        addContaBD(nomeAddController.text, loginAddController.text,
            senhaAddController.text);
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
      setAddLoading(false);
    } else {
      CustomBar.showAlert(
        title: 'Opss!',
        message: check + ' não pode ser vazio',
        icon: const Icon(Icons.error),
        context: context,
      );
    }
  }

  void editConta(BuildContext context) async {
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
          await editContaFire(cId, nomeEditController.text,
              loginEditController.text, senhaEditController.text);
          await recarregaContas();
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
    cOn = on;
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
    cOn ? await removeContaFire(cId) : await deletarContaBD(cId);
    //Navigator.pop(context);
    clearEdit();
    notifyListeners();
    if (feedback) {
      CustomBar.showAlert(
        title: 'Sucesso!',
        message: 'Conta excluída',
        icon: const Icon(Icons.done_rounded),
        context: context,
      );
    }
  }

  // findIndex(List<Account> lista, int id) {
  //   for (int i = 0; i < lista.length; i++) {
  //     if (lista[i].id == id) {
  //       return i;
  //     }
  //   }
  //   return -1;
  // }

  // int nextId() {
  //   int id;
  //   if (contas.isNotEmpty) {
  //     id = contas[contas.length - 1].id + 1;
  //     return id;
  //   }
  //   return 1;
  // }

  // int nextOff() {
  //   int id;
  //   if (contasOff.isNotEmpty) {
  //     id = contasOff[contasOff.length - 1].id + 1;
  //     return id;
  //   }
  //   return 1;
  // }

  void setAddLoading(bool value) {
    if (addLoading != value) {
      addLoading = value;
      notifyListeners();
    }
  }

  void setFireLoading(bool value) {
    if (loadingFireAccount != value) {
      loadingFireAccount = value;
      notifyListeners();
    }
  }
}
