import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_tile.dart';

class BillCard extends StatelessWidget {
  final String id;
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
              style: TextStyle(
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
                Expanded(
                    child: CustomListTile(
                        title: S.of(context).orderNumber, subtitle: '#$id')),
                Expanded(
                    child: CustomListTile(
                        title: S.of(context).orderPrice,
                        subtitle: '$orderCost ${S.of(context).sar}')),
                Expanded(
                    child: CustomListTile(
                  title: S.of(context).deliverPrice,
                  subtitle: '$deliveryCost ${S.of(context).sar}',
                ))
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 16,
                ),
                Text(
                  '${deliveryCost + orderCost} ${S.of(context).sar}',
                  style: TextStyle(
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
