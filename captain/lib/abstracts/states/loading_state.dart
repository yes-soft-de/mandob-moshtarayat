import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/abstracts/states/state.dart';

class LoadingState extends States {
  LoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
