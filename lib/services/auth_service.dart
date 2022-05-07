import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/repositories/accountRepository.dart';

class AuthException implements Exception {
  String message;

  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  getEmail() {
    if (usuario != null) {
      return usuario?.email;
    }
  }

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado!');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta!');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  delete(String senha) async {
    try {
      await reAuth(senha);
      await usuario?.delete();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException('Não foi possível excluir a conta. Tente novamente!');
    }
  }

  updateEmail(String newEmail, String senha) async {
    try {
      await reAuth(senha);
      await usuario?.updateEmail(newEmail);
      _getUser();
    } on FirebaseAuthException catch (e) {
      print(e);
      throw AuthException('Não foi possível editar o email. Tente novamente!');
    }
  }

  reAuth(String senha) async {
    await usuario?.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: getEmail(), password: senha));
  }
}
