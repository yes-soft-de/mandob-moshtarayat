import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

class StoreProductsTitleBar extends StatelessWidget {
  final String title;
  final num rate;
  final int views;
  final num deliveryCost;
  const StoreProductsTitleBar(
      {required this.title,
      required this.rate,
      required this.views,
      required this.deliveryCost});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  fontSize: 18,
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Hider(active: false, child: Icon(Icons.circle, size: 8)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    rate.toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.white,
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
