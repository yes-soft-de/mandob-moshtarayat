import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details_response.dart';

class ProductComponent extends StatefulWidget {
  final String productId;
  final String title;
  final String description;
  final String image;
  final String sold;
  final String discount;
  final double rating;
  final String storeId;
  final String storeName;
  final String price;
  final CostDetailsResponse? costDetailsResponse;
  int quantity;
  final Function(CartModel) onSelect;
  ProductComponent(
      {required this.title,
      required this.image,
      required this.sold,
      required this.discount,
      required this.rating,
      required this.description,
      required this.storeId,
      required this.productId,
      required this.storeName,
      required this.price,
      this.quantity = 0,
      required this.onSelect,
      required this.costDetailsResponse
      });

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  double imageSize = 175;
  @override
  Widget build(BuildContext context) {
    num disPrice = widget.costDetailsResponse?.costDetails?.priceFinal ??
        (num.parse(widget.price) * (100 - num.parse(widget.discount))) / 100;
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.of(context).pushNamed(ProductsRoutes.PRODUCT_DETAILS_SCREEN,
            arguments: int.parse(widget.productId));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 8,
                    ),
                    // price
                    Container(
                        constraints:
                            const BoxConstraints(maxHeight: 50, maxWidth: 200),
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:widget.costDetailsResponse?.costDetails?.priceWithCommission?.toStringAsFixed(2) ??  widget.price,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: widget.discount != '0'
                                          ? TextDecoration.lineThrough
                                          : null)),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: widget.discount == '0'
                                      ? ' '
                                      : disPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: S.current.sar,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: widget.discount != '0'
                                          ? Colors.red
                                          : null)),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    // store name
                    Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: Theme.of(context).primaryColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          S.current.seller,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          widget.storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).disabledColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // rate
                    Row(
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          S.current.rating,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: widget.rating,
                          minRating: 0,
                          itemSize: 15,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          onRatingUpdate: (rating) {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //sold & discount
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 2,
                          ),
                          Column(
                            children: [
                              Text(
                                S.current.discount,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MandobIcons.discount,
                                    size: 15,
                                    color: widget.discount == '0'
                                        ? Colors.red
                                        : Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.discount,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                right: 4.0, left: 4.0, bottom: 20),
                            child: Text(
                              ' | ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                S.current.sold,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.shoppingBag,
                                    size: 12,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.sold,
                                    style: const TextStyle(
                                      fontSize: 12,
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
                    const SizedBox(
                      height: 8,
                    ),
                    // quantity
                    Container(
                      height: 40,
                      width: 155,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        //  color: Theme.of(context).backgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? const Radius.circular(25)
                                          : Radius.zero,
                                      right: Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? Radius.zero
                                          : const Radius.circular(25)),
                                ),
                              ),
                            ),
                            onPressed: widget.quantity > 0
                                ? () {
                                    widget.quantity -= 1;
                                    widget.onSelect(CartModel(
                                      storeID: widget.storeId,
                                      id: int.parse(widget.productId),
                                      quantity: widget.quantity,
                                      price: disPrice.toDouble(),
                                      image: widget.image,
                                      name: widget.title,
                                    ));
                                    Flushbar(
                                      titleSize: 0,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      title: '',
                                      message: S.current.cartItemRemoved,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ).show(context);
                                    setState(() {});
                                  }
                                : null,
                            child: const Icon(Icons.remove),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(widget.quantity.toString()),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? Radius.zero
                                          : const Radius.circular(25),
                                      right: Localizations.localeOf(context)
                                                  .languageCode ==
                                              'en'
                                          ? const Radius.circular(25)
                                          : Radius.zero),
                                ),
                              ),
                            ),
                            onPressed: () {
                              widget.quantity += 1;
                              Flushbar(
                                titleSize: 0,
                                duration: const Duration(milliseconds: 1000),
                                title: '',
                                message: S.current.cartItemAdded,
                                backgroundColor: Theme.of(context).primaryColor,
                              ).show(context);
                              widget.onSelect(CartModel(
                                storeID: widget.storeId,
                                id: int.parse(widget.productId),
                                quantity: widget.quantity,
                                price: disPrice.toDouble(),
                                image: widget.image,
                                name: widget.title,
                              ));
                              setState(() {});
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: imageSize,
                height: imageSize,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomNetworkImage(
                        height: imageSize,
                        width: imageSize,
                        imageSource: widget.image),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
