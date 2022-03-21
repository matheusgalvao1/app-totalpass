import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.list_bullet,
            color: Theme.of(context).colorScheme.primary,
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
  }
}
