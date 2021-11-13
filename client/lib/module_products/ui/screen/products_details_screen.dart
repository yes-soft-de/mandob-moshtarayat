import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/state_manager/products_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';


@injectable
class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsStateManager _stateManager;

  ProductDetailsScreen(this._stateManager);

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late States currentState;
  bool flagId = true;
  late int productId;

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
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is int && flagId) {
      productId = args;
       widget._stateManager.getProducts(args, this);
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
