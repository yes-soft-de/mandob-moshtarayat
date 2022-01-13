import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

Widget formDialog(BuildContext context, String title, String textHint,
    Function(String, String?, List<TranslateStoreCategory>?) add,
    {bool image = true,
    UpdateStoreCategoriesRequest? storeCategoriesRequest,
    UpdateProductCategoryRequest? request}) {
  return Scaffold(
    appBar:
        CustomTwaslnaAppBar.appBar(context, title: S.current.addNewCategory),
    body: image
        ? InsertForm(
            add: (name, image, tra) {
              add(name, image, tra);
            },
            hintText: textHint,
            storeCategoriesRequest: storeCategoriesRequest,
            languages: ['en', 'urdu'],
          )
        : insertFormWithoutImage(
            add: (name) {
              add(name, '', []);
            },
            hintText: textHint,
            updateStoreCategoriesRequest: request,
          ),
  );
}

class InsertForm extends StatefulWidget {
  final Function(String, String?, List<TranslateStoreCategory>?) add;
  final String hintText;
  final List<String> languages;
  final UpdateStoreCategoriesRequest? storeCategoriesRequest;

  InsertForm(
      {required this.add,
      required this.hintText,
      this.storeCategoriesRequest,
      required this.languages});

  @override
  _InsertFormState createState() => _InsertFormState();
}

class _InsertFormState extends State<InsertForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameArController;
  late String lang;
  String? imagePath;
  late bool isUpdate;
  List<String> chosenString = [];
  late List<TranslateStoreCategory> translate;
  late List<CustomFormFieldWithTranslate> translateWidgets;

  @override
  void initState() {
    _nameArController = TextEditingController();
    translateWidgets = [];
    translate = [];
    isUpdate = false;
    if (widget.storeCategoriesRequest != null) {
      isUpdate = true;
      lang = widget.storeCategoriesRequest?.dataStoreCategory?.lang ?? '';
      _nameArController.text =
          widget.storeCategoriesRequest?.dataStoreCategory?.storeCategoryName ??
              '';
      imagePath = widget.storeCategoriesRequest?.dataStoreCategory?.image;
      if (imagePath == '') {
        imagePath = null;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: FixedContainer(
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormFieldWithTranslate(
                          controller: _nameArController,
                          hintText: widget.hintText,
                          last: true,
                          initLanguage: isUpdate ? lang : 'ar',
                          languages: isUpdate ? [lang] : ['ar'],
                        ),
                      ),
                      isUpdate
                          ? Container()
                          : InkWell(
                              onTap: () {
                                if (_nameArController.text.isEmpty) {
                                  CustomFlushBarHelper.createError(
                                          title: S.current.warnning,
                                          message:
                                              S.current.pleaseCompleteTheForm)
                                      .show(context);
                                } else if (translateWidgets.length !=
                                    widget.languages.length) {
                                  trans(true);
                                }
                              },
                              child: Icon(Icons.add))
                    ],
                  ),
                  Column(
                    children: trans(false),
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
                          .getImage(
                        source: ImageSource.gallery,
                        imageQuality: 70,
                      )
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
                        size: 125,
                      ),
                      checked: imagePath != null,
                      checkedWidget: SizedBox(
                          height: 250,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: imagePath?.contains('http') == true
                                  ? Image.network(
                                      imagePath ?? '',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(imagePath ?? ''),
                                      fit: BoxFit.scaleDown,
                                    ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4)),
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
                ])),
          ),
        ),
        label: widget.storeCategoriesRequest != null
            ? S.current.update
            : S.current.save,
        onTap: () {
          List<String> langs =
              LinkedHashSet<String>.from(chosenString).toList();
          if (_key.currentState!.validate() &&
              langs.length == translateWidgets.length) {
            if (imagePath?.contains('http') == true &&
                widget.storeCategoriesRequest != null) {
              imagePath =
                  widget.storeCategoriesRequest?.dataStoreCategory?.baseImage ??
                      '';
            }
            widget.add(_nameArController.text.trim(), imagePath, translate);
          } else if (langs.length != translateWidgets.length) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: S.current.duplicateLang)
                .show(context);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }

  List<CustomFormFieldWithTranslate> trans(bool addNewField) {
    if (addNewField) {
      var initLanguage = widget.languages.first;
      if (chosenString.contains(initLanguage)) {
        initLanguage = widget.languages[1];
      }
      TranslateStoreCategory translateStoreCategory =
          TranslateStoreCategory(lang: initLanguage);
      chosenString.add(initLanguage);
      TextEditingController _nameController = TextEditingController();
      late String language = '';

      translateWidgets.add(CustomFormFieldWithTranslate(
        initLanguage: initLanguage,
        onChanged: () {
          translateStoreCategory.storeCategoryName = _nameController.text;
        },
        languages: widget.languages,
        controller: _nameController,
        onSelected: (lan) {
            chosenString.remove(translateStoreCategory.lang);
            chosenString.add(lan);
          language = lan;
          translateStoreCategory.lang = language;
          setState(() {});
        },
      ));
      setState(() {});
      translate.add(translateStoreCategory);
    }
    return translateWidgets;
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
