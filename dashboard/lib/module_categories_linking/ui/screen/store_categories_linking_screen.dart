import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/state_manager/store_categories_linking_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class StoreCategoriesLinkingScreen extends StatefulWidget {
  final StoreCategoriesLinkingStateManager _stateManager;
  final LocalizationService _localizationService;

  StoreCategoriesLinkingScreen(this._stateManager, this._localizationService);

  @override
  StoreCategoriesLinkingScreenState createState() =>
      StoreCategoriesLinkingScreenState();
}

class StoreCategoriesLinkingScreenState
    extends State<StoreCategoriesLinkingScreen> {
  late States currentState;
  bool canAddCategories = true;
  String? languageSelected;
  late String subCategories;
  @override
  void initState() {
    languageSelected = widget._localizationService.getLanguage();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getStoreCategories() {
    widget._stateManager.getStoreCategories(this, subCategories);
  }

  void updateCategory(MainLinkRequest request) {
    widget._stateManager.updateCategory(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments?.toString();
    if (args != null && flag) {
      subCategories = args;
      flag = false;
      widget._stateManager.getStoreCategories(this, args);
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).storeCategories),
      body: currentState.getUI(context),
    );
  }
}
