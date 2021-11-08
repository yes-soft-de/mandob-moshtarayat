import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/utils/helpers/order_status_helper.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final OrderStatusEnum orderStatus;
  final String orderDate;
  final String orderCost;
  final String? completeTime;
  final GestureTapCallback? onTap;
  OrderCard({this.onTap, required this.orderId,required this.orderStatus,required this.orderDate,this.orderCost = '0',this.completeTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap:onTap ?? (){
          Navigator.pushNamed(context,OrdersRoutes.ORDER_TIME_LINE,arguments:orderId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Text(S.of(context).orderNumber,
                            style: TextStyle(fontSize: 14,color: Colors.white)),
                        Text(
                          '$orderId',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Text(S.of(context).orderDate,
                            style: TextStyle(fontSize: 14,color:Colors.white)),
                        Text(
                          orderDate,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    thickness: 2,
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      S.of(context).orderStatus,
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      StatusHelper.getOrderStatusMessages(orderStatus),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    thickness: 2,
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment:completeTime != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Text(completeTime != null ? S.of(context).completeTime : S.of(context).cost, style: TextStyle(fontSize: 14,color: Colors.white)),
                        Text(
                            completeTime != null ? '${completeTime.toString()}' : '${orderCost} ${S.of(context).sar}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    FaIcon(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? FontAwesomeIcons.arrowCircleLeft
                          : FontAwesomeIcons.arrowCircleRight,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
