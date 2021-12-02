import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/state_manager/products_state_manager.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/product_details/products_details_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/rate_dialog.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

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
        appBar: CustomTwaslnaAppBar.appBar(context,
            title: S.current.product,
            actions: currentState is ProductDetailsLoadedState
                ? [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => RatingAlertDialog(
                            title: S.current.rateProduct,
                            message: S.current.rateProductMessage,
                            image: (currentState as ProductDetailsLoadedState)
                                .model
                                .productImage,
                            onPressed: (rate) {
                              widget._stateManager.rateProduct(
                                  RateStoreRequest(
                                      rating: rate,
                                      itemType: 'product',
                                      itemID: productId),
                                  this);
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ]
                : null),
        body: currentState.getUI(context),
      ),
    );
  }
}
