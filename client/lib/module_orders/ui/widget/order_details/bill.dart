import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_tile.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

class BillCard extends StatelessWidget {
  final int? id;
  final double orderCost;
  final double deliveryCost;

  BillCard(
      {required this.id, required this.orderCost, required this.deliveryCost});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              S.of(context).bill,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Hider(
                  active: id != null,
                  child: Expanded(
                      child: CustomListTile(
                          title: S.of(context).orderNumber, subtitle: '#$id')),
                ),
                Expanded(
                    child: CustomListTile(
                        title: S.of(context).orderPrice,
                        subtitle:
                            '${orderCost.toStringAsFixed(2)} ${S.of(context).sar}')),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
            child: Divider(
              color: Colors.grey[400]?.withOpacity(0.3),
              thickness: 2.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).sum,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 16,
                ),
                Text(
                  '${(deliveryCost + orderCost).toStringAsFixed(2)} ${S.of(context).sar}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BillCardDetails extends StatefulWidget {
  final double orderCost;
  final List<CartModel> items;

  const BillCardDetails({required this.orderCost, required this.items});

  @override
  State<BillCardDetails> createState() => _BillCardDetailsState();
}

class _BillCardDetailsState extends State<BillCardDetails> {
  late List<Widget> items = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    items = [];
    if (widget.items.isNotEmpty) {
      items.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 75,
            child: Center(
              child: Text(
                S.current.item,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          ),
          SizedBox(
            width: 75,
            child: Center(
              child: Text(
                S.current.productQuantity,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          ),
          SizedBox(
            width: 75,
            child: Center(
              child: Text(
                S.current.cost,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          ),
        ],
      ));
      items.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: DottedLine(
            dashColor: Colors.grey[400]!.withOpacity(0.3),
            lineThickness: 2.5,
            dashLength: 6,
          ),
        ),
      );
    }
    widget.items.forEach((element) {
      items.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 75,
              child: Center(
                child: Text(
                  element.name ?? S.current.unknown,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 75,
              child: Center(
                child: Text(
                  'x ${element.quantity}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            SizedBox(
              width: 75,
              child: Center(
                child: Text(
                  (element.quantity * element.price).toStringAsFixed(2) +
                      ' ${S.current.sar} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ],
        ),
      ));
    });
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              S.of(context).bill,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: items,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
            child: Divider(
              color: Colors.grey[400]?.withOpacity(0.3),
              thickness: 2.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).sum,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 16,
                ),
                Text(
                  '${widget.orderCost.toStringAsFixed(2)} ${S.of(context).sar}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
