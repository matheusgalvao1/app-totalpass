import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../repositories/accountRepository.dart';
import '../utility/CustomTheme.dart';
import '../views/home/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => AccountRepository(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Totalpass',
      darkTheme: CustomTheme.dark,
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}
