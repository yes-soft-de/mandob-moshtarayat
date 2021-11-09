import 'dart:io';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/faded_button_bar.dart';

class InitAccountCaptainInitProfile extends InitAccountState {
  Uri? restaurantIamge;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();


  int hasProduct=0;
  int privateOrders=0;

  String closingTime='';
  String openingTime='';

  int storeCategoryId=0;


  InitAccountCaptainInitProfile(InitAccountScreenState screenState)
      : super(screenState);

  InitAccountCaptainInitProfile.withData(
      InitAccountScreenState screenState,
      CreateStoreRequest request)
      : super(screenState) {
    _nameController.text = request.storeOwnerName??'';
     _phoneController.text = request.phone??'';
     storeCategoryId =request.storeCategoryId??0;
    closingTime = request.closingTime??'';
    openingTime = request.openingTime??'';
    hasProduct = request.hasProducts??0;
    privateOrders = request.privateOrders??0;

    restaurantIamge = this.restaurantIamge;
  }

  final GlobalKey<FormState> _initKey = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _initKey,
        child: Stack(
          children: [
            CustomListView.custom(
              children: [
                MediaQuery.of(context).viewInsets.bottom != 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            ImagePicker()
                                .getImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                                restaurantIamge = Uri(path: value.path);
                                screen.refresh();
                              }
                            });
                          },
                          child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Icon(Icons.person,
                                          size: 45, color: Colors.white)),
                                  _getCaptainImageFG(),
                                ],
                              )),
                        ),
                      ),

//name
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).name}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _nameController,
                    hintText: S.current.age,
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.date_range_rounded),
                    numbers: true,
                  ),
                ),
                // phone
                Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                      child: Text('${S.of(context).phoneNumber}'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: CustomFormField(
                    controller: _phoneController,
                    hintText: '0500000000',
                    contentPadding: EdgeInsets.only(top: 15),
                    preIcon: Icon(Icons.phone),
                    numbers: true,
                    phone: true,
                  ),
                ),
                // age


              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadedButtonBar(
                text: S.of(context).uploadAndSubmit,
                onPressed: restaurantIamge == null
                    ? null
                    : () {
                        if (_initKey.currentState!.validate()) {
                          screen.submitProfile(
                              CreateStoreRequest(

                                  image: restaurantIamge!.path.toString(),
                                  storeOwnerName: _nameController.text,
                                  phone: _phoneController.text,


                              ));
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _getCaptainImageFG() {
    if (restaurantIamge != null) {
      return Container(
          decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(File.fromUri(restaurantIamge!)),
          fit: BoxFit.cover,
        ),
      ));
    } else {
      return Container();
    }
  }
}
