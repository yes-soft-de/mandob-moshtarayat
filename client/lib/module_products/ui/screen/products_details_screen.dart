import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/product_details/products_details_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/state_manager/store_list_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
@injectable
class ProductDetailsScreen extends StatefulWidget {
  final StoreListStateManager _storeListManager;

  ProductDetailsScreen(this._storeListManager);

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late States currentState;
  bool flagId = true;
  String? title;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void getStoreList(int id) {
   // widget._storeListManager.getStoresCategoryList(id, this);
  }

  @override
  void initState() {
    super.initState();
    currentState = ProductDetailsLoadedState(this);
    // widget._storeListManager.stateStream.listen((event) {
    //   currentState = event;
    //   if (mounted) setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreCategoryModel && flagId) {
      title = args.storeCategoryName;
     // widget._storeListManager.getStoresCategoryList(args.id, this);
      flagId = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomTwaslnaAppBar.appBar(context, title: S.current.product),
        body: currentState.getUI(context),
      ),
    );
  }
}
