import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/product_category_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_level_two_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_sub_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/checked.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class LevelTwoCategoryLoaded extends States {
  final UpdateLevelTwoCategoryScreenState screenState;
  final String? error;
  final bool empty;

  LevelTwoCategoryLoaded(this.screenState, {this.empty = false, this.error})
      : super(screenState);

  List<TranslateSubCategory> translateItems = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _newTransController = TextEditingController();
  List<String> missingTranslate = ['ur', 'en'];

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
//          screenState.get();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
//            screenState.getMainCategories();
          });
    }
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
                      controller: screenState.nameController,
                      hintText: S.current.categoryName,
                      sufIcon: Text('ar'),
                    ),
                    Column(
                      children: trans(screenState.model?.translate ?? []),
                    ),
                    screenState.model!.translate!.length != 2
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FloatedIconButton(
                                  text: S.of(context).addNewTrans,
                                  icon: Icons.add,
                                  onPressed: () {
                                    String lang = missingTranslate.first;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                Text(S.of(context).addNewTrans),
                                            content:
                                                CustomFormFieldWithTranslate(
                                              controller: _newTransController,
                                              onSelected: (langNew) {
                                                lang = langNew;
                                              },
                                              initLanguage: missingTranslate.first,
                                              languages: missingTranslate,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    screenState.addNewTranslate(
                                                        CreateNewTransProductCategoryRequest(
                                                            storeProductCategoryID:
                                                                screenState
                                                                    .model!.id,
                                                            storeProductCategoryName:
                                                                _newTransController
                                                                    .text,
                                                            language: lang));
                                                  },
                                                  child:
                                                      Text(S.current.confirm)),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child:
                                                      Text(S.current.cancel)),
                                            ],
                                          );
                                        });
                                  },
                                )
                              ],
                            ),
                          )
                        : Container(),
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
                            screenState.imagePath = value.path;
                            screenState.refresh();
                          }
                        });
                      },
                      child: Checked(
                        child: Icon(
                          Icons.image,
                          size: 125,
                        ),
                        checked: screenState.imagePath != null,
                        checkedWidget: SizedBox(
                            height: 250,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: screenState.imagePath
                                            ?.contains('http') ==
                                        true
                                    ? Image.network(screenState.imagePath ?? '')
                                    : Image.file(
                                        File(screenState.imagePath ?? ''),
                                        fit: BoxFit.scaleDown,
                                      ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate()) {
            if (screenState.imagePath?.contains('http') == true) {
              screenState.imagePath = screenState.model?.imageUrl ?? '';
            }
            screenState.updateCategory(translateItems);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }

  List<Widget> trans(List<Translate> translates) {
    List<Widget> translateWidgets = [];

    for (Translate item in translates) {
      if (missingTranslate.contains(item.language)) {
        missingTranslate.remove(item.language);
      }
      TextEditingController _nameController = TextEditingController();
      TranslateSubCategory tras = TranslateSubCategory();

      tras.productCategoryID = screenState.model?.id ?? -1;
      tras.productCategoryName = item.productCategoryName ?? '';
      tras.lang = item.language ?? '';
      _nameController.text = item.productCategoryName ?? '';
      translateWidgets.add(Padding(
        padding: const EdgeInsetsDirectional.only(top: 8),
        child: CustomFormField(
          controller: _nameController,
          hintText: S.current.categoryName,
          sufIcon: Text(item.language ?? ''),
          onChanged: () {
            tras.productCategoryName = _nameController.text;
          },
        ),
      ));
      translateItems.add(tras);
    }

    return translateWidgets;
  }
}
