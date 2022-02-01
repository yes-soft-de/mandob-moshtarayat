import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? message;
  CustomAlertDialog(
      {required this.onPressed,  this.message});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 750),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.bounceIn,
      builder: (context, double val, child) {
        return Transform.scale(
          scale: val,
          child: child,
        );
      },
      child: AlertDialog(
        title: Text(S.current.warnning),
        content: Container(child: Text(message ?? S.current.sureForDelete)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          TextButton(onPressed: onPressed, child: Text(S.current.confirm)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.cancel)),
        ],
      ),
    );
  }
}
class CustomAlertNoAcDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? message;
  CustomAlertNoAcDialog(
      {required this.onPressed,  this.message});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 750),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.bounceIn,
      builder: (context, double val, child) {
        return Transform.scale(
          scale: val,
          child: child,
        );
      },
      child: AlertDialog(
        title: Text(S.current.warnning),
        content: Container(child: Text(message ?? S.current.sureForDelete)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          TextButton(onPressed: onPressed, child: Text(S.current.confirm)),
        ],
      ),
    );
  }
}