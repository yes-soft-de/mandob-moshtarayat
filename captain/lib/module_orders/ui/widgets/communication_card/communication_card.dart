import 'package:flutter/material.dart';

class CommunicationCard extends StatelessWidget {
  final String text;
  final Widget? image;
  final Color? textColor;
  final Color? color;

  CommunicationCard({
    required this.text,
    this.image,
    this.textColor,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8,right: 8),
        child: ListTile(
          title: Text(text, style: TextStyle(color: getTextColor(context)),),
          leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getBGColor(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: image,
              )),
        )
    );
  }

  Color getBGColor(BuildContext context) {
    if (color != null) {
      return color!;
    }
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

  Color getTextColor(BuildContext context) {
    if (textColor != null) {
      return textColor!;
    }
    return Theme.of(context).brightness != Brightness.light
        ? Colors.white
        : Colors.black;
  }
}
