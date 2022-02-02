import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/update_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/forgot_pass_screen/forgot_pass_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

import 'forgot_state.dart';

class ForgotStateUpdatePassword extends ForgotPassState {

  ForgotStateUpdatePassword(ForgotPassScreenState screen) : super(screen);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  TextStyle tileStyle = TextStyle(fontWeight: FontWeight.w600);



  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _verifyKey,
          child: ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [

              Container(height: 50,),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image.asset(
                ImageAsset.LOGO,
                height: 250,
                width: 150,
              )
                  : Container(),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).newPassword,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon:Icon(Icons.lock),
                    last: false,
                    controller: passwordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).newPassword,
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).confirmNewPass,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon:Icon(Icons.lock),
                    last: true,
                    controller: confirmPasswordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).confirmNewPass,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8.0, top: 8.0),
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_verifyKey.currentState!.validate() && passwordController.text==confirmPasswordController.text){
                          screen.updatePassword(UpdatePassRequest(userID: screen.userID, newPassword: passwordController.text));
                        }else{
                          CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.passwordNotMatch)
                   .show(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).accentColor,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child:
                        screen.loadingSnapshot.connectionState ==
                            ConnectionState.waiting ? CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        ):
                        Text(
                          S.of(context).update,
                          style:TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ],
    );
  }
}