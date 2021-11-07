import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class PrivateOrderTitleBar extends StatelessWidget {
  final String title;
  final double rate;
  final int views;
  final num deliveryCost;
  PrivateOrderTitleBar(
      {required this.title,
      required this.rate,
      required this.views,
      required this.deliveryCost});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(top:6.0),
            child: Text(
              rate.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
          Container(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Icon(
              Icons.star,
              color: Colors.white,
              size: 18,
            ),
          ),
          Container(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(top:6.0),
            child: Icon(Icons.circle, size: 18,color: Colors.white,),
          ),
          Padding(
            padding: const EdgeInsets.only(top:6.0,left: 8.0,right: 8.0),
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
    );
  }
}
