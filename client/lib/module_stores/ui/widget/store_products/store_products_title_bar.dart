import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

class StoreProductsTitleBar extends StatelessWidget {
  final String title;
  final num rate;
  final int views;
  final num deliveryCost;
  StoreProductsTitleBar(
      {required this.title,
      required this.rate,
      required this.views,
      required this.deliveryCost});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4,
                ),
                Hider(
                  active: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${S.of(context).views} $views',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Hider(active: false, child: Icon(Icons.circle, size: 8)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    rate.toStringAsFixed(1),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 8,
                ),
                Icon(Icons.circle, size: 18,color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${S.of(context).deliverPrice} $deliveryCost ${S.of(context).sar}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
