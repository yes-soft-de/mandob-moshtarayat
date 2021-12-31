import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/map.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class AddStoreWidget extends StatefulWidget {
  final Function(String, String, String, String, GeoJson, bool, bool, String,
      String, String, String, String, String) addStore;
  final StoresLoadedState? state;

  AddStoreWidget({required this.addStore, this.state});

  @override
  _AddStoreWidgetState createState() => _AddStoreWidgetState();
}

class _AddStoreWidgetState extends State<AddStoreWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _deliveryController;
  late TextEditingController _bankName;
  late TextEditingController _bankAccountNumber;
  late TextEditingController _stcPay;

  LatLng? storeLocation;
  String? imagePath;
  bool privateOrder = false;
  bool products = false;
  String? catId;
  MapController mapController = MapController();
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  var date = DateTime.now();
  String status = 'active';
  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
            key: _key,
            child: Container(
              width: double.maxFinite,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: CustomListView.custom(
                      padding: EdgeInsets.only(right: 16, left: 16),
                      children: [
                        // categories
                        Hider(
                          active: widget.state != null,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).backgroundColor),
                            child: Center(
                              child: DropdownButton(
                                value: catId,
                                items: widget.state!.getChoices(),
                                onChanged: (v) {
                                  catId = v.toString();
                                  setState(() {});
                                },
                                hint: Text(
                                  S.current.chooseCategory,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.arrow_drop_down_rounded),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Store Name
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
                        ),

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
                        ),

                        // Store Location
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32, top: 32.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              storeLocation = null;
                              mapController = MapController();
                              showDialog(
                                  builder: (_) {
                                    return Scaffold(
                                      appBar: CustomTwaslnaAppBar.appBar(
                                          context,
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
                                          setState(() {});
                                        },
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
                                .getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70)
                                .then((value) {
                              if (value != null) {
                                imagePath = value.path;
                                setState(() {});
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
                        // Store Shift
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, left: 16, right: 16),
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
                                    setState(() {});
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
                                      openingTime?.format(context).toString() ??
                                          '00:00 ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                    setState(() {});
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
                                      closingTime?.format(context).toString() ??
                                          '00:00 ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CheckboxListTile(
                              value: status == 'active',
                              title: Text(S.of(context).storeAvailable),
                              onChanged: (v) {
                                status = v == true ? 'active' : 'inactive';
                                setState(() {});
                              }),
                        ),
                        // Store Services
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, left: 16, right: 16),
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
                                setState(() {});
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CheckboxListTile(
                              value: privateOrder,
                              title: Text(S.of(context).privateOrder),
                              onChanged: (v) {
                                privateOrder = v ?? false;
                                setState(() {});
                              }),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ]),
                ),
              ),
            )),
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate() &&
              imagePath != null &&
              storeLocation != null &&
              openingTime != null &&
              closingTime != null) {
            widget.addStore(
                catId.toString(),
                _nameController.text.trim(),
                _phoneController.text.trim(),
                imagePath!,
                GeoJson(
                    lat: storeLocation?.latitude,
                    long: storeLocation?.longitude),
                products,
                privateOrder,
                DateTime(date.year, date.month, date.day, openingTime!.hour,
                        openingTime!.minute)
                    .toUtc()
                    .toIso8601String(),
                DateTime(date.year, date.month, date.day, closingTime!.hour,
                        closingTime!.minute)
                    .toUtc()
                    .toIso8601String(),
                status,
                _bankName.text.trim(),
                _bankAccountNumber.text.trim(),
                _stcPay.text.trim());
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
          }
        });
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _deliveryController = TextEditingController();
    _phoneController = TextEditingController();

    _bankAccountNumber = TextEditingController();
    _bankName = TextEditingController();
    _stcPay = TextEditingController();
    super.initState();
  }
}

class UpdateStoreWidget extends StatefulWidget {
  final Function(String, String, String?, bool, bool, String?, String?, String,
      String, String, String, String) updateStore;
  final UpdateStoreRequest? request;
  final List<DropdownMenuItem<String>>? categories;

  UpdateStoreWidget({required this.updateStore, this.request, this.categories});

  @override
  _UpdateStoreWidgetState createState() => _UpdateStoreWidgetState();
}

class _UpdateStoreWidgetState extends State<UpdateStoreWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _deliveryController;
  late TextEditingController _commissionController;

  late TextEditingController _bankName;
  late TextEditingController _bankAccountNumber;
  late TextEditingController _stcPay;

  LatLng? storeLocation;
  String? imagePath;
  bool privateOrder = false;
  bool products = false;
  String? catId;
  MapController mapController = MapController();
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  String status = 'active';
  var date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    print(widget.request?.baseImage);
    return StackedForm(
        child: Form(
          key: _key,
          child: Container(
            width: double.maxFinite,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: CustomListView.custom(
                    padding: EdgeInsets.only(right: 16, left: 16),
                    children: [
                      // categories
                      Hider(
                        active: widget.categories != null &&
                            widget.categories!.length > 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).backgroundColor),
                          child: Center(
                            child: DropdownButton(
                              value: catId,
                              items: widget.categories,
                              onChanged: (v) {
                                catId = v.toString();
                                setState(() {});
                              },
                              hint: Text(
                                S.current.chooseCategory,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              underline: SizedBox(),
                              icon: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_drop_down_rounded),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //store name
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
                      // Location
                      Hider(
                        active: false,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32, top: 32.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              storeLocation = null;
                              mapController = MapController();
                              showDialog(
                                  builder: (_) {
                                    return Scaffold(
                                      appBar: CustomTwaslnaAppBar.appBar(
                                          context,
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
                                          setState(() {});
                                        },
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                      ),

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
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      // store commission
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.current.commission,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 75,
                              child: CustomFormField(
                                controller: _commissionController,
                                hintText: '1 - 100',
                                numbers: true,
                              ),
                            )
                          ],
                        ),
                      ),

                      // store image
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
                              .getImage(
                                  source: ImageSource.gallery, imageQuality: 70)
                              .then((value) {
                            if (value != null) {
                              imagePath = value.path;
                              setState(() {});
                            }
                          });
                        },
                        child: Checked(
                          child: Icon(
                            Icons.image,
                            size: 150,
                          ),
                          checked: imagePath != null && imagePath != '',
                          checkedWidget: SizedBox(
                              height: 150,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: imagePath?.contains('http') == true
                                      ? Image.network(imagePath ?? '')
                                      : Image.file(
                                          File(imagePath ?? ''),
                                          fit: BoxFit.cover,
                                        ))),
                        ),
                      ),
                      // Store Shift
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, left: 16, right: 16),
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
                                  setState(() {});
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
                                    openingTime?.format(context).toString() ??
                                        '00:00 ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  setState(() {});
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
                                    closingTime?.format(context).toString() ??
                                        '00:00 ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CheckboxListTile(
                            value: status == 'active',
                            title: Text(S.of(context).storeAvailable),
                            onChanged: (v) {
                              status = v == true ? 'active' : 'inactive';
                              setState(() {});
                            }),
                      ),
                      // Store Services
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, left: 16, right: 16),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              S.current.storeService + ' : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CheckboxListTile(
                            value: products,
                            title: Text(S.of(context).products),
                            onChanged: (v) {
                              products = v ?? false;
                              setState(() {});
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CheckboxListTile(
                            value: privateOrder,
                            title: Text(S.of(context).privateOrder),
                            onChanged: (v) {
                              privateOrder = v ?? false;
                              setState(() {});
                            }),
                      ),

                      SizedBox(
                        height: 100,
                      ),
                    ]),
              ),
            ),
          ),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate() &&
              openingTime != null &&
              closingTime != null) {
            if (imagePath?.contains('http') == true && widget.request != null) {
              print(widget.request?.baseImage);
              imagePath = widget.request?.baseImage ?? '';
            }
            widget.updateStore(
                catId.toString(),
                _nameController.text.trim(),
                imagePath,
                products,
                privateOrder,
                DateTime(date.year, date.month, date.day, openingTime!.hour,
                        openingTime!.minute)
                    .toUtc()
                    .toIso8601String(),
                DateTime(date.year, date.month, date.day, closingTime!.hour,
                        closingTime!.minute)
                    .toUtc()
                    .toIso8601String(),
                status,
                _commissionController.text,
                _bankName.text.trim(),
                _bankAccountNumber.text.trim(),
                _stcPay.text);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _deliveryController = TextEditingController();
    _phoneController = TextEditingController();
    _commissionController = TextEditingController();

    _bankAccountNumber = TextEditingController();
    _bankName = TextEditingController();
    _stcPay = TextEditingController();

    if (widget.request != null) {
      _nameController.text = widget.request?.storeOwnerName ?? '';
      imagePath = widget.request?.image ?? null;
      _commissionController.text = widget.request?.commission?.toString() ?? '';
      if (imagePath == '' || imagePath?.contains('/original-image/') == false) {
        imagePath = null;
      }
      products = widget.request?.hasProducts == 1 ? true : false;
      privateOrder = widget.request?.privateOrders == 1 ? true : false;
      openingTime = TimeOfDay.fromDateTime(DateTime.parse(
          widget.request?.openingTime ?? DateTime.now().toString()));
      closingTime = TimeOfDay.fromDateTime(DateTime.parse(
          widget.request?.closingTime ?? DateTime.now().toString()));
      status = widget.request?.status ?? 'active';
      if (widget.request?.storeCategoryId != -1) {
        catId = widget.request?.storeCategoryId.toString();
      }
      _bankAccountNumber.text = widget.request?.bankAccountNumber ?? '';
      _bankName.text = widget.request?.bankName ?? '';
      _stcPay.text = widget.request?.stcPay ?? '';
    }
    super.initState();
  }
}
