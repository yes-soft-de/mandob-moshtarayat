import 'dart:io';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/faded_button_bar.dart';
import 'package:mandob_moshtarayat/utils/components/map.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class InitAccountCaptainInitProfile extends InitAccountState {
  final InitAccountScreenState screenState;
//  final List<StoreCategoriesModel> categories;
  // Uri? restaurantIamge;
  //
  // final _nameController = TextEditingController();
  // final _phoneController = TextEditingController();
  //
  //
  // int hasProduct=0;
  // int privateOrders=0;
  //
  // // TimeOfDay closingTime='';
  // // TimeOfDay openingTime='';
  //
  // int storeCategoryId=0;


  InitAccountCaptainInitProfile( this.screenState)
      : super(screenState);

  // InitAccountCaptainInitProfile.withData(
  //     InitAccountScreenState screenState,
  //     CreateStoreRequest request, this.categories)
  //     : super(screenState);
  // {
  //   _nameController.text = request.storeOwnerName??'';
  //    _phoneController.text = request.phone??'';
  //    storeCategoryId =request.storeCategoryId??0;
  //   // closingTime = request.closingTime??'';
  //   // openingTime = request.openingTime??'';
  //   hasProduct = request.hasProducts??0;
  //   privateOrders = request.privateOrders??0;
  //
  //   restaurantIamge = this.restaurantIamge;
  // }

  final GlobalKey<FormState> _initKey = GlobalKey<FormState>();

 // String? catId;
  MapController mapController = MapController();
  LatLng? storeLocation;
  String? imagePath;
  bool privateOrder = false;
  bool products = false;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  var date = DateTime.now();
  Uri? restaurantIamge;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankName = TextEditingController();
  final _bankAccountNumber= TextEditingController();
  final _stcPay= TextEditingController();
  int val = 1;
  @override
  Widget getUI(BuildContext context) {
    _phoneController.text=screenState.phoneNumber??'';
    return SafeArea(
      child: Form(
        key: _initKey,
        child: Stack(
          children: [
            CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
                Container(height: 50,),
//name
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.storeName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _nameController,
                  hintText: S.current.storeName,
                ),
                // Phone Number
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.storePhone,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _phoneController,
                  hintText: S.current.storePhone,
                  phone: true,
                  numbers: true,
                  readOnly: true,
                ),
                // Store Location
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 32.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if(storeLocation == null){
                        storeLocation = screenState.myPos;
                      }
                      mapController = MapController();
                      screenState.refresh();
                      showDialog(
                          builder: (_) {
                            return Scaffold(
                              appBar: CustomMandopAppBar.appBar(context,
                                  title: S.current.storeLocation,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.current.save)),
                                  ]),
                              body: MapClientOrder(
                                mapController,
                                onTap: (newPos) {
                                  storeLocation = newPos;
                                 screenState.refresh();
                                },
                                myPos: storeLocation,
                                defaultPoint: storeLocation,
                              ),
                            );
                          },
                          context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: storeLocation == null
                            ? Theme.of(context).primaryColor
                            : Colors.green,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.current.storeLocation,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Store Image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                        S.current.storeImage,
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

                //account
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
                  controller: _bankName,
                  hintText: S.current.bankName,
                ),

                SizedBox(height: 10,),

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
                      controller: _bankAccountNumber,
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
                      controller: _stcPay,
                      hintText: S.current.stc,
                      validator:val==2?true: false,
                    ),
                  ],),
                ),



                //hours
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                  child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.current.workTime + ' : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 0.5,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value == null) {
                          } else {
                            openingTime = value;
                            screenState.refresh();
                          }
                        });
                      },
                      title: Text(S.of(context).openingTime),
                      trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).backgroundColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              openingTime?.format(context).toString() ?? '00:00 ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 0.5,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value == null) {
                          } else {
                            closingTime = value;
                            screenState.refresh();
                          }
                        });
                      },
                      title: Text(S.of(context).closingTime),
                      trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).backgroundColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              closingTime?.format(context).toString() ?? '00:00 ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ),
                // Store Services
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                  child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.current.storeService + ' : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CheckboxListTile(
                      value: products,
                      title: Text(S.of(context).products),
                      onChanged: (v) {
                        products = v ?? false;
                        screenState.refresh();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CheckboxListTile(
                      value: privateOrder,
                      title: Text(S.of(context).privateOrder),
                      onChanged: (v) {
                        privateOrder = v ?? false;
                        screenState.refresh();
                      }),
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
                            imagePath != null &&
                            storeLocation != null &&
                        openingTime != null &&
                        closingTime != null ) {
                          screen.submitProfile(
                              CreateStoreRequest(
                                openingTime: DateTime(date.year, date.month,
                                    date.day, openingTime!.hour,
                                    openingTime!.minute)
                                    .toUtc()
                                    .toIso8601String(),
                                closingTime: DateTime(date.year, date.month,
                                    date.day, closingTime!.hour,
                                    closingTime!.minute)
                                    .toUtc()
                                    .toIso8601String(),
                                hasProducts: products ? 1 : 0,
                                privateOrders: privateOrder ? 1 : 0,
                                location: GeoJson(
                                    lat: storeLocation?.latitude,
                                    long: storeLocation?.longitude),

                                image: imagePath!.toString(),
                                storeOwnerName: _nameController.text,
                                phone: _phoneController.text,
                                bankAccountNumber: _bankAccountNumber.text,
                                bankName: _bankName.text,
                                stcPay: _stcPay.text


                              ));
                        } else if (storeLocation == null) {
                          CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.chooseLocation)
                              .show(context);
                        } else {
                          CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseCompleteTheForm)
                              .show(context);
                        }},
              ),
            ),
          ],
        ),
      ),
    );
  }



}
