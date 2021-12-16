import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/store_categories_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/form_dialog.dart';

@injectable
class StoreCategoriesScreen extends StatefulWidget {
  final StoreCategoriesStateManager _stateManager;
  final LocalizationService _localizationService;

  StoreCategoriesScreen(this._stateManager,this._localizationService);

  @override
  StoreCategoriesScreenState createState() => StoreCategoriesScreenState();
}

class StoreCategoriesScreenState extends State<StoreCategoriesScreen> {
  late StoreCategoriesState currentState;
  bool canAddCategories = true;
  String? languageSelected;

  @override
  void initState() {
    languageSelected = widget._localizationService.getLanguage() ;
    currentState = StoreCategoriesLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getStoreCategories(this);
    super.initState();
  }
  void getStoreCategories() {
    widget._stateManager.getStoreCategories(this);
  }
  void getStoreCategoriesWithLang(String lang) {
    widget._stateManager.getStoreCategoriesWithLang(this,FilterLanguageCategoryRequest(language: lang));
  }

  void addCategory(CreateStoreCategoryRequest request) {
    widget._stateManager.createCategory(this, request);
  }

  void updateCategory(UpdateStoreCategoriesRequest request) {
    widget._stateManager.updateCategory(this, request);
  }

  void deleteCategories(String id) {
    widget._stateManager.deleteCategories(this,id);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).storeCategories, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addNewCategory,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return formDialog(
                    context,
                    S.current.addNewCategory,
                    S.current.category,
                    (name, image,tras) {
                      Navigator.of(context).pop();
                      addCategory(CreateStoreCategoryRequest(
                        dataStoreCategory: DataStoreCategory(image: image,lang: 'ar',storeCategoryName: name,description: name),
                          translate: tras,));
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
