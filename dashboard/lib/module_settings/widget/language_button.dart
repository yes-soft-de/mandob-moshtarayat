import 'package:flutter/material.dart';

class LanguageButton extends StatefulWidget {
  final String textLang;
  final bool active;
  final String image;
  @override
  _LanguageButtonState createState() => _LanguageButtonState();
  const LanguageButton(
      {required this.textLang, required this.active, required this.image});
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            widget.image,
            width: 25,
          ),
          Text(
            widget.textLang,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
              width: 25,
              height: 25,
              child: widget.active
                  ? const Center(
                      child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 25,
                    ))
                  : Container()),
        ],
      ),
    );
  }
}
