import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/widget/profile_form/got_profile.dart';

class ProfileStateGotProfile extends ProfileState {
  ProfileRequest request;

  ProfileStateGotProfile(EditProfileScreenState screenState, this.request)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileWidget(
      updateProfile: () {
        screenState.states =
            ProfileStateDirtyProfile(screenState, request, backToProfile: true);
        screenState.refresh();
      },
      request: request,
    );
  }
}
