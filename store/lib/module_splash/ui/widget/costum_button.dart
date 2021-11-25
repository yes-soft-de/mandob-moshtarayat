import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Function onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderSide border;
  final Color color;
  final double elevation;

  const CustomAppButton({
   required this.child,
      this.borderRadius = 0,
    required this.onTap,
    required this.padding,
    this.border = BorderSide.none,
    required this.color,
    required  this.margin,
    this.elevation = 5
  });

  static BorderSide get none => BorderSide(color: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Material(
        elevation: elevation,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: border,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            child: child,
          ),
          onTap: (){onTap();},
        ),
      ),
    );
  }
}