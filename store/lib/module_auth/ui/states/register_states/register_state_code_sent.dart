import 'dart:async';

import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

//class RegisterStatePhoneCodeSent extends RegisterState {
//  final _confirmationController = TextEditingController();
//  bool retryEnabled = false;
//  bool loading = false;
//
//  RegisterStatePhoneCodeSent(RegisterScreenState screen) : super(screen);
//
//  @override
//  Widget getUI(BuildContext context) {
//    return Form(
//      child: Flex(
//        direction: Axis.vertical,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          MediaQuery.of(context).viewInsets.bottom == 0
//              ? SvgPicture.asset('assets/images/logo.svg')
//              : Container(),
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: TextFormField(
//                controller: _confirmationController,
//                decoration: InputDecoration(
//                  labelText: S.of(context).confirmCode,
//                  hintText: '12345',
//                ),
//                keyboardType: TextInputType.number,
//                validator: (v) {
//                  if (v == null) {
//                    return S.of(context).pleaseInputPhoneNumber;
//                  }
//                  return null;
//                }),
//          ),
//          OutlinedButton(
//            onPressed: retryEnabled
//                ? () {
//                    //screen.retryPhone();
//                  }
//                : null,
//            child: Text(S.of(context).resendCode),
//          ),
//          loading
//              ? Text(S.of(context).loading)
//              : Container(
//                  decoration:
//                      BoxDecoration(color: Theme.of(context).accentColor),
//                  child: GestureDetector(
//                    onTap: () {
//                      loading = true;
//                      Future.delayed(Duration(seconds: 10), () {
//                        loading = false;
//                      });
//                      screen.refresh();
//                      //screen.confirmCaptainSMS(_confirmationController.text);
//                    },
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        Padding(
//                          padding: const EdgeInsets.all(16.0),
//                          child: Text(
//                            S.of(context).confirm,
//                            style: TextStyle(
//                              fontSize: 20,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//        ],
//      ),
//    );
//  }
//}
class RegisterStatePhoneCodeSent extends RegisterState {
  bool retryEnabled = false;
  RegisterStatePhoneCodeSent(RegisterScreenState screen,
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



//  startTime() async {
//    var duration = new Duration(seconds: 60);
//    return new Timer(duration, (){
//      screen.activeResend = true;
//      screen.refresh();
//    });
//  }
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
                        screen.verifyClient(VerifyCodeRequest(userID: screen.userID,code: codeController.text,password: screen.pass));
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
                          style: StyleText.textsAlmaraiNormal,
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
                  screen.resendCode(VerifyCodeRequest(userID: screen.userID));
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
