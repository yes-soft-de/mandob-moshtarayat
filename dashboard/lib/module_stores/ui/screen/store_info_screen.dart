import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/state_manager/store_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class StoreInfoScreen extends StatefulWidget {
  final StoreProfileStateManager stateManager;

  StoreInfoScreen(this.stateManager);

  @override
  StoreInfoScreenState createState() => StoreInfoScreenState();
}

class StoreInfoScreenState extends State<StoreInfoScreen> {
  bool flagArgs = true;
  late States currentState;
  StoresModel? model;

  void getStore(int id) {
    widget.stateManager.getStore(this, id);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      if (args is StoresModel) {
        model = args;
        flagArgs = false;
        getStore(model?.id ?? -1);
      }
    }

    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: model?.storeOwnerName ?? S.current.storeName,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  Navigator.of(context).pushNamed(StoresRoutes.STORE_BALANCE,
                      arguments: model?.id ?? -1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.account_balance_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
      body: currentState.getUI(context),
    );
  }
}
