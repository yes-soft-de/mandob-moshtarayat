import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_store/product_store_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class AddProductsForm extends StatefulWidget {
  final Function(String, String, num, num) addProduct;
  final ProductStoreState? state;

  AddProductsForm({required this.addProduct, this.state});

  @override
  _AddProductsFormState createState() => _AddProductsFormState();
}

class _AddProductsFormState extends State<AddProductsForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? imagePath;
  String? catId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context, title: S.current.addProducts),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Hider(
                      active: true,
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
                        S.current.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.productName,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _priceController,
                      hintText: S.current.productPrice,
                      numbers: true,
                    ),
                    SizedBox(height: 32),
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
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() &&
                imagePath != null &&
                catId != null) {
              widget.addProduct(_nameController.text, imagePath!,
                  int.parse(_priceController.text), int.parse(catId ?? '-1'));
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}

class UpdateProductsForm extends StatefulWidget {
  final Function(String, String, String) addProduct;
  final UpdateProductRequest? request;
  UpdateProductsForm({required this.addProduct, this.request});
  @override
  _UpdateProductsFormState createState() => _UpdateProductsFormState();
}

class _UpdateProductsFormState extends State<UpdateProductsForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? imagePath;

  @override
  void initState() {
    if (widget.request != null) {
      _nameController.text = widget.request?.productName ?? '';
      imagePath = widget.request?.productImage;
      _priceController.text = widget.request?.productPrice?.toString() ?? '0';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomMandoobAppBar.appBar(context, title: S.current.updateProduct),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.productName,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _priceController,
                      hintText: S.current.productPrice,
                      numbers: true,
                    ),
                    SizedBox(height: 32),
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
                        checked: imagePath != null,
                        checkedWidget: SizedBox(
                            height: 150,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: imagePath!.contains('http') == true
                                    ? Image.network(imagePath!)
                                    : Image.file(
                                        File(imagePath ?? ''),
                                        fit: BoxFit.cover,
                                      ))),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() && imagePath != null) {
              widget.addProduct(
                  _nameController.text, _priceController.text, imagePath!);
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}

class UpdateProductsCommissionForm extends StatefulWidget {
  final Function(bool, String) updateCommission;
  final UpdateProductCommissionRequest? request;
  UpdateProductsCommissionForm({required this.updateCommission, this.request});
  @override
  _UpdateProductsCommissionFormState createState() =>
      _UpdateProductsCommissionFormState();
}

class _UpdateProductsCommissionFormState
    extends State<UpdateProductsCommissionForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  bool agreed = false;
  @override
  void initState() {
    if (widget.request != null) {
      agreed = widget.request?.isCommission ?? false;
      _priceController.text = widget.request?.commission?.toString() ?? '0';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomMandoobAppBar.appBar(context, title: S.current.updateProduct),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.productCommission,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _priceController,
                      hintText: S.current.productCommission,
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CheckboxListTile(
                          value: agreed,
                          title: Text(S.of(context).addCommission),
                          onChanged: (v) {
                            agreed = v ?? false;
                            setState(() {});
                          }),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate()) {
              widget.updateCommission(
                agreed,
                _priceController.text,
              );
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}
