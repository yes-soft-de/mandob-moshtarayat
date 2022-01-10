import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/store_category_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/sub_categories_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/update_categories_state_manager/update_store_category_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/update_store_category_state/store_category_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class UpdateStoreCategoryScreen extends StatefulWidget {
 final UpdateStoreCategoriesStateManager _stateManager;


 UpdateStoreCategoryScreen(this._stateManager);

 @override
 UpdateStoreCategoryScreenState createState() => UpdateStoreCategoryScreenState();
}

class UpdateStoreCategoryScreenState extends State<UpdateStoreCategoryScreen> {
  late States currentState;
//  bool canAddCategories = true;
  int? id = -1;
  CategoryModel? model;
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

  void updateCategory(List<TranslateUpdateStoreCategory> tras) {
    widget._stateManager.updateCategory(this, UpdateStoreCategoriesRequest(
      dataStoreCategory: DataUpdateStoreCategory(
        id: model?.id,
        lang: 'ar',
        storeCategoryName: nameController.text,
        image: imagePath
      ),
      translate: tras
    ));
  }
  void addNewTranslate(CreateNewTransStoreCategoryRequest request){
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
        widget._stateManager.getStoreCategory(this, id.toString());
      }
    }
    if(currentState is StoreCategoryLoaded && flags && model != null){
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
      appBar: CustomTwaslnaAppBar.appBar(context, title: S.current.updateCategory),
      body: currentState.getUI(context),
    );
  }
}
