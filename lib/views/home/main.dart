import 'package:flutter/material.dart';

import '../accounts/main.dart';
import '../add/main.dart';
import '../profile/main.dart';

import 'navBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          //physics: const NeverScrollableScrollPhysics(),
          children: const [
            AccountsPage(),
            AddPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
}
