import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:http/http.dart';
import 'package:mandob_moshtarayat/consts/country_code.dart';
import 'package:mandob_moshtarayat/consts/payment_secret_keys.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/helpers/payment_portal_web.dart';
import 'package:mandob_moshtarayat/utils/helpers/tab_loader.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PaymentsPortal extends StatefulWidget {
  final OrderDetailsModel model;
  final Function(bool, String, String, String) callback;
  const PaymentsPortal({Key? key, required this.model, required this.callback})
      : super(key: key);
  @override
  _PaymentsPortalState createState() => _PaymentsPortalState();
}

class _PaymentsPortalState extends State<PaymentsPortal> {
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = '';
  String sdkStatus = '';
  late String transactionID;
  String? sdkErrorCode;
  String? sdkErrorMessage;
  String? sdkErrorDescription;
  AwesomeLoaderController loaderController = AwesomeLoaderController();

  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = Color(0xff2ace00);
    transactionID =
        'trans_${widget.model.order.orderType}${widget.model.order.deliveryDate}${widget.model.order.orderCost}${widget.model.order.id}';
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    // setupSDKSession();
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
        bundleId: Platform.isAndroid
            ? 'de.yessoft.mandob_moshtarayat_client'
            : 'de.yessoft.mandobMoshtarayat',
        productionSecreteKey: Platform.isAndroid
            ? SecretPaymentsKeys.production
            : SecretPaymentsKeys.productionIOS,
        sandBoxsecretKey: Platform.isAndroid
            ? SecretPaymentsKeys.sandBox
            : SecretPaymentsKeys.sandBoxIOS,
        lang: getIt<LocalizationService>().getLanguage());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession() async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          paymentItems: payments,
          paymentMetaData: {},
          taxes: [],
          shippings: [
            Shipping(
                name: S.current.tax,
                description: S.current.withTaxes + ' %15 ',
                amount: (widget.model.order.orderCost * 15) / 100)
          ],
          customer: Customer(
              customerId:
                  '', // customer id is important to retrieve cards saved for this customer
              email: emailController.text,
              isdNumber: CountryCode.COUNTRY_CODE_KSA,
              number: phoneNumberController.text,
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              metaData: null),
          transactionCurrency: 'sar',
          amount: widget.model.order.orderCost.toStringAsFixed(2),
          // Post URL
          postURL: 'https://tap.company',
          // Payment description
          paymentDescription: 'Mandoob Client Payments',
          // Payment Reference
          paymentReference: Reference(
              transaction: transactionID,
              order: widget.model.order.id.toString(),
              gosellID: '36tap13'),
          // payment Descriptor
          paymentStatementDescriptor: 'Mandoob Client payments',
          // Save Card Switch
          isUserAllowedToSaveCard: false,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, true),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(
              type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: '13120685',
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: 'merchant.de.yessoft.mandobclientPayment',
          allowsToSaveSameCardMoreThanOnce: false,
          // pass the card holder name to the SDK
          cardHolderName:
              '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: false,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Production);
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
          widget.callback(
              true, responseID, transactionID, sdkErrorMessage ?? '');
          break;
        case 'FAILED':
          sdkStatus = 'FAILED';
          handleSDKResult();
          widget.callback(
              false, responseID, transactionID, S.current.paymentFailed);
          getIt<Logger>().error(
              'Payment Portal',
              {
                'code': '$sdkErrorCode',
                'message': '$sdkErrorMessage',
                'description': '$sdkErrorDescription'
              }.toString(),
              StackTrace.current);
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
          widget.callback(
              false, responseID, transactionID, S.current.paymentFailed);
          getIt<Logger>().error(
              'Payment Portal',
              {
                'code': '$sdkErrorCode',
                'message': '$sdkErrorMessage',
                'description': '$sdkErrorDescription'
              }.toString(),
              StackTrace.current);
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
    responseID = tapSDKResult['charge_id'] ?? '';
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<PaymentItem> payments = [];
  final GlobalKey<FormState> _details = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: CustomTwaslnaAppBar.appBar(context, title: 'Taps Payments',
              onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
          body: SafeArea(
            child: Form(
              key: _details,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFormField(
                                  controller: firstNameController,
                                  hintText: S.current.firstName),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFormField(
                                controller: middleNameController,
                                hintText: S.of(context).middleName,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFormField(
                                controller: lastNameController,
                                hintText: S.of(context).lastName,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.email),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFormField(
                                validator: false,
                                controller: emailController,
                                hintText: S.of(context).email,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.phone),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomLoginFormField(
                                  validator: false,
                                  last: true,
                                  phone: true,
                                  controller: phoneNumberController,
                                  hintText: S.of(context).phoneNumber,
                                  borderRadius: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: _buttonColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(30))),
                              ),
                              onPressed: () async {
                                widget.model.carts.forEach((e) {
                                  e.items.forEach((element) {
                                    payments.add(PaymentItem(
                                        amountPerUnit: element.productPrice,
                                        name: element.productName,
                                        quantity: Quantity(
                                            value: element.countProduct),
                                        totalAmount: (element.productPrice *
                                                element.countProduct)
                                            .toInt()));
                                  });
                                });
                                if (_details.currentState?.validate() == true &&
                                    (emailController.text.isNotEmpty ||
                                        phoneNumberController
                                            .text.isNotEmpty)) {
                                  if (kIsWeb) {
                                    var sdk = PaymentPortalWeb(
                                        amount: widget.model.order.orderCost
                                            .toStringAsFixed(2),
                                        email: emailController.text,
                                        firstName: firstNameController.text,
                                        items: payments,
                                        lastName: lastNameController.text,
                                        middleName: middleNameController.text,
                                        orderID:
                                            widget.model.order.id.toString(),
                                        phoneNumber: phoneNumberController.text,
                                        transID: transactionID,
                                        context: context);
                                    sdk.startSdk();
                                  } else {
                                    await setupSDKSession();
                                    await startSDK();
                                  }
                                } else {
                                  CustomFlushBarHelper.createError(
                                          title: S.current.warnning,
                                          message:
                                              S.current.pleaseCompleteTheForm)
                                      .show(context);
                                }
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: AwesomeLoader(
                                        outerColor: Colors.white,
                                        innerColor: Colors.white,
                                        strokeWidth: 3.0,
                                        controller: loaderController,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(S.current.pay,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                    const Spacer(),
                                    const Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                  ]),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
