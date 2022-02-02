import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/state_manager/sub_categories_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class SubCategoriesListScreen extends StatefulWidget {
  final SubCategoriesListStateManager _stateManager;
  final LocalizationService _localizationService;

  SubCategoriesListScreen(this._stateManager, this._localizationService);

  @override
  SubCategoriesListScreenState createState() => SubCategoriesListScreenState();
}

class SubCategoriesListScreenState extends State<SubCategoriesListScreen> {
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
    widget._stateManager.getCategoriesLevelOne(this);
    super.initState();
  }

  void getSubCategories() {
    widget._stateManager.getCategoriesLevelOne(this);
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
    );
  }
}
