import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/state_manager/presonal_data_state_manager.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_loaded_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_state.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class PersonalDataScreen extends StatefulWidget {
  final PersonalDataStateManager _personalDataStateManager;

  PersonalDataScreen(this._personalDataStateManager);

  @override
  PersonalDataScreenState createState() => PersonalDataScreenState();
}

class PersonalDataScreenState extends State<PersonalDataScreen> {
  PersonalDataState? currentState;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveDecision(bool success, [String err = '']) {
    if (success) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MainRoutes.MAIN_SCREEN, (route) => false,
          arguments: 3);
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).uploadProfileSuccess,
      )..show(context);
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
          title: S.of(context).warnning, message: err)
        ..show(context);
    }
  }

  @override
  void initState() {
    super.initState();
    widget._personalDataStateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
  }

  bool flagData = true;
  void postClientProfile(ProfileRequest request) {
    widget._personalDataStateManager.postClientProfile(this, request);
  }

  void uploadImage(ProfileModel profileModel, String imagePath) {
    widget._personalDataStateManager.uploadImage(imagePath, this, profileModel);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (flagData && args is ProfileModel) {
      flagData = false;
      currentState = PersonalDataLoadedState(this, args);
      refresh();
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            S.of(context).personalData,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).brightness != Brightness.dark
                          ? Theme.of(context).disabledColor
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: currentState?.getUI(context),
      ),
    );
  }
}
