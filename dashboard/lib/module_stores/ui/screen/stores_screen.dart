import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/create_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/state_manager/stores_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/floated_button.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';

@injectable
class StoresScreen extends StatefulWidget {
  final StoresStateManager _stateManager;

  StoresScreen(this._stateManager);

  @override
  StoresScreenState createState() => StoresScreenState();
}

class StoresScreenState extends State<StoresScreen> {
  late StoresState currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = StoresLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    widget._stateManager.getStores(this);
    super.initState();
  }

  void getStores() {
    widget._stateManager.getStores(this);
  }

  void addStore(CreateStoreRequest request) {
    widget._stateManager.createCategory(this, request);
  }

  void updateStore(UpdateStoreRequest request) {
    widget._stateManager.updateStore(this, request);
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
          title: S.of(context).storesList, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
  );
  }
}
