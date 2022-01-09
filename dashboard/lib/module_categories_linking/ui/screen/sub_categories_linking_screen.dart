import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/sub_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/state_manager/sub_categories_linking_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class SubCategoriesLinkingScreen extends StatefulWidget {
  final SubCategoriesLinkingStateManager _stateManager;

  SubCategoriesLinkingScreen(this._stateManager);

  @override
  SubCategoriesLinkingScreenState createState() =>
      SubCategoriesLinkingScreenState();
}

class SubCategoriesLinkingScreenState
    extends State<SubCategoriesLinkingScreen> {
  late States currentState;
  bool save = true;
  late String subCategories;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getProductsCategories() {
    widget._stateManager.getSubCategoriesLinking(this, subCategories);
  }

  void updateCategory(SubLinkRequest request) {
    widget._stateManager.updateCategory(this, request);
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
    var args = ModalRoute.of(context)?.settings.arguments?.toString();
    if (args != null && flagArgs) {
      subCategories = args;
      flagArgs = false;
      widget._stateManager.getSubCategoriesLinking(this, args);
    }
    return Scaffold(
      appBar:
          CustomTwaslnaAppBar.appBar(context, title: S.current.subCategories),
      body: currentState.getUI(context),
    );
  }
}
