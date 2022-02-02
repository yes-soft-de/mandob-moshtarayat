import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class LogCard extends StatelessWidget {
  final String orderId;
  final OrderStatusEnum orderStatus;
  final String orderDate;
  final String orderCost;
  final String? completeTime;
  final String orderType;
  final String deliverPrice;
  LogCard(
      {required this.orderId,
      required this.orderStatus,
      required this.orderDate,
      this.orderCost = '0',
      this.completeTime,
      required this.orderType,
      required this.deliverPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, OrdersRoutes.ORDER_DETAILS,
              arguments: orderId);
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
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
                          fontWeight: FontWeight.bold, color: Colors.white),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        S.of(context).orderType,
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        orderType,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        S.of(context).deliverPrice,
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        deliverPrice,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
