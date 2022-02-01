import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

Widget showAll(BuildContext context) {
  return Hider(
    active: false,
    child: Container(
      width: 75,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Center(
        child: Text(
          S.of(context).showAll,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
