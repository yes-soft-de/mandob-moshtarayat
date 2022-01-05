import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/state_manager/store_list_state_manager.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_loading_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_state.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

@injectable
class StoreListScreen extends StatefulWidget {
  final StoreListStateManager _storeListManager;

  const StoreListScreen(this._storeListManager);

  @override
  StoreListScreenState createState() => StoreListScreenState();
}

class StoreListScreenState extends State<StoreListScreen> {
  late StoreListState currentState;
  bool flagId = true;
  String? title;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void getStoreList(int id) {
    widget._storeListManager.getStoresCategoryList(id, this);
  }

  @override
  void initState() {
    super.initState();
    currentState = StoreListLoadingState(this);
    widget._storeListManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreCategoryModel && flagId) {
      title = args.storeCategoryName;
      widget._storeListManager.getStoresCategoryList(args.id, this);
      flagId = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          body: FixedContainer(
              child: currentState.getUI(context)),
        ),
      ),
    );
  }
}
