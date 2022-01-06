import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/category_level_tow_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class AddSubCategoriesLevelTowWidget extends StatefulWidget {
  final Function(
          String, String, String, String?, List<TranslateSubTwoCategory>?)
      addSubCategories;
  final ProductCategoriesLoadedState? state;
  final SubCategoriesModel? subCategoriesModel;
  final String? catID;
  final String? subCatID;
  final String? selectedLang;
  final List<String> languages;
  AddSubCategoriesLevelTowWidget(
      {required this.addSubCategories,
      this.state,
      this.subCategoriesModel,
      this.catID,
      this.subCatID,
      this.selectedLang,
      required this.languages});

  @override
  _AddSubCategoriesWidgetState createState() => _AddSubCategoriesWidgetState();
}

class _AddSubCategoriesWidgetState
    extends State<AddSubCategoriesLevelTowWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? catId;
  String? subCatId;
  String? imagePath;

  late String lang;
  late bool isUpdate;

  late List<TranslateSubTwoCategory> translate;
  late List<CustomFormFieldWithTranslate> translateWidgets;

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
                          active: false,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).backgroundColor),
                            child: Center(
                              child: DropdownButton(
                                value: catId,
                                items: widget.state?.getChoices(),
                                onChanged: (v) {
                                  catId = v.toString();
                                  widget.state!.screenState.mainCatId = catId;
                                  widget.state!.screenState.getSubCategories(
                                      widget.state!.categories);
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
                        SizedBox(
                          height: 16,
                        ),
                        // subcategories
                        Hider(
                          active: false,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).backgroundColor),
                            child: Center(
                              child: DropdownButton(
                                value: subCatId,
                                items: widget.state?.getSubCategories(),
                                onChanged: (v) {
                                  subCatId = v.toString();
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
                        // Category Name
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, bottom: 8, right: 12, top: 16.0),
                          child: Text(
                            S.current.categoryName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
//                        CustomFormField(
//                          controller: _nameController,
//                          hintText: S.current.categoryName,
//                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomFormFieldWithTranslate(
                                controller: _nameController,
                                hintText: S.current.categoryName,
                                last: true,
                                initLanguage: isUpdate ? lang : 'ar',
                                languages: isUpdate ? [lang] : ['ar'],
                              ),
                            ),
                            isUpdate
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      if (_nameController.text.isEmpty) {
                                        CustomFlushBarHelper.createError(
                                                title: S.current.warnning,
                                                message: S.current
                                                    .pleaseCompleteTheForm)
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
                                        ? Image.network(imagePath ?? '')
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
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4)),
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
                      ]),
                ),
              ),
            )),
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate()) {
            Navigator.of(context).pop();
            if (imagePath?.contains('http') == true &&
                widget.subCategoriesModel != null) {
              imagePath = widget.subCategoriesModel?.imageUrl ?? '';
            }
            widget.addSubCategories(catId.toString(), subCatId.toString(),
                _nameController.text.trim(), imagePath, translate);
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
    translateWidgets = [];
    translate = [];
    isUpdate = false;
    _nameController = TextEditingController();
    if (widget.subCategoriesModel != null) {
      isUpdate = true;
      lang = widget.selectedLang ?? '';
      _nameController.text = widget.subCategoriesModel!.categoryName;
      imagePath = widget.subCategoriesModel?.image;
      if (imagePath == '') {
        imagePath = null;
      }
      catId = widget.catID ?? '';
      subCatId = widget.subCatID ?? '';
    }
    super.initState();
  }

  List<CustomFormFieldWithTranslate> trans(bool addNewField) {
    if (addNewField) {
      TranslateSubTwoCategory translateStoreCategory =
          TranslateSubTwoCategory(lang: widget.languages.first);
      TextEditingController _nameController = TextEditingController();
      late String language = '';

      translateWidgets.add(CustomFormFieldWithTranslate(
        initLanguage: widget.languages.first,
        onChanged: () {
          translateStoreCategory.productCategoryName = _nameController.text;
        },
        languages: widget.languages,
        controller: _nameController,
        onSelected: (lan) {
          language = lan;
          translateStoreCategory.lang = language;
        },
      ));
      setState(() {});
      translate.add(translateStoreCategory);
    }
    return translateWidgets;
  }
}
