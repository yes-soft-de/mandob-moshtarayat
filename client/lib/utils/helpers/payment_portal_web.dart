import 'package:flutter/material.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:mandob_moshtarayat/consts/country_code.dart';
import 'package:mandob_moshtarayat/consts/payment_secret_keys.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:webviewx/webviewx.dart';

class PaymentPortalWeb {
  final String firstName;
  final String email;
  final String phoneNumber;
  final String middleName;
  final String lastName;
  final String amount;
  final List<PaymentItem> items;
  final String transID;
  final String orderID;
  final BuildContext context;
  PaymentPortalWeb(
      {required this.firstName,
      required this.email,
      required this.phoneNumber,
      required this.middleName,
      required this.lastName,
      required this.amount,
      required this.items,
      required this.transID,
      required this.orderID,
      required this.context});

  Future<void> startSdk() async {
    print(_paymentPage());
    late WebViewXController webviewController;
    showDialog(
        context: context,
        builder: (context) => Scaffold(
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: WebViewX(
                      key: const ValueKey(''),
                      initialContent: _paymentPage(),
                      initialSourceType: SourceType.html,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) =>
                          webviewController = controller,
                      onPageFinished: (src) =>
                          debugPrint('✓ The page has finished loading!\n'),
                      dartCallBacks: {
                        DartCallback(
                          name: 'callback',
                          callBack: (msg) {
                            print(msg.toString());
                          },
                        ),
                        DartCallback(
                          name: 'callbackLoad',
                          callBack: (msg) {
                            if (msg) {}
                          },
                        ),
                        DartCallback(
                          name: 'callbackError',
                          callBack: (msg) {
                            if (msg) {}
                          },
                        ),
                      },
                      webSpecificParams: const WebSpecificParams(),
                      mobileSpecificParams: const MobileSpecificParams(
                        androidEnableHybridComposition: true,
                      ),
                    ),
                  ),
                ],
              ),
            ));
    return;
  }

  String _paymentPage() {
    List<Map> map = [];
    int i = 0;
    items.forEach((element) {
      map.add({
        'id': i,
        'name': element.name,
        'description': '',
        'quantity': element.quantity,
        'amount_per_unit': element.amountPerUnit,
        'discount': element.discount,
        'total_amount': element.totalAmount,
      });
      i++;
    });
    return '''<!DOCTYPE html>
    <html>
<head>
    <title>Payment Portal</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="shortcut icon" href="https://goSellJSLib.b-cdn.net/v2.0.0/imgs/tap-favicon.ico" />
    <link href="https://goSellJSLib.b-cdn.net/v2.0.0/css/gosell.css" rel="stylesheet" />
</head>

<body>
    <script type="text/javascript" src="https://goSellJSLib.b-cdn.net/v2.0.0/js/gosell.js"></script>

    <div id="root"></div>
    <button id="openLightBox" onclick="goSell.openLightBox()">
      open goSell LightBox
    </button>
    <button id="openPage" onclick="goSell.openPaymentPage()">
      open goSell Page
    </button>
        <script>
        goSell.showResult({
            callback: (response) => {
                console.log("callback", response);
            },
        });
    </script>
</body>

</html> ''';
  }
}
