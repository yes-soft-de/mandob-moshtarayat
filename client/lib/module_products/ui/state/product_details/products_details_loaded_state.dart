import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_home/model/products_by_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_products/model/products_details_model.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/products_details_screen.dart';
import 'package:mandob_moshtarayat/module_products/ui/widget/quantity_control.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductDetailsLoadedState extends States {
  ProductDetailsScreenState screenState;
  ProductsDetailsModel model;
  ProductDetailsLoadedState(this.screenState, this.model) : super(screenState) {
    quantity = getQuantity(model.id);
    screenState.getProducts(model.storeProductCategoryID);
  }
  late int quantity;
  @override
  Widget getUI(BuildContext context) {
    num disPrice =
        (model.productPrice * (100 - num.parse(model.discount))) / 100;
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          // product name
          Center(
              child: Text(
            model.productName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          // product image
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CustomNetworkImage(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  imageSource: model.productImage,
                ),
              ),
            ),
          ),
          // product info
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              width: double.maxFinite,
              decoration:  BoxDecoration(
                color:Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  // statistics card
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 75,
                                          child: Text(S.current.rating)),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: model.rate.toDouble(),
                                          minRating: 0,
                                          itemSize: 20,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 75,
                                          child: Text(S.current.discount)),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 1.0,
                                                bottom: 2.0,
                                                right: 2.0,
                                                left: 2.0),
                                            child: Icon(
                                              MandobIcons.discount,
                                              size: 18,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            model.discount + ' % ',
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 75,
                                          child: Text(S.current.sold)),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0,
                                                right: 3.0,
                                                left: 3.0),
                                            child: Icon(
                                              FontAwesomeIcons.shoppingBag,
                                              size: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            model.soldCount,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SvgPicture.asset(SvgAsset.ACHIEVEMENT_SVG,
                                      width: 40),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context).primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${model.productPrice.toStringAsFixed(2)} ${S.current.sar}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Seller
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              StoreRoutes.STORE_PRODUCTS,
                              arguments: {
                                'storeId': model.storeOwnerProfileID.toString()
                              });
                        },
                        leading: Icon(
                          FontAwesomeIcons.store,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(S.current.seller),
                        subtitle: Text(
                          model.storeOwnerName,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          S.current.productQuantity,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        QuantityControlWidget(
                          model: CartModel(
                              storeID: model.storeOwnerProfileID.toString(),
                              name: model.productName,
                              image: model.image,
                              id: model.id,
                              price: disPrice.toDouble(),
                              quantity: getQuantity(model.id)),
                          quantity: getQuantity(model.id),
                          onSelect: (cartModel) {
                            if (cartModel.quantity > 0) {
                              CartHiveHelper().addProductsToCart(cartModel);
                            }
                            if (cartModel.quantity == 0) {
                              CartHiveHelper().removeProductsToCart(cartModel);
                            }
                            screenState.refresh();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Row(
                      children: [
                        Text(
                          S.current.totalPrice,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: 40,
                          width: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                              child: Text(
                            '${(getQuantity(model.id) * model.productPrice).toStringAsFixed(2)} ${S.current.sar}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          )),
                        ),
                      ],
                    ),
                  ),
                 ListTile(
                    leading: Icon(
                      FontAwesomeIcons.shoppingCart,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(
                      S.current.similarProducts,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Checked(
                    checked: screenState.snapshot.hasData &&
                        screenState.snapshot.connectionState !=
                            ConnectionState.waiting,
                    child: Image.asset(ImageAsset.LOGO, width: 75, height: 75),
                    checkedWidget: SizedBox(
                      height: 125,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: _getProductsByStore(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getProductsByStore() {
    List<Widget> widgets = [];
    if (!screenState.snapshot.hasData) return widgets;
    screenState.snapshot.data.forEach((element) {
      widgets.add(InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.of(screenState.context).pushNamed(
                StoreRoutes.STORE_PRODUCTS,
                arguments: {'storeId': element.id.toString()});
          },
          child: HomeCard(title: element.productName, image: element.image)));
    });
    return widgets;
  }

  int getQuantity(int id) {
    if (CartHiveHelper().getCart().isEmpty) {
      return 0;
    } else {
      int quantity = 0;
      CartHiveHelper().getCart().forEach((element) {
        quantity = element.id == id ? element.quantity : quantity;
      });
      return quantity;
    }
  }
}
