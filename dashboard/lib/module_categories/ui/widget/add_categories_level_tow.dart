import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class AddSubCategoriesLevelTowWidget extends StatefulWidget {
  final Function(String, String, String,String?) addSubCategories;
  final ProductCategoriesLoadedState? state;
  final SubCategoriesModel? subCategoriesModel;
  final String? catID;
  final String? subCatID;
  AddSubCategoriesLevelTowWidget({required this.addSubCategories, this.state,this.subCategoriesModel,this.catID,this.subCatID});

  @override
  _AddSubCategoriesWidgetState createState() => _AddSubCategoriesWidgetState();
}

class _AddSubCategoriesWidgetState extends State<AddSubCategoriesLevelTowWidget> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? catId;
  String? subCatId;
  String? imagePath;

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
                                items: widget.state?.getChoices(),
                                onChanged: (v) {
                                  catId = v.toString();
                                  widget.state!.screenState.mainCatId = catId;
                                  widget.state!.screenState.getSubCategories(widget.state!.categories);
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
                        SizedBox(height: 16,),
                        // subcategories
                        Hider(
                          active: widget.state != null,
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
                        CustomFormField(
                          controller: _nameController,
                          hintText: S.current.categoryName,
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
                      ]),
                ),
              ),
            )),
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate() && catId != null && subCatId != null) {
            Navigator.of(context).pop();
            widget.addSubCategories(
                catId.toString(),
                subCatId.toString(),
                _nameController.text.trim(),
                imagePath);
            if (imagePath?.contains('http') == true && widget.subCategoriesModel != null){
              imagePath = widget.subCategoriesModel?.baseImage ?? '' ;
            }
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
    if (widget.subCategoriesModel != null){
      _nameController.text = widget.subCategoriesModel!.categoryName;
      imagePath = widget.subCategoriesModel?.image;
      if (imagePath == ''){
        imagePath = null;
      }
      catId = widget.catID ?? '';
      subCatId = widget.subCatID ?? '';
    }
    super.initState();
  }
}
