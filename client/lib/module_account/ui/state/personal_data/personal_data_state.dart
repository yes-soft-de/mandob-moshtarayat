import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';

abstract class PersonalDataState {
  final PersonalDataScreenState personalDataScreen;

  PersonalDataState(this.personalDataScreen);

  Widget getUI(BuildContext context);
}
