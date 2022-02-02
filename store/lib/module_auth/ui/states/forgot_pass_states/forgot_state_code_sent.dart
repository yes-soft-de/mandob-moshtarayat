import 'dart:async';

import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/verify_code_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/forgot_pass_screen/forgot_pass_screen.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

import 'forgot_state.dart';

class ForgotStatePhoneCodeSent extends ForgotPassState {
  bool retryEnabled = false;
  ForgotStatePhoneCodeSent(ForgotPassScreenState screen,
      {String? error})
      : super(screen) {
    Future.delayed(Duration(seconds: 60), () {
      retryEnabled = true;
      screen.refresh();
    });
    if (error != null) {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: error)
        ..show(screen.context);
    }
  }

  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;


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

              Image.asset(
                ImageAsset.LOGO,
                height: 200,
                width: 150,
              ),

              SizedBox(height: 18,),

              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).codeNumber,
                  style: StyleText.textsAlmaraiNormalBold,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      autovalidateMode: mode,
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true, cut: true),
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value){
                        if (mode == AutovalidateMode.disabled) {
                          mode = AutovalidateMode.onUserInteraction;
                          screen.refresh();
                        }
                        if (value == null) {
                          return S.of(context).pleaseCompleteField;
                        }else if (value.length <6){
                          return S.of(context).invalidCode;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).codeNumber,
                        prefixIcon:Icon(Icons.confirmation_num) ,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
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
                        screen.verifyCode(VerifyResetPassCodeRequest(code: codeController.text,));
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
                          S.of(context).confirm,
                          style:TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ),

              SizedBox(height: 20,),

              InkWell(
                onTap:  retryEnabled ? () {
                  retryEnabled = false;
                  Future.delayed(Duration(seconds: 60), () {
                    retryEnabled = true;
                    screen.refresh();
                  });
                  screen.refresh();
//                  screen.resendCode(VerifyCodeRequest(userID: screen.userID));
                } :null,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 32, right: 32, top: 8),
                    child: Text(
                      S.of(context).resendCode,
                      style:retryEnabled? TextStyle(color: Theme.of(context).accentColor) :TextStyle(color: Theme.of(context).disabledColor) ,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
