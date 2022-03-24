import 'package:flutter/material.dart';
import 'package:totalpass/models/account.dart';

class AccountCard extends StatefulWidget {
  AccountCard({
    required this.account,
    required this.onTap,
  });

  Account account;
  final GestureTapCallback? onTap;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  setShow() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .75,
                      child: Row(
                        children: [
                          !widget.account.online
                              ? Icon(
                                  Icons.wifi_off,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : const SizedBox(),
                          !widget.account.online
                              ? const SizedBox(width: 5)
                              : const SizedBox(),
                          Expanded(
                            child: Text(
                              widget.account.name,
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
                      widget.account.login,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    Text(
                      show
                          ? widget.account.password
                          : widget.account.password
                              .replaceAll(RegExp('[A-Za-z0-9]'), '*'),
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () => setShow(),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              radius: 1,
              child: Icon(
                show ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
