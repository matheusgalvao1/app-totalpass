import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:totalpass/views/auth/login.dart';
import 'package:totalpass/views/home/main.dart';

import '../services/auth_service.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return Home();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.primary,
          size: 50.0,
        ),
      ),
    );
  }
}
