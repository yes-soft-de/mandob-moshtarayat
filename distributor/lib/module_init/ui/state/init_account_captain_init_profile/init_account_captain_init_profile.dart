import 'dart:io';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/faded_button_bar.dart';
import 'package:mandob_moshtarayat/utils/components/map.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';

class InitAccountCaptainInitProfile extends InitAccountState {
  final InitAccountScreenState screenState;
  InitAccountCaptainInitProfile( this.screenState)
      : super(screenState);
  final GlobalKey<FormState> _initKey = GlobalKey<FormState>();
  String? imagePath;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _ageController = TextEditingController();
  int val = 1;
  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _initKey,
        child: Stack(
          children: [
            CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
                Container(height: 50,),
                // profile Image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                        S.current.yourImage,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                InkWell(
                  onTap: () {
                    ImagePicker.platform
                        .getImage(source: ImageSource.gallery, imageQuality: 70)
                        .then((value) {
                      if (value != null) {
                        imagePath = value.path;
                        screenState.refresh();
                      }
                    });
                  },
                  child: Checked(
                    child: Icon(
                      Icons.image,
                      size: 150,
                    ),
                    checked: imagePath != null,
                    checkedWidget: SizedBox(
                        height: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.file(
                              File(imagePath ?? ''),
                              fit: BoxFit.cover,
                            ))),
                  ),
                ),
                //name
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _nameController,
                  hintText: S.current.name,
                ),



                //age
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.age,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _ageController,
                  hintText: S.current.age,
                  numbers: true,
                  phone: false,
                ),


                // Phone Number
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.phoneNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _phoneController,
                  hintText: S.current.phoneNumber,
                  phone: true,
                  numbers: true,
                ),

                //bank name
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.bankName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _bankNameController,
                  hintText: S.current.bankName,
                ),


                //bank account Number
                Row(children: [
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text(S.of(context).bankAccountNumber,style: TextStyle(fontSize: 12)),
                      leading: Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          val = value as  int;
                          screenState.refresh();
                        },
                        activeColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text(S.of(context).stcPayCode,style: TextStyle(fontSize: 12),),
                      leading: Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: (value) {
                            val = value as  int;
                            screenState.refresh();

                          },
                          activeColor: Theme.of(context).accentColor
                      ),
                    ),
                  ),
                ],),

                Visibility(
                  visible: val==1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 8, right: 12, top: 16.0),
                        child: Text(
                          S.current.bankAccountNumber,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      CustomFormField(
                        controller: _bankAccountNumberController,
                        hintText: S.current.bankAccountNumber,
                        validator:val==1?true: false,
                      ),
                    ],),
                ),
                Visibility(
                  visible: val==2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 8, right: 12, top: 16.0),
                        child: Text(
                          S.current.stc,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      CustomFormField(
                        controller: _stcPayController,
                        hintText: S.current.stc,
                        validator:val==2?true: false,
                      ),
                    ],),
                ),





                SizedBox(
                  height: 100,
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadedButtonBar(
                text: S.of(context).uploadAndSubmit,
                onPressed: imagePath == null
                    ? null
                    : () {
                        if (_initKey.currentState!.validate() &&
                            imagePath != null) {
                          screen.submitProfile(
                              CreateMandobRequest(
                                stcPay: _stcPayController.text,
                                age: int.parse(_ageController.text),
                                bankAccountNumber: _bankAccountNumberController.text,
                                bankName: _bankNameController.text,
                                mandobName: _nameController.text,
                                image: imagePath!.toString(),
                                phone: _phoneController.text,
                              ));
                        }},
              ),
            ),
          ],
        ),
      ),
    );
  }


}
