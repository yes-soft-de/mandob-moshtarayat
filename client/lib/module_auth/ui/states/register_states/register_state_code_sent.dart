import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verfy_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class RegisterStatePhoneCodeSent extends RegisterState {
  bool retryEnabled = false;
  RegisterStatePhoneCodeSent(RegisterScreenState screen, {String? error})
      : super(screen) {
    Future.delayed(const Duration(seconds: 60), () {
      retryEnabled = true;
      screen.refresh();
    });
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                      validator: (value) {
                        if (mode == AutovalidateMode.disabled) {
                          mode = AutovalidateMode.onUserInteraction;
                          screen.refresh();
                        }
                        if (value == null) {
                          return S.of(context).pleaseCompleteField;
                        } else if (value.length < 6) {
                          return S.of(context).invalidCode;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).codeNumber,
                        prefixIcon: const Icon(Icons.confirmation_num),
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
                      onPressed: () {
                        screen.verifyClient(VerifyCodeRequest(
                            userID: screen.userID,
                            code: codeController.text,
                            password: screen.pass));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).secondaryHeaderColor,
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: screen.loadingSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                S.of(context).confirm,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: retryEnabled
                    ? () {
                        retryEnabled = false;
                        Future.delayed(const Duration(seconds: 60), () {
                          retryEnabled = true;
                          screen.refresh();
                        });
                        screen.refresh();
                        screen.resendCode(
                            VerifyCodeRequest(userID: screen.userID));
                      }
                    : null,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 32, right: 32, top: 8),
                    child: Text(
                      S.of(context).resendCode,
                      style: retryEnabled
                          ? TextStyle(color: Theme.of(context).secondaryHeaderColor)
                          : TextStyle(color: Theme.of(context).disabledColor),
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
