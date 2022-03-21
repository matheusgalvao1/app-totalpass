import 'package:flutter/material.dart';
import 'package:totalpass/models/account.dart';

class AccountCard extends StatelessWidget {
  AccountCard({
    required this.account,
    this.hide = false,
  });

  Account account;
  bool hide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //     color: Colors.white,
              //   ),
              // ),
              // const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    account.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    account.login,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    !hide ? account.password : '*******',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.visibility_off,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
