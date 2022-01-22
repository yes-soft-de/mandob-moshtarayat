import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/payments_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/paymen_from_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payments_list_screen.dart';

@injectable
class PaymentsModule extends YesModule {
  final PaymentsFromCaptainScreen _fromCaptainScreen;
  final PaymentsToCaptainScreen _paymentsToCaptainScreen;
  final PaymentsListScreen paymentsListScreen;
  PaymentsModule(this._fromCaptainScreen, this._paymentsToCaptainScreen,this.paymentsListScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      PaymentsRoutes.PAYMENTS_FROM_CAPTAIN: (context) => _fromCaptainScreen,
      PaymentsRoutes.PAYMENTS_TO_CAPTAIN: (context) => _paymentsToCaptainScreen,
      PaymentsRoutes.PAYMENTS_LIST: (context) => paymentsListScreen,
    };
  }
}
