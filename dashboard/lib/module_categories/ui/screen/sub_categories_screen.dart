import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/state_manager/sub_categories_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/sub_categories/sub_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/sub_categories.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';

@injectable
class SubCategoriesScreen extends StatefulWidget {
  final SubCategoriesStateManager _stateManager;
  final LocalizationService _localizationService;

  SubCategoriesScreen(this._stateManager, this._localizationService);

  @override
  SubCategoriesScreenState createState() => SubCategoriesScreenState();
}

class SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late States currentState;
  bool canAddCategories = true;
  String? id;
  String? languageSelected;
  @override
  void initState() {
    languageSelected = widget._localizationService.getLanguage();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    widget._stateManager.getStoreCategories(this);
    super.initState();
  }

  void getMainCategories() {
    widget._stateManager.getStoreCategories(this);
  }

  void getSubCategories(categories) {
    widget._stateManager.getCategoriesLevelOne(
        this,
        FilterLanguageAndCategoryRequest(
            storeCategoryID: int.parse(id ?? '0'), language: languageSelected),
        categories);
  }

  void addSubCategories(SubCategoriesRequest request) {
    id = null;
    widget._stateManager.createSubCategory(this, request);
  }

  void updateSubCategories(request) {
    id = null;
    widget._stateManager.updateSubCategory(this, request);
  }

  void deleteSubCategories(String idd) {
    id = null;
    widget._stateManager.deleteSubCategories(this, idd);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.of(context).subCategories, icon: Icons.menu, onTap: () {
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
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Scaffold(
                      appBar: CustomMandoobAppBar.appBar(context,
                          title: S.current.addNewCategory),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      body: AddSubCategoriesWidget(
                        state: currentState is SubCategoriesLoadedState
                            ? currentState as SubCategoriesLoadedState
                            : null,
                        languages: ['en', 'urdu'],
                        addSubCategories: (id, name, image, trans) {
                          addSubCategories(
                            SubCategoriesRequest(
                              translate: trans,
                              dataStoreCategory: DataStoreCategory(
                                  storeCategoryID: int.tryParse(id),
                                  productCategoryName: name,
                                  productCategoryImage: image),
                            ),
                          );
                          Navigator.of(context).pop();
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
