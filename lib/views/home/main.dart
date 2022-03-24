import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/accountRepository.dart';
import '../accounts/main.dart';
import '../add/main.dart';
import '../profile/main.dart';

part 'navBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int cPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: cPage);
  }

  setCurrentPage(page) {
    setState(() {
      cPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setCurrentPage,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            AccountsPage(),
            AddPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar:
            Consumer<AccountRepository>(builder: (context, repositorio, child) {
          return BottomNavigationBar(
            currentIndex: cPage,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            iconSize: 30,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: (page) {
              if (page == 1) {
                repositorio.clearAdd();
              }
              pc.animateToPage(
                page,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.list_bullet,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: '',
              ),
            ],
          );
        }),
      ),
    );
  }
}
