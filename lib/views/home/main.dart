import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'navBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // 80 de height
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 140 - 60,
            child: ListView(
              physics: const BouncingScrollPhysics(),
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
