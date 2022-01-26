import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class OrderChip extends StatefulWidget {
  final String title;
  final String image;
  final double price;
  final String currency;
  final Function(Products) quantity;
  final int defaultQuantity;
  final bool editable;
  final int productID;
  OrderChip(
      {Key? key,
      required this.title,
      required this.productID,
      required this.image,
      required this.price,
      this.currency = 'SAR',
      required this.quantity,
      this.defaultQuantity = 0,
      this.editable = true});
  @override
  _OrderChipState createState() => _OrderChipState();
}

class _OrderChipState extends State<OrderChip> {
  late Products products;
  @override
  void initState() {
    super.initState();
    products = Products(
        productID: widget.productID,
        productName: widget.title,
        productsImage: widget.image,
        price: widget.price,
        countProduct: widget.defaultQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      width: double.maxFinite,
      height: 100,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomNetworkImage(
                  imageSource: products.productsImage ?? widget.image,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${products.price?.toStringAsFixed(2) ?? widget.price.toStringAsFixed(2)} ${widget.currency}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    products.productName ?? widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: widget.editable
                        ? Flex(
                            direction: Axis.horizontal,
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
                                              ? Radius.circular(10)
                                              : Radius.zero,
                                          right: Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? Radius.zero
                                              : Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await CartHiveHelper().deleteCart();
                                  if (products.countProduct! > 0) {
                                    products.countProduct =
                                        products.countProduct! - 1;
                                    setState(() {
                                      widget.quantity(products);
                                    });
                                  }
                                },
                                child: Icon(Icons.remove),
                              ),
                              Text(products.countProduct.toString()),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? Radius.zero
                                              : const Radius.circular(10),
                                          right: Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? const Radius.circular(10)
                                              : Radius.zero),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await CartHiveHelper().deleteCart();
                                  products.countProduct =
                                      products.countProduct! + 1;
                                  setState(() {
                                    widget.quantity(products);
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          )
                        : Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 16),
                              child: Text(
                                products.countProduct.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
