import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class AccountTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback? onTap;
  AccountTile({required this.text, required this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        title: Text(text.isEmpty ? S.of(context).username : text),
        trailing: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ),
      ),
    );
  }
}
