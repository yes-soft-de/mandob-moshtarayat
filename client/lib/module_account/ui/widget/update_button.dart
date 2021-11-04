import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;
  UpdateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).cardColor.withOpacity(0.2),
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
            ]),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 65,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressed,
              child: Text(
                '${S.of(context).updateYourData}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
