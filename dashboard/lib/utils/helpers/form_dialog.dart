import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

Widget formDialog(BuildContext context, String title, String textHint,
    Function(String, String) add,
    {bool image = true,
    UpdateStoreCategoriesRequest? storeCategoriesRequest,
    UpdateProductCategoryRequest? request}) {
  return Scaffold(
    appBar:CustomTwaslnaAppBar.appBar(context, title: S.current.addNewCategory),
    body: image
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
  );
}

class InsertForm extends StatefulWidget {
  final Function(String, String) add;
  final String hintText;
  final UpdateStoreCategoriesRequest? storeCategoriesRequest;
  InsertForm(
      {required this.add, required this.hintText, this.storeCategoriesRequest});

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
      _nameController.text =
          widget.storeCategoriesRequest?.storeCategoryName ?? '';
      imagePath = widget.storeCategoriesRequest?.image ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                 child: Center(
                     child: Text(
                       S.current.categoryImage,
                       style: TextStyle(fontWeight: FontWeight.bold),
                     )),
               ),
               InkWell(
                 onTap: () {
                   ImagePicker.platform
                       .getImage(source: ImageSource.gallery, imageQuality: 70,)
                       .then((value) {
                     if (value != null) {
                       if (value.path.contains('.png')) {
                         imagePath = value.path;
                         setState(() {});
                       }
                       else {
                         CustomFlushBarHelper.createError(title: S.current.warnning, message: S.current.badFormat).show(context);
                       }
                     }
                   });
                 },
                 child: Checked(
                   child: Icon(
                     Icons.image,
                     size: 125,
                   ),
                   checked: imagePath != '',
                   checkedWidget: SizedBox(
                       height: 250,
                       child: ClipRRect(
                           borderRadius: BorderRadius.circular(25),
                           child: imagePath.contains('http')
                               ? Image.network(imagePath,fit: BoxFit.cover,)
                               : Image.file(
                             File(imagePath),
                             fit: BoxFit.scaleDown,
                           ))),
                 ),
               ),
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).primaryColor.withOpacity(0.4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.current.imageSpecification,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
               SizedBox(
                 height: 75,
               ),
             ])
          ),
        ),
        label: widget.storeCategoriesRequest != null
            ? S.current.update
            : S.current.save,
        onTap: () {
          if (_key.currentState!.validate() && imagePath != '') {
            if (imagePath.contains('http') && widget.storeCategoriesRequest != null){
              imagePath = widget.storeCategoriesRequest?.baseImage ?? '';
            }
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

class insertFormWithoutImage extends StatefulWidget {
  final Function(String) add;
  final String hintText;
  final UpdateProductCategoryRequest? updateStoreCategoriesRequest;
  insertFormWithoutImage(
      {required this.add,
      required this.hintText,
      this.updateStoreCategoriesRequest});

  @override
  State<insertFormWithoutImage> createState() => _insertFormWithoutImageState();
}

class _insertFormWithoutImageState extends State<insertFormWithoutImage> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    if (widget.updateStoreCategoriesRequest != null) {
      nameController.text =
          widget.updateStoreCategoriesRequest!.productCategoryName ?? '';
    }
    super.initState();
  }

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
              hintText: widget.hintText,
              last: true,
            ),
          ]),
        ),
        label: S.current.save,
        onTap: () {
          if (keyForm.currentState!.validate()) {
            widget.add(nameController.text.trim());
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}
