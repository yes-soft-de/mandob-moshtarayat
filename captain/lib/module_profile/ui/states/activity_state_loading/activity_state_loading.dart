import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/activity_state/activity_state.dart';

class ActivityStateLoading extends ActivityState {
  ActivityStateLoading(ActivityScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
