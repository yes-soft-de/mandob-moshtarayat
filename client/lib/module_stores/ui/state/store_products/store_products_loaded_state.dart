import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_stores/model/category_model.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/checkout_button.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/custom_stores_products_app_bar.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/products_card.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/products_chip.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/products_zone.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/store_products_title_bar.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/components/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/models/product.dart';

class StoreProductsLoadedState extends StoreProductsState {
  StoreProductsScreenState screenState;
  List<ProductModel> topWantedProducts;
  List<CategoryModel> productsCategory;
  StoreProfile storeProfile;
  List<CartModel>? orderCart;
  StoreProductsLoadedState(this.screenState,
      {required this.storeProfile,
      required this.topWantedProducts,
      required this.productsCategory,
      required this.orderCart})
      : super(screenState) {
    if (orderCart != null) {
      fromEditingOrder = false;
      carts = orderCart ?? [];
    }
  }
  late String title;
  late String backgroundImage;
  String defaultValue = S.current.mostWanted;
  List<CartModel> carts = [];
  late int storeId;
  int categoryId = -1;
  late num deliveryCost;
  bool fromEditingOrder = false;
  num rate = -1;
  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    title = storeProfile.storeOwnerName;
    backgroundImage = storeProfile.image;
    storeId = storeProfile.id;
    deliveryCost = storeProfile.deliveryCost;
    rate = storeProfile.rating ?? 0;

    return Stack(
      children: [
        CustomNetworkImage(
          imageSource: backgroundImage,
          height: height * 0.5,
          width: width,
        ),
        CustomStoresProductsAppBar(
          isLogin: screenState.authService.isLoggedIn,
          image: backgroundImage,
          onRate: (rate) {
            screenState.rateStore(RateStoreRequest(
                itemID: storeId, itemType: 'store', rating: rate));
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black.withOpacity(0.45),
            height: height * 0.65,
            width: double.maxFinite,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.black.withOpacity(0.45),
                child: StoreProductsTitleBar(
                    title: title,
                    rate: rate,
                    views: 40,
                    deliveryCost: deliveryCost),
              ),
              Container(
                height: height * 0.65,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  color: Theme.of(context).cardColor,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          Hider(
                            active: false,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 28.0, left: 28.0, bottom: 25),
                              child: CustomDeliverySearch(
                                hintText: S.of(context).searchFor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: SizedBox(
                              height: 44,
                              child: ListView(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: getCategories(productsCategory),
                              ),
                            ),
                          ),
                          ProductsZone(
                              loading: screenState.snapshot.connectionState ==
                                  ConnectionState.waiting,
                              children: getProducts(
                                  defaultValue == S.current.mostWanted
                                      ? topWantedProducts
                                      : screenState.snapshot.data ??
                                          <ProductModel>[]),
                              snapshot: screenState.snapshot),
                          const SizedBox(
                            height: 75,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CheckoutButton(
                        quantity: getItemsCount(),
                        onPressed: carts.isNotEmpty
                            ? () {
                                List<Products> items = [];
                                carts.forEach((element) {
                                  items.add(Products(
                                      storeId: screenState.storeId.toString(),
                                      productID: element.id,
                                      countProduct: element.quantity));
                                });

                                // CheckoutModel checkoutModel = CheckoutModel(
                                //     ownerId: storeId,
                                //     cart: items,
                                //     orderCost: double.parse(getTotal()),
                                //     deliveryCost: deliveryCost);

                                if (fromEditingOrder) {
                                  CartHiveHelper().setCart(carts);
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context)
                                      .pushNamed(ProductsRoutes.CART_SCREEN)
                                      .then((value) =>
                                          screenState.getStoresProducts(
                                              screenState.storeId));
                                  // Navigator.of(context).pushNamed(
                                  //     OrdersRoutes.CLIENT_ORDER,
                                  //     arguments: checkoutModel);
                                }
                              }
                            : () {
                                CustomFlushBarHelper.createError(
                                        title: S.of(context).warnning,
                                        message: S.of(context).yourCartEmpty)
                                    .show(context);
                              },
                        total: getTotal(),
                        currency: S.of(context).sar,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getProducts(List<ProductModel> topWantedProducts) {
    if (topWantedProducts.isEmpty) return [];
    List<Widget> prods = [];
    topWantedProducts.forEach((element) {
      prods.add(SizedBox(
        key: ObjectKey(element),
        child: ProductsCard(
            storeId: screenState.storeId.toString(),
            onTap: () {
              Navigator.of(screenState.context).pushNamed(
                  ProductsRoutes.PRODUCT_DETAILS_SCREEN,
                  arguments: element.id);
            },
            id: element.id,
            title: element.title,
            image: element.image,
            price: element.costDetails?.priceFinal ?? element.price,
            defaultQuantity: getQuantity(element.id),
            quantity: (cartModel) {
              if (cartModel.quantity > 0) {
                addToCart(cartModel);
              }
              if (cartModel.quantity == 0) {
                carts.removeWhere((e) => e.id == cartModel.id);
                CartHiveHelper().removeProductsToCart(cartModel);
              }
              screenState.refresh();
            }),
      ));
    });
    return prods;
  }

  void addToCart(cartModel) {
    carts.removeWhere((e) => e.id == cartModel.id);
    carts.add(cartModel);
    CartHiveHelper().addProductsToCart(cartModel);
  }

  List<Widget> getCategories(List<CategoryModel> categoriesModel) {
    if (categoriesModel.isEmpty) {
      return [
        ProductsChips(
          id: -1,
          onChange: (value, id) {
            defaultValue = value;
            categoryId = id;
            screenState.snapshot = const AsyncSnapshot.nothing();
            screenState.refresh();
          },
          title: S.current.mostWanted,
          active: defaultValue == S.current.mostWanted,
        )
      ];
    }
    List<ProductsChips> cats = [];
    cats.add(ProductsChips(
      id: -1,
      onChange: (value, id) {
        defaultValue = value;
        categoryId = id;
        screenState.snapshot = const AsyncSnapshot.nothing();
        screenState.refresh();
      },
      title: S.current.mostWanted,
      active: defaultValue == S.current.mostWanted,
    ));
    categoriesModel.forEach((element) {
      cats.add(ProductsChips(
        id: element.id,
        title: element.label,
        active: defaultValue == element.label && categoryId == element.id,
        onChange: (value, id) {
          defaultValue = value;
          categoryId = id;
          screenState.getProductsByCategory(storeId, categoryId);
          //screenState.refresh();
        },
      ));
    });
    return cats;
  }

  int getQuantity(int id) {
    if (carts.isEmpty) {
      return 0;
    } else {
      int quantity = 0;
      carts.forEach((element) {
        quantity = element.id == id ? element.quantity : quantity;
      });
      return quantity;
    }
  }
}

dynamic getTotal() {
  List<CartModel> carts = CartHiveHelper().getCart();
  var total = 0.0;
  for (int i = 0; i < carts.length; i++) {
    total += carts[i].price * carts[i].quantity;
  }
  return total.toString();
}

String getItemsCount() {
  List<CartModel> carts = CartHiveHelper().getCart();
  return carts.length.toString();
}
