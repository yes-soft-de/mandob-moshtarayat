import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';

class OrderProgressionHelper {
  static Widget getStatusIcon(
      OrderStatus status, double height, BuildContext context) {
    switch (status) {
      case OrderStatus.WAITING:
        return SvgPicture.asset(
          SvgAsset.SEARCHING_SVG,
          height: height,
        );
      case OrderStatus.GOT_CAPTAIN:
        return SvgPicture.asset(
          SvgAsset.DELIVER,
          height: height,
        );
      case OrderStatus.IN_STORE:
        return SvgPicture.asset(
          SvgAsset.ACCEPT_ORDER,
          height: height,
        );
      case OrderStatus.DELIVERING:
        return SvgPicture.asset(
          SvgAsset.ACCEPT_ORDER,
          height: height,
        );
      case OrderStatus.GOT_CASH:
        return SvgPicture.asset(
          SvgAsset.EARN_CASH,
          height: height,
        );
      case OrderStatus.FINISHED:
        return SvgPicture.asset(
          SvgAsset.SUCCESS_SVG,
          height: height,
        );
      default:
        return SvgPicture.asset(
          SvgAsset.ERROR_SVG,
          height: height,
        );
    }
  }

  static String getNextStageHelper(
      OrderStatus status, bool isOnline, BuildContext context) {
    switch (status) {
      case OrderStatus.WAITING:
        return S.of(context).acceptOrder;

      case OrderStatus.GOT_CAPTAIN:
        return S.of(context).iArrivedAtTheStore;

      case OrderStatus.IN_STORE:
        return S.of(context).iGotThePackage;

      case OrderStatus.DELIVERING:
        return S.of(context).iFinishedDelivering;

      case OrderStatus.FINISHED:
        return S.of(context).iFinishedDelivering;
      default:
        return S.of(context).orderIsInUndefinedState;
    }
  }

  static String getCurrentStageHelper(
      OrderStatus status, BuildContext context) {
    switch (status) {
      case OrderStatus.WAITING:
        return S.of(context).searchingForCaptain;
      case OrderStatus.GOT_CAPTAIN:
        return S.of(context).captainIsInTheWay;
      case OrderStatus.IN_STORE:
        return S.of(context).captainIsInStore;
      case OrderStatus.DELIVERING:
        return S.of(context).captainIsDelivering;
      case OrderStatus.FINISHED:
        return S.of(context).orderIsDone;
      default:
        return S.of(context).orderIsInUndefinedState;
    }
  }
}
