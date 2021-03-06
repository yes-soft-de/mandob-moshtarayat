import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/state_manager/store_products_state_manager.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_loading_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_state.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';

@injectable
class StoreProductsScreen extends StatefulWidget {
  final StoreProductsStateManager stateManager;
  final AuthService _authService;
  const StoreProductsScreen(this.stateManager, this._authService);

  @override
  StoreProductsScreenState createState() => StoreProductsScreenState();
}

class StoreProductsScreenState extends State<StoreProductsScreen> {
  late StoreProductsState currentState;
  late AsyncSnapshot snapshot = const AsyncSnapshot.nothing();
  late AuthService authService;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void getProductsByCategory(storeId, categoryId) async {
    widget.stateManager.getProductsByCategory(storeId, categoryId);
  }

  void getStoresProducts(int id) {
    widget.stateManager.getStoresProducts(id, this);
  }

  void rateStore(RateStoreRequest request) {
    widget.stateManager.rateStore(request, this);
  }

  @override
  void initState() {
    currentState = StoreProductsLoadingState(this);
    authService = widget._authService;
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
    widget.stateManager.categoryStream.listen((event) {
      snapshot = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool flag = true;
  int storeId = -1;
  late String backgroundImage;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (flag && args is StoreModel) {
      storeId = args.id;
      widget.stateManager.getStoresProducts(args.id, this);
      flag = false;
    } else if (flag && args is Map) {
      storeId = int.parse(args['storeId']);
      widget.stateManager.getStoresProducts(int.parse(args['storeId']), this);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          body: FixedContainer(child: currentState.getUI(context)),
        ),
      ),
    );
  }
}
