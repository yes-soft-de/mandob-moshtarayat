import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/state_manager/categories_level2_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/global_state_manager.dart';

@injectable
class LevelTowCategoriesListScreen extends StatefulWidget {
  final CategoriesLevel2ListStateManager stateManager;
  final LocalizationService _localizationService;

  LevelTowCategoriesListScreen(this.stateManager, this._localizationService);

  @override
  LevelTowCategoriesListScreenState createState() =>
      LevelTowCategoriesListScreenState();
}

class LevelTowCategoriesListScreenState
    extends State<LevelTowCategoriesListScreen> {
  late States currentState;
  bool canAddCategories = true;
  String? mainCatId;
  String? subCatId;

  String? languageSelected;

  @override
  void initState() {
    languageSelected = widget._localizationService.getLanguage();
    currentState = LoadingState(this);
    getSubCategoriesLevelTow();
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
      getIt<GlobalStateManager>().updateCaptainList();
    });
    super.initState();
  }

  void getSubCategoriesLevelTow() {
    widget.stateManager.getCategoriesLevel2(this);
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
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).categoriesLevel2, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
