import 'dart:io';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'dart:async';

import 'package:mandob_moshtarayat/utils/helpers/tab_loader.dart';

@injectable
class PaymentsPortal extends StatefulWidget {
  @override
  _PaymentsPortalState createState() => _PaymentsPortalState();
}

class _PaymentsPortalState extends State<PaymentsPortal> {
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = '';
  String sdkStatus = '';
  String? sdkErrorCode;
  String? sdkErrorMessage;
  String? sdkErrorDescription;
  AwesomeLoaderController loaderController = AwesomeLoaderController();

  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = Color(0xff2ace00);
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession();
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
        bundleId: Platform.isAndroid
            ? 'de.yessoft.mandob_moshtarayat_client'
            : 'iOS-BUNDLE-ID',
        productionSecreteKey: Platform.isAndroid
            ? 'sk_live_Nii9aC8wbQsh3rMK:DIAjpfZ'
            : 'sk_live_Nii9aC8wbQsh3rMK:DIAjpfZ',
        sandBoxsecretKey: Platform.isAndroid
            ? 'sk_test_46BsGCc3d8aUHWZ1krFPulDE'
            : 'sk_test_46BsGCc3d8aUHWZ1krFPulDE',
        lang: getIt<LocalizationService>().getLanguage());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession() async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.TOKENIZE_CARD,
          paymentItems: [],
          paymentMetaData: {},
          taxes: [],
          shippings: [],
          customer: Customer(
              customerId:
                  '', // customer id is important to retrieve cards saved for this customer
              email: '',
              isdNumber: '',
              number: '',
              firstName: '',
              middleName: '',
              lastName: '',
              metaData: null),
          transactionCurrency: 'sar',
          amount: '10',
          // Post URL
          postURL: 'https://tap.company',
          // Payment description
          paymentDescription: 'paymentDescription',
          // Payment Reference
          paymentReference: Reference(
              acquirer: 'acquirer',
              gateway: 'gateway',
              payment: 'payment',
              track: 'track',
              transaction: 'trans_910101',
              order: 'order_262625'),
          // payment Descriptor
          paymentStatementDescriptor: 'paymentStatementDescriptor',
          // Save Card Switch
          isUserAllowedToSaveCard: false,
          // Enable/Disable 3DSecure
          isRequires3DSecure: false,
          // Receipt SMS/Email
          receipt: Receipt(true, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(
              type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: '13120685',
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: 'applePayMerchantID',
          allowsToSaveSameCardMoreThanOnce: false,
          // pass the card holder name to the SDK
          cardHolderName: 'Card Holder NAME',
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Sandbox);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }

  Future<void> startSDK() async {
    setState(() {
      loaderController.start();
    });

    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    loaderController.stopWhenFull();

    print('>>>> ${tapSDKResult['sdk_result']}');
    setState(() {
      switch (tapSDKResult['sdk_result']) {
        case 'SUCCESS':
          sdkStatus = 'SUCCESS';
          handleSDKResult();
          break;
        case 'FAILED':
          sdkStatus = 'FAILED';
          handleSDKResult();
          break;
        case 'SDK_ERROR':
          print('sdk error............');
          print(tapSDKResult['sdk_error_code']);
          print(tapSDKResult['sdk_error_message']);
          print(tapSDKResult['sdk_error_description']);
          print('sdk error............');
          sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          sdkErrorMessage = tapSDKResult['sdk_error_message'];
          sdkErrorDescription = tapSDKResult['sdk_error_description'];
          break;

        case 'NOT_IMPLEMENTED':
          sdkStatus = 'NOT_IMPLEMENTED';
          break;
      }
    });
  }

  void handleSDKResult() {
    switch (tapSDKResult['trx_mode']) {
      case 'CHARGE':
        printSDKResult('Charge');
        break;

      case 'AUTHORIZE':
        printSDKResult('Authorize');
        break;

      case 'SAVE_CARD':
        printSDKResult('Save Card');
        break;

      case 'TOKENIZE':
        print('TOKENIZE token : ${tapSDKResult['token']}');
        print('TOKENIZE token_currency  : ${tapSDKResult['token_currency']}');
        print('TOKENIZE card_first_six : ${tapSDKResult['card_first_six']}');
        print('TOKENIZE card_last_four : ${tapSDKResult['card_last_four']}');
        print('TOKENIZE card_object  : ${tapSDKResult['card_object']}');
        print('TOKENIZE card_exp_month : ${tapSDKResult['card_exp_month']}');
        print('TOKENIZE card_exp_year    : ${tapSDKResult['card_exp_year']}');

        responseID = tapSDKResult['token'];
        break;
    }
  }

  void printSDKResult(String trx_mode) {
    print('$trx_mode status                : ${tapSDKResult['status']}');
    print('$trx_mode id               : ${tapSDKResult['charge_id']}');
    print('$trx_mode  description        : ${tapSDKResult['description']}');
    print('$trx_mode  message           : ${tapSDKResult['message']}');
    print('$trx_mode  card_first_six : ${tapSDKResult['card_first_six']}');
    print('$trx_mode  card_last_four   : ${tapSDKResult['card_last_four']}');
    print('$trx_mode  card_object         : ${tapSDKResult['card_object']}');
    print('$trx_mode  card_brand          : ${tapSDKResult['card_brand']}');
    print('$trx_mode  card_exp_month  : ${tapSDKResult['card_exp_month']}');
    print('$trx_mode  card_exp_year: ${tapSDKResult['card_exp_year']}');
    print('$trx_mode  acquirer_id  : ${tapSDKResult['acquirer_id']}');
    print(
        '$trx_mode  acquirer_response_code : ${tapSDKResult['acquirer_response_code']}');
    print(
        '$trx_mode  acquirer_response_message: ${tapSDKResult['acquirer_response_message']}');
    print('$trx_mode  source_id: ${tapSDKResult['source_id']}');
    print('$trx_mode  source_channel     : ${tapSDKResult['source_channel']}');
    print('$trx_mode  source_object      : ${tapSDKResult['source_object']}');
    print(
        '$trx_mode source_payment_type : ${tapSDKResult['source_payment_type']}');
    responseID = tapSDKResult['charge_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomTwaslnaAppBar.appBar(context, title: 'Taps Payments'),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 300,
                left: 18,
                right: 18,
                child: Text('Status: [$sdkStatus $responseID ]',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                    textAlign: TextAlign.center),
              ),
              Positioned(
                bottom: Platform.isIOS ? 0 : 10,
                left: 18,
                right: 18,
                child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                      color: _buttonColor,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30))),
                      onPressed: startSDK,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              child: AwesomeLoader(
                                outerColor: Colors.white,
                                innerColor: Colors.white,
                                strokeWidth: 3.0,
                                controller: loaderController,
                              ),
                            ),
                            Spacer(),
                            Text('PAY',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0)),
                            Spacer(),
                            Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                          ]),
                    )),
              ),
            ],
          ),
        ));
  }
}
