import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_products/ui/widget/cart_appbar.dart';
import 'package:mandob_moshtarayat/module_stores/model/checkout_model.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_loaded_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/bill.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/order_chip.dart';

@injectable
class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.settings.name ==
            ProductsRoutes.CART_SCREEN) {
          Navigator.of(context).pop();
          if (CartHiveHelper().getStoreID() != -1) {
            Navigator.of(context)
                .pushReplacementNamed(StoreRoutes.STORE_PRODUCTS, arguments: {
              'storeId': CartHiveHelper().getStoreID().toString()
            });
          }
        }
        return false;
      },
      child: Scaffold(
          appBar: ModalRoute.of(context)?.settings.name ==
                  ProductsRoutes.CART_SCREEN
              ? CustomTwaslnaAppBar.appBar(context, title: '', onTap: () {
                  Navigator.of(context).pop();
                  if (CartHiveHelper().getStoreID() != -1) {
                    Navigator.of(context).pushReplacementNamed(
                        StoreRoutes.STORE_PRODUCTS,
                        arguments: {
                          'storeId': CartHiveHelper().getStoreID().toString()
                        });
                  }
                })
              : null,
          body: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(8),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  CartAppBar(),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: Text(S.of(context).updateOrderNote),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: Divider(
                      color: Theme.of(context).backgroundColor,
                      thickness: 2.5,
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Hider(
                        active: CartHiveHelper().getCart().isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListTile(
                            leading: Icon(
                              Icons.shopping_cart_rounded,
                              color: Theme.of(context).disabledColor,
                              size: 25,
                            ),
                            title: Text(
                              S.of(context).orderList,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: getOrdersList(
                            CartHiveHelper().getProduct() ?? [], context),
                      ),
                      Container(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: CartHiveHelper().getCart().isEmpty
                                ? null
                                : () {
                                    List<Products> items = [];

                                    CartHiveHelper()
                                        .getCart()
                                        .forEach((element) {
                                      items.add(Products(
                                          productID: element.id,
                                          countProduct: element.quantity,
                                          storeId: element.storeID));
                                    });

                                    CheckoutModel checkoutModel = CheckoutModel(
                                        cart: items,
                                        orderCost: double.parse(getTotal()),
                                        deliveryCost: 0);
                                    Navigator.of(context).pushNamed(
                                        OrdersRoutes.CLIENT_ORDER,
                                        arguments: checkoutModel);
                                  },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.current.checkout,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Hider(
                        active: CartHiveHelper().getCart().isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BillCardDetails(
                            orderCost: total,
                            items: CartHiveHelper().getCart(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  List<Widget> getOrdersList(List<Products>? carts, context) {
    updateTotal();
    List<Widget> orderChips = [];
    carts?.forEach((element) {
      orderChips.add(SizedBox(
        key: ObjectKey(element),
        child: OrderChip(
          productID: element.productID!,
          title: element.productName ?? S.current.product,
          image: element.productsImage ?? ImageAsset.NETWORK,
          price: element.price!,
          currency: S.current.sar,
          quantity: (product) {
            if (product.countProduct == 0) {
              carts.forEach((element) {
                if (element.productID == product.productID) {
                  element.countProduct = product.countProduct;
                }
              });
              carts.removeWhere(
                  (element) => element.productID == product.productID);
              CartHiveHelper().setCart(carts);
            } else {
              carts.forEach((element) {
                if (element.productID == product.productID) {
                  element.countProduct = product.countProduct;
                }
                CartHiveHelper().setCart(carts);
              });
            }
            updateTotal();
          },
          editable: true,
          defaultQuantity: element.countProduct!,
        ),
      ));
      orderChips.add(Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: DottedLine(
          dashColor: Theme.of(context).backgroundColor,
          lineThickness: 2.5,
          dashLength: 6,
        ),
      ));
    });
    return orderChips;
  }

  List<Products> toProducts(List<Item> carts) {
    List<Products> products = [];
    carts.forEach((element) {
      products.add(Products(
          storeId: element.storeOwnerProfileID.toString(),
          productID: element.productID,
          countProduct: element.countProduct,
          price: element.productPrice,
          productsImage: element.productImage,
          productName: element.productName));
    });
    return products;
  }

  void updateTotal() {
    total = 0.0;
    List<CartModel> carts = CartHiveHelper().getCart();
    for (int i = 0; i < carts.length; i++) {
      total += carts[i].price * carts[i].quantity;
    }
    CartHiveHelper().setFinish();
    if (mounted) {
      setState(() {});
    }
  }
}
