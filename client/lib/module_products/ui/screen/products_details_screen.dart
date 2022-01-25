import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_products/state_manager/products_state_manager.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/product_details/products_details_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/rate_dialog.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

@injectable
class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsStateManager _stateManager;

  const ProductDetailsScreen(this._stateManager);

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

  void getProducts(int id) {
    widget._stateManager.getSimilarProduct(this, id);
  }

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
    widget._stateManager.productsStream.listen((event) {
      snapshot = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  late AsyncSnapshot snapshot = const AsyncSnapshot.nothing();

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
            title: S.current.productDetails,
            actions: currentState is ProductDetailsLoadedState
                ? [
                    Hider(
                      active: getIt<AuthService>().isLoggedIn,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
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
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProductsRoutes.CART_SCREEN);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                : null),
        body: FixedContainer(child: currentState.getUI(context)),
      ),
    );
  }
}
