import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/state_manager/edit_profile/edit_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';

@injectable
class EditProfileScreen extends StatefulWidget {
  final EditProfileStateManager _stateManager;

  EditProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  ProfileState? states;

  void saveProfile(ProfileRequest request) {
    widget._stateManager.submitProfile(this, request);
  }

  void uploadImage(ProfileRequest request, String? type, [String? image]) {
    widget._stateManager.uploadImage(this, request, type, image);
  }

  void showMessage(String msg, bool success) {
    if (success) {
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: msg)
          .show(context);
    } else {
      CustomFlushBarHelper.createError(title: S.current.warnning, message: msg)
          .show(context);
    }
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      states = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getProfile(this);
    states ??= ProfileStateLoading(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: states is ProfileStateDirtyProfile
            ? null
            : CustomTwaslnaAppBar.appBar(
                context,
                title: S.of(context).profile,
              ),
        body: states?.getUI(context),
      ),
    );
  }
}
