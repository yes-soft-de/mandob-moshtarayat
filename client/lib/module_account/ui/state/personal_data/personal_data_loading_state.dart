import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_state.dart';

class PersonalDataLoadingState extends PersonalDataState {
  PersonalDataLoadingState(PersonalDataScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
