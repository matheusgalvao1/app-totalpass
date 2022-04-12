import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:totalpass/repositories/userRepository.dart';

import '../repositories/accountRepository.dart';
import '../utility/CustomTheme.dart';
import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/home/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    //Provider.debugCheckInvalidValueType = null;

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountRepository>(
              create: (context) => AccountRepository()),
          ChangeNotifierProvider<UserRepository>(
              create: (context) => UserRepository()),
        ],
        child: MyApp(),
      ),
    );
  });
}

// ACHO Q O AUDIO BUGOU DNV

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Totalpass',
      darkTheme: CustomTheme.dark,
      themeMode: ThemeMode.dark,
      home: const LoginPage(),
    );
  }
}
