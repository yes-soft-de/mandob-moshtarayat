import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:flutter/material.dart';

class LoadingState extends States {
  String? message;
  LoadingState(State<StatefulWidget> screenState, {this.message})
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    if (message != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16,),
          Text(message! + '...',style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
