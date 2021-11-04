import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';

abstract class SendItState {
  SendItScreenState screenState;

  SendItState(this.screenState);

  Widget getUI(BuildContext context);
}
