import 'package:flutter/material.dart';

class FixedContainer extends StatelessWidget {
  final Widget child;
  const FixedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: child,
        ),
      ),
    );
  }
}
