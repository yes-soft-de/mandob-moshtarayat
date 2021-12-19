import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/consts/social_type.dart';

class SocialWidget extends StatelessWidget {
  final IconData image;
  final SocialType type;
  final Color color;
  final GestureTapCallback onTap;
  const SocialWidget(
      {Key? key,
      required this.color,
      required this.image,
      required this.type,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Card(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              image,
              color: Colors.white,
              size: 28,
            )),
      ),
    );
  }
}
