import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/linking_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/level_tow_categories_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/store_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_list_screen.dart';

@injectable
class LinkingModule extends YesModule {
  final LevelTowCategoriesListScreen levelTowCategoriesListScreen;
  final StoreCategoriesLinkingScreen storeCategoriesLinkingScreen;
  final SubCategoriesLinkingScreen subCategoriesLinkingScreen;
  final SubCategoriesListScreen subCategoriesListScreen;
  LinkingModule(
      this.levelTowCategoriesListScreen,
      this.storeCategoriesLinkingScreen,
      this.subCategoriesLinkingScreen,
      this.subCategoriesListScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      LinkingRoutes.CATEGORIES_LEVEL2: (context) =>
          levelTowCategoriesListScreen,
      LinkingRoutes.STORE_CATEGORIES_LINKING: (context) =>
          storeCategoriesLinkingScreen,
      LinkingRoutes.SUB_CATEGORIES: (context) => subCategoriesListScreen,
      LinkingRoutes.SUB_CATEGORIES_LINKING: (context) =>
          subCategoriesLinkingScreen,
    };
  }
}
