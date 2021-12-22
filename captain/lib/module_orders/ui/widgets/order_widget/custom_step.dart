import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';

class CustomStep extends StatelessWidget {
  final OrderStatus status;
  final int currentIndex;
  CustomStep({required this.status, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex >= StatusHelper.getOrderStatusIndex(status)
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(
            currentIndex >= StatusHelper.getOrderStatusIndex(status)
                ? 18.0
                : 14),
        child: Text(
          '${StatusHelper.getOrderStatusIndex(status) + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

class CustomStepForStore extends StatelessWidget {
  final OrderStatus status;
  final int currentIndex;
  CustomStepForStore({required this.status, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex >= StatusHelper.getOrderStatusIndex(status)
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(
            currentIndex >= StatusHelper.getOrderStatusIndex(status)
                ? 18.0
                : 14),
        child: Text(
          '${StatusHelper.getOrderStatusIndexForStore(status) + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
