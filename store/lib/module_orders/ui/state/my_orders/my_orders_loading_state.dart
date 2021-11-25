import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';

class MyOrdersLoadingState extends States {
  MyOrdersLoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}