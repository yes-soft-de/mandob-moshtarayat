import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/category_level_tow_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/products_category_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/add_categories_level_tow.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/global_state_manager.dart';

@injectable
class LevelTowCategoriesScreen extends StatefulWidget {
  final ProductsCategoryStateManager stateManager;

  LevelTowCategoriesScreen(this.stateManager);

  @override
  LevelTowCategoriesScreenState createState() => LevelTowCategoriesScreenState();
}

class LevelTowCategoriesScreenState extends State<LevelTowCategoriesScreen> {
  late States currentState;
  bool canAddCategories = true;
  String? mainCatId;
  String? subCatId;
  @override
  void initState() {
    currentState = LoadingState(this);
    getStoreCategories();
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted){
        setState(() {
        });
      }
      getIt<GlobalStateManager>().updateCaptainList();
    });
    super.initState();
  }

  void getStoreCategories() {
    mainCatId = null;
    subCatId = null;
    widget.stateManager.getProductCategory(this);
  }

  void getSubCategories(categories) {
    subCatId = null;
    widget.stateManager.getCategoriesLevelOne(this,int.parse(mainCatId ?? '0'),categories);
  }

  void getSubCategoriesLevelTow(categories,subCategories) {
    widget.stateManager.getCategoriesLevelTow(this,int.parse(subCatId ?? '0'),categories,subCategories);
  }

  void addCategory(CategoryLevelTowRequest request) {
    widget.stateManager.createProductCategory(this, request);
  }

  void updateCategoryLevel2(CategoryLevelTowRequest request) {
    widget.stateManager.updateProductCategory(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool flagArgs = true;
  int? storeId;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(
        context,
        title: S.of(context).categoriesLevel2,
          icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }
      ),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addNewCategory,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            getStoreCategories();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Scaffold(
                      appBar: CustomTwaslnaAppBar.appBar(context,
                          title: S.current.addNewCategory),
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      body: AddSubCategoriesLevelTowWidget(
                        state: currentState is ProductCategoriesLoadedState
                            ? currentState as ProductCategoriesLoadedState
                            : null,
                        addSubCategories: (id,subId,name, image) {
                          addCategory(CategoryLevelTowRequest(
                            storeProductCategoryID: int.parse(subId),
                            productCategoryName: name,
                            productCategoryImage: image
                          ));
                        },
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
