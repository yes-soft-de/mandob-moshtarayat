import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat/consts/country_code.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/rigester/custom_register_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class RegisterStateInit extends RegisterState {
  RegisterStateInit(RegisterScreenState screen,
      {String? error, bool registered = false})
      : super(screen) {
    if (error != null) {
      if (registered) {
        screen.userRegistered().whenComplete(() {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
            ..show(screen.context);
        });
      } else {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: error)
          ..show(screen.context);
      }
    }
  }

//  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool agreed = false;
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _registerKey,
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image.asset(
                ImageAsset.LOGO,
                height: 250,
                width: 150,
                    )
                  : Container(),
//              Padding(
//                padding: const EdgeInsets.only(
//                    bottom: 4.0, left: 32, right: 32, top: 8),
//                child: Text(
//                  S.of(context).name,
//                  style: StyleText.textsAlmaraiNormalBold,
//                ),
//              ),
//              ListTile(
//                title: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: CustomLoginFormField(
//                    contentPadding:
//                        EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 0),
//                    controller: nameController,
//                    hintText: S.of(context).nameHint,
//                    preIcon: Icon(Icons.person),
//                  ),
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 4.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
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
                      autofocus: false,
                      autovalidateMode: mode,
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true, cut: true),
                      controller: usernameController,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      validator: (value){
                        if (mode == AutovalidateMode.disabled) {
                            mode = AutovalidateMode.onUserInteraction;
                            screen.refresh();
                        }
                        if (value == null) {
                          return S.of(context).pleaseCompleteField;
                        }else if (value.length <9){
                          return S.of(context).invalidNumber;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).phone,
                        prefixIcon:Icon(Icons.phone) ,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        prefix: Text(CountryCode.COUNTRY_CODE),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).password,
                  style: StyleText.textsAlmaraiNormalBold,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon: Icon(Icons.lock),
                    last: true,
                    controller: passwordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).password,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CheckboxListTile(
                    value: agreed,
                    title: Text(
                        S.of(context).iAgreeToTheTermsOfServicePrivacyPolicy,style: StyleText.textsAlmaraiNormal,),
                    onChanged: (v) {
                      if(v!= null && v)
                      showDialog(
                        context: screen.context,
                        builder: (_){
                          return AlertDialog(
                            title: Text('عقد توريد'),
                            content: SingleChildScrollView(child: Container(child: Text( S.current.contract))),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                                agreed = v ;
                                   screen.refresh();
                              }, child: Text(S.current.confirm)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(S.current.cancel)),
                            ],
                          );
                        },
                      );
                      else{
                        agreed = v ?? false;
                        screen.refresh();
                      }
//e
                    })
              ),
              Container(
                height: 175,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AuthButtons(
            firstButtonTitle: S.of(context).register,
            secondButtonTitle: S.of(context).iHaveAnAccount,
            loading: screen.loadingSnapshot.connectionState ==
                ConnectionState.waiting,
            secondButtonTab: () => Navigator.of(context).pushReplacementNamed(
                AuthorizationRoutes.LOGIN_SCREEN,
                arguments: screen.args),
            firstButtonTab: agreed
                ? () {
                    if (_registerKey.currentState!.validate()) {
                      screen.userID = usernameController.text;
                      screen.pass=passwordController.text;
                      screen.registerClient(RegisterRequest(
                          userID: usernameController.text,
                          password: passwordController.text,
                          ));
                    }
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
