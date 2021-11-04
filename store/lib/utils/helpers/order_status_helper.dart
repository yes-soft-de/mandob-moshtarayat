import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class StatusHelper {
  static OrderStatusEnum getStatusEnum(String? status) {
    if (status == 'pending') {
      return OrderStatusEnum.WAITING;
    } else if (status == 'on way to pick order') {
      return OrderStatusEnum.GOT_CAPTAIN;
    } else if (status == 'in store') {
      return OrderStatusEnum.IN_STORE;
    } else if (status == 'ongoing') {
      return OrderStatusEnum.DELIVERING;
    } else if (status == 'delivered') {
      return OrderStatusEnum.FINISHED;
    } else if (status == 'cancelled') {
      return OrderStatusEnum.CANCELLED;
    }
    return OrderStatusEnum.WAITING;
  }

  static String getStatusString(OrderStatusEnum? status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return 'pending';
      case OrderStatusEnum.IN_STORE:
        return 'in store';
      case OrderStatusEnum.DELIVERING:
        return 'ongoing';
      case OrderStatusEnum.GOT_CAPTAIN:
        return 'on way to pick order';
      case OrderStatusEnum.FINISHED:
        return 'delivered';
      case OrderStatusEnum.CANCELLED:
        return 'cancelled';
      default:
        return 'pending';
    }
  }

  static String getOrderStatusMessages(OrderStatusEnum? orderStatus) {
    switch (orderStatus) {
      case OrderStatusEnum.WAITING:
        return S.current.waiting;
      case OrderStatusEnum.IN_STORE:
        return S.current.captainInStore;
      case OrderStatusEnum.DELIVERING:
        return S.current.captainIsDelivering;
      case OrderStatusEnum.GOT_CAPTAIN:
        return S.current.captainAcceptedOrder;
      case OrderStatusEnum.FINISHED:
        return S.current.iFinishedDelivering;
      case OrderStatusEnum.CANCELLED:
        return S.current.cancelled;
      default:
        return S.current.waiting;
    }
  }

  static String getOrderStatusDescriptionMessages(OrderStatusEnum orderStatus) {
    switch (orderStatus) {
      case OrderStatusEnum.WAITING:
        return S.current.waitingDescription;
      case OrderStatusEnum.IN_STORE:
        return S.current.captainInStoreDescription;
      case OrderStatusEnum.DELIVERING:
        return S.current.deliveringDescription;
      case OrderStatusEnum.GOT_CAPTAIN:
        return S.current.captainAcceptOrderDescription;
      case OrderStatusEnum.FINISHED:
        return S.current.orderDeliveredDescription;
      case OrderStatusEnum.CANCELLED:
        return S.current.cancelledHint;
      default:
        return S.current.waitingDescription;
    }
  }

  static IconData getOrderStatusIcon(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return Icons.timer_rounded;
      case OrderStatusEnum.IN_STORE:
        return Icons.store_rounded;
      case OrderStatusEnum.DELIVERING:
        return Icons.pedal_bike_rounded;
      case OrderStatusEnum.GOT_CAPTAIN:
        return Icons.account_circle_rounded;
      case OrderStatusEnum.FINISHED:
        return Icons.check_circle_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }

  static Color getOrderStatusColor(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return Colors.amber;
      case OrderStatusEnum.IN_STORE:
        return Colors.blue;
      case OrderStatusEnum.DELIVERING:
        return Colors.orange;
      case OrderStatusEnum.GOT_CAPTAIN:
        return Colors.yellow;
      case OrderStatusEnum.FINISHED:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  static int getOrderStatusIndex(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return 0;
      case OrderStatusEnum.IN_STORE:
        return 2;
      case OrderStatusEnum.DELIVERING:
        return 3;
      case OrderStatusEnum.GOT_CAPTAIN:
        return 1;
      case OrderStatusEnum.FINISHED:
        return 4;
      default:
        return 0;
    }
  }
}
