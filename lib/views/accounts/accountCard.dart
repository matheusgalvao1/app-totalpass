import 'package:flutter/material.dart';
import 'package:totalpass/models/account.dart';

class AccountCard extends StatelessWidget {
  AccountCard({
    required this.account,
    this.hide = false,
    required this.onTap,
  });

  Account account;
  bool hide;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
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
                    Container(
                      width: MediaQuery.of(context).size.width * .75,
                      child: Row(
                        children: [
                          !account.online
                              ? Icon(
                                  Icons.wifi_off,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : const SizedBox(),
                          !account.online
                              ? const SizedBox(width: 5)
                              : const SizedBox(),
                          Expanded(
                            child: Text(
                              account.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    fontSize: 22,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      account.login,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    Text(
                      !hide ? account.password : '*******',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              radius: 1,
              child: Icon(
                Icons.visibility_off,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
