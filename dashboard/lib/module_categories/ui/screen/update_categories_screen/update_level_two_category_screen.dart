import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/product_category_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/update_categories_state_manager/update_level_two_category_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/update_categories_state_manager/update_sub_category_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/update_level_two_categories/update_level_two_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/sub_categories/update_sub_categories/update_sub_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class UpdateLevelTwoCategoryScreen extends StatefulWidget {
 final UpdateLevelTwoCategoriesStateManager _stateManager;


 UpdateLevelTwoCategoryScreen(this._stateManager);

 @override
 UpdateLevelTwoCategoryScreenState createState() => UpdateLevelTwoCategoryScreenState();
}

class UpdateLevelTwoCategoryScreenState extends State<UpdateLevelTwoCategoryScreen> {
  late States currentState;
//  bool canAddCategories = true;
  int? id = -1;
  ProductCategoryModel? model;
 late bool flags;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
 late TextEditingController nameController;
 late String? imagePath;
  @override
  void initState() {
    flags = true;
//    languageSelected = widget._localizationService.getLanguage();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    super.initState();
  }

  void updateCategory(List<TranslateSubCategory> tras) {
    widget._stateManager.updateCategory(this, SubCategoriesRequest(
      dataStoreCategory: DataStoreCategory(
        id: model?.id,
        productCategoryName: nameController.text,
        productCategoryImage: imagePath
      ),
      translate: tras
    ));
  }
  void addNewTranslate(CreateNewTransProductCategoryRequest request){
    widget._stateManager.addNewTranslate(this,request);
  }

  void refresh() {
    print('ref');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        id = arg;
        widget._stateManager.getLevelTwoCategory(this, id.toString());
      }
    }
    if(currentState is LevelTwoCategoryLoaded && flags && model != null){
      print('inIfState');
      flags = false;
      print(model!.categoryName);
      nameController = TextEditingController();
      nameController..text = model?.categoryName??'';
      print(model?.categoryName??'');
      imagePath = model?.categoryImage??'';
      if (imagePath == '') {
        imagePath = null;
      }
    }
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context, title: S.current.updateCategory),
      body: currentState.getUI(context),
    );
  }
}
