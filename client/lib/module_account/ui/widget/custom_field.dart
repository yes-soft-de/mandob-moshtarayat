import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();

  CustomFormField({this.height = 50,
    this.contentPadding = const EdgeInsets.fromLTRB(0, 15.5, 0, 0),
     this.hintText, this.preIcon, this.sufIcon, this.controller,this.readOnly = false,this.onTap});
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme
            .of(context)
            .backgroundColor,
      ),
      child: TextFormField(
        onTap:widget.onTap,
        controller:widget.controller,
        readOnly:widget.readOnly,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: widget.preIcon,
          suffixIcon: widget.sufIcon,
          enabledBorder: InputBorder.none,
          contentPadding: widget.contentPadding,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
