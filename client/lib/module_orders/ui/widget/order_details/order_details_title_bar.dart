import 'package:flutter/material.dart';
class OrderDetailsTitleBar extends StatelessWidget {
  final String title;
  final num rate;
  OrderDetailsTitleBar({required this.title,required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            rate.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Container(
            width: 8,
          ),
          Icon(
            Icons.star,
            size: 25,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
