import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/model/products_details_model.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/products_details_screen.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductDetailsLoadedState extends States {
  ProductDetailsScreenState screenState;
  ProductsDetailsModel model;
  ProductDetailsLoadedState(this.screenState, this.model) : super(screenState) {
    quantity = getQuantity(model.id);
  }
  late int quantity;
  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Center(
              child: Text(
            model.productName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
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
                                          itemPadding: EdgeInsets.symmetric(
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
                                  SizedBox(
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
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '${model.discount}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
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
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '${model.soldCount}',
                                            style: TextStyle(
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
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context).primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${model.productPrice} \$',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          S.current.productQuantity,
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: 40,
                          width: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: true
                              ? Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )),
                                )
                              : Row(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .languageCode ==
                                                            'en'
                                                        ? Radius.circular(25)
                                                        : Radius.zero,
                                                    right: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .languageCode ==
                                                            'en'
                                                        ? Radius.zero
                                                        : Radius.circular(25)),
                                          ),
                                        ),
                                      ),
                                      onPressed: quantity > 0
                                          ? () {
                                              quantity = quantity - 1;
                                              screenState.refresh();
                                            }
                                          : null,
                                      child: Icon(Icons.remove),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(quantity.toString()),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .languageCode ==
                                                            'en'
                                                        ? Radius.zero
                                                        : Radius.circular(25),
                                                    right: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .languageCode ==
                                                            'en'
                                                        ? Radius.circular(25)
                                                        : Radius.zero),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        quantity = quantity + 1;
                                        screenState.refresh();
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ],
                                ),
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
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(
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
                            '${quantity * model.productPrice} \$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
