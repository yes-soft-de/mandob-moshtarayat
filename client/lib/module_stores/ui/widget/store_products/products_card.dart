import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class ProductsCard extends StatefulWidget {
  final String title;
  final String image;
  final num price;
  final String currency;
  final Function(CartModel) quantity;
  final GestureTapCallback? onTap;
  final int defaultQuantity;
  final int id;
  const ProductsCard(
      {required this.title,
      required this.image,
      required this.price,
      this.currency = 'SAR',
      required this.quantity,
      this.defaultQuantity = 0,
      required this.id,
      this.onTap});

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  late CartModel cartModel;
  @override
  void initState() {
    super.initState();
    cartModel = CartModel(
        id: widget.id,
        quantity: widget.defaultQuantity,
        price: widget.price.toDouble(),
        name: widget.title,
        image: widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.maxFinite,
          height: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).backgroundColor,
                  spreadRadius: 7,
                  blurRadius: 4,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ]),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomNetworkImage(
                      imageSource: cartModel.image ?? widget.image,
                      width: 100,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 85,
                      ),
                      child: Text('${widget.price} ${S.current.sar}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 150,
                        ),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Row(
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
                              if (cartModel.quantity > 0) {
                                cartModel.quantity = cartModel.quantity - 1;
                                setState(() {
                                  widget.quantity(cartModel);
                                });
                              }
                            },
                            child: const Icon(Icons.remove),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(cartModel.quantity.toString()),
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
                              cartModel.quantity = cartModel.quantity + 1;
                              setState(() {
                                widget.quantity(cartModel);
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsSearchCard extends StatefulWidget {
  final String title;
  final String image;
  final num price;
  final VoidCallback onTap;
  const ProductsSearchCard(
      {required this.title,
      required this.image,
      required this.price,
      required this.onTap});

  @override
  _ProductsSearchCardState createState() => _ProductsSearchCardState();
}

class _ProductsSearchCardState extends State<ProductsSearchCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).backgroundColor,
                  spreadRadius: 7,
                  blurRadius: 4,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ]),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CustomNetworkImage(
                      imageSource: widget.image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${widget.price} ${S.current.sar}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
