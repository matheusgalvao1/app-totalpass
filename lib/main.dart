import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:totalpass/widgets/auth_check.dart';
import 'firebase_options.dart';

import '../services/auth_service.dart';
import '../repositories/userRepository.dart';
import '../repositories/accountRepository.dart';
import '../utility/CustomTheme.dart';
import '../views/auth/login.dart';
import '../views/home/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    //Provider.debugCheckInvalidValueType = null;

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthService(),
          ),
          ChangeNotifierProvider<AccountRepository>(
            create: (context) => AccountRepository(
              auth: context.read<AuthService>(),
            ),
          ),
          ChangeNotifierProvider<UserRepository>(
            create: (context) => UserRepository(),
          ),
        ],
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
      home: AuthCheck(),
    );
  }
}
