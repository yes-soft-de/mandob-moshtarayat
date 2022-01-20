import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

@injectable
class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(S.of(context).about) ),body:
    SingleChildScrollView(
      child: Container(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(S.of(context).aboutUs),
        ),

      ),
    ),);
  }
}
