import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/state_manager/profile_state_manager.dart';
import 'package:mandob_moshtarayat/module_profile/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';



@injectable
class ProfileScreen extends StatefulWidget {
  final ProfileStateManager stateManager;

  ProfileScreen(this.stateManager);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool flagArgs = true;
  late States currentState;
  ProfileModel? model;

  void getStore(int id) {
    widget.stateManager.getStore(this);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.stateManager.getStore(this);
    });
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }
  void refresh(){
    if (mounted) {
      setState(() {});
    }
  }
  void updateProfile(CreateMandobRequest request){
    widget.stateManager.updateProfiel(this,request);
  }
  void goToLogin(){
    Navigator.of(context).pushReplacementNamed(AuthorizationRoutes.LOGIN_SCREEN,arguments:1);
    CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.pleaseLoginToContinue).show(context);
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CustomMandobAppBar.appBar(
          context, title:S.current.profile,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Scaffold(
                            appBar: CustomMandobAppBar.appBar(context,
                                title: S.current.update),
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            body: UpdateProfileWidget(
                              request:  model,
                              updateMandob:
                                  (name,image,status,bankName,acount,stc,age ) {
                                Navigator.of(context).pop();
                                updateProfile(CreateMandobRequest(
                                    id: model?.id??-1,
                                    image: image,
                                    mandobName: name,
                                    age: int.parse(age),
                                    bankName: bankName,
                                    stcPay: stc,
                                    bankAccountNumber: acount,
                                  phone: model?.phone??''

                                ));
                              },
                            ),
                          ),
                        );
                      });

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
      body:currentState.getUI(context),
    );
  }

}
