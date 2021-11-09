import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/request/store_categories_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/global/screen_type.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

AlertDialog formDialog(BuildContext context, String title, String textHint,
    Function(String, String) add,
    {bool image = true,UpdateStoreCategoriesRequest? storeCategoriesRequest,UpdateProductCategoryRequest? request}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    title: Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16, right: 16),
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Divider(
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
      ],
    ),
    content: Container(
      height: 250,
      width:ScreenType.isDesktop() ? 450 : ScreenType.isTablet() ? 350 : 250,
      child: image
          ? InsertForm(
              add: (name, image) {
                add(name, image);
              },
              hintText: textHint,
             storeCategoriesRequest: storeCategoriesRequest,
            )
          : insertFormWithoutImage(
              add: (name) {
                add(name, '');
              },
              hintText: textHint,
        updateStoreCategoriesRequest: request,
            ),
    ),
  );
}

class InsertForm extends StatefulWidget {
  final Function(String, String) add;
  final String hintText;
  final UpdateStoreCategoriesRequest? storeCategoriesRequest;
  InsertForm({required this.add, required this.hintText,this.storeCategoriesRequest});

  @override
  _InsertFormState createState() => _InsertFormState();
}

class _InsertFormState extends State<InsertForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late String imagePath = '';

  @override
  void initState() {
    _nameController = TextEditingController();
    if (widget.storeCategoriesRequest != null) {
      _nameController.text = widget.storeCategoriesRequest?.storeCategoryName ?? '';
      imagePath = widget.storeCategoriesRequest?.image ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView.custom(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 8.0),
              child: Text(
                S.current.categoryName,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _nameController,
              hintText: widget.hintText,
              last: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text(S.current.categoryImage,style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
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
                  size: 50,
                ),
                checked: imagePath != '',
                checkedWidget: SizedBox(
                    height: 125,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child:imagePath.contains('http') ? Image.network(imagePath) :Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
              )
                    )),
              ),
            ),
            SizedBox(height: 75,),
          ]),
        ),
        label:widget.storeCategoriesRequest != null ? S.current.update : S.current.save,
        onTap: () {
          if (_key.currentState!.validate() && imagePath != '') {
            widget.add(_nameController.text.trim(), imagePath);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}

class insertFormWithoutImage extends StatelessWidget {
  final Function(String) add;
  final String hintText;
  final UpdateProductCategoryRequest? updateStoreCategoriesRequest;
  insertFormWithoutImage({required this.add, required this.hintText,this.updateStoreCategoriesRequest}){
    if (updateStoreCategoriesRequest!=null){
      nameController.text = updateStoreCategoriesRequest!.productCategoryName ?? '';
    }
  }

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: keyForm,
          child: CustomListView.custom(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 8.0),
              child: Text(
                S.current.categoryName,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: nameController,
              hintText: hintText,
              last: true,
            ),
          ]),
        ),
        label: S.current.save,
        onTap: () {
          if (keyForm.currentState!.validate()) {
            add(nameController.text.trim());
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}
