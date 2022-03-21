import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 15,
      ),
      children: [
        SvgPicture.asset(
          'lib/assets/logo/lock.svg',
          height: 80,
        ),
        const SizedBox(height: 15),
        const Text(
          'Matheus Galvão',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        const SpinKitFadingCircle(
          color: Color(0xFF329239),
          size: 50.0,
        ),
      ],
    );
  }
}
