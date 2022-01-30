import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/utils/components/progresive_image.dart';

class OrderChip extends StatefulWidget {
  final String title;
  final String image;
  final num price;
  final String currency;
  final int defaultQuantity;
  final int productID;
  OrderChip(
      {required this.title,
      required this.productID,
      required this.image,
      required this.price,
      this.currency = 'SAR',
      this.defaultQuantity = 0});
  @override
  _OrderChipState createState() => _OrderChipState();
}

class _OrderChipState extends State<OrderChip> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomNetworkImage(
                    imageSource: widget.image,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 26.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${widget.price.toStringAsFixed(2)} ${widget.currency}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                )),
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
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Text(
                          widget.defaultQuantity.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
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
