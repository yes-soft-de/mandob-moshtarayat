import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';

class ProductComponent extends StatelessWidget {
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
  const ProductComponent(
      {required this.title,
      required this.image,
      required this.sold,
      required this.discount,
      required this.rating,
      required this.description,
      required this.storeId,
      required this.productId,
      required this.storeName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    num disPrice = (num.parse(price) * (100 - num.parse(discount))) / 100;
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.of(context).pushNamed(ProductsRoutes.PRODUCT_DETAILS_SCREEN,
            arguments: int.parse(productId));
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
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 8,
                    ),
                    // details
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 200),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
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
                                  text: price,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: discount != '0'
                                          ? TextDecoration.lineThrough
                                          : null)),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: discount == '0'
                                      ? ' '
                                      : disPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: S.current.sar,
                                  style:  TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: discount != '0' ? Colors.red : null
                                      )),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 16,
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
                          S.current.saller,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).disabledColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),  
                    // rate & sold & discount
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                S.current.rating,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: rating,
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
                          Column(
                            children: [
                              Text(
                                S.current.discount,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
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
                                    color: discount == '0'
                                        ? Colors.red
                                        : Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    discount,
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
                          Column(
                            children: [
                              Text(
                                S.current.sold,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
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
                                    sold,
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
                              onPressed: () {
                                
                              },
                              child: const Icon(Icons.remove),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text('0'),
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
                                
                              },
                              child: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8,),
                  ],
                ),
              )),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomNetworkImage(
                        height: 150, width: 150, imageSource: image),
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
