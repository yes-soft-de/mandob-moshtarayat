import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/map.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class AddStoreWidget extends StatefulWidget {
  final Function(String, String, String, String, GeoJson, bool, bool) addStore;
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
  LatLng? storeLocation;
  String? imagePath;
  bool privateOrder = false;
  bool products = false;
  String? catId;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
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
                              appBar: CustomTwaslnaAppBar.appBar(context,
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
                SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    ImagePicker.platform
                        .getImage(source: ImageSource.gallery, imageQuality: 70)
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
                  padding: const EdgeInsets.only(top: 16.0),
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
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate() &&
              imagePath != null &&
              storeLocation != null) {
            widget.addStore(
                catId.toString(),
                _nameController.text.trim(),
                _phoneController.text.trim(),
                imagePath!,
                GeoJson(
                    lat: storeLocation?.latitude,
                    long: storeLocation?.longitude),
                products,
                privateOrder);
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
    super.initState();
  }
}

class UpdateStoreWidget extends StatefulWidget {
  final Function(String, String, String, bool, bool) updateStore;
  final UpdateStoreRequest? request;
  UpdateStoreWidget({required this.updateStore, this.request});

  @override
  _UpdateStoreWidgetState createState() => _UpdateStoreWidgetState();
}

class _UpdateStoreWidgetState extends State<UpdateStoreWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _deliveryController;
  LatLng? storeLocation;
  String? imagePath;
  bool privateOrder = false;
  bool products = false;
  String? catId;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
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
                                appBar: CustomTwaslnaAppBar.appBar(context,
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
                SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    ImagePicker.platform
                        .getImage(source: ImageSource.gallery, imageQuality: 70)
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
                            child: imagePath!.contains('original-image')
                                ? Image.network(Urls.IMAGES_ROOT + imagePath!)
                                : Image.file(
                                    File(imagePath ?? ''),
                                    fit: BoxFit.cover,
                                  ))),
                  ),
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
                  padding: const EdgeInsets.only(top: 16.0),
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
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate() && imagePath != null) {
            widget.updateStore(catId.toString(), _nameController.text.trim(),
                imagePath!, products, privateOrder);
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
    if (widget.request != null) {
      _nameController.text = widget.request?.storeOwnerName ?? '';
      imagePath = widget.request?.image ?? '';
      products = widget.request?.hasProducts == 1 ? true : false;
      privateOrder = widget.request?.privateOrders == 1 ? true : false;
    }
    super.initState();
  }
}
