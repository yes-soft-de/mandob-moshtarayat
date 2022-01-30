// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please Enter Your Email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `I have an account`
  String get iHaveAnAccount {
    return Intl.message(
      'I have an account',
      name: 'iHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Error Happened`
  String get errorHappened {
    return Intl.message(
      'Error Happened',
      name: 'errorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Data`
  String get errorLoadingData {
    return Intl.message(
      'Error Loading Data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `Email Address is Required`
  String get emailAddressIsRequired {
    return Intl.message(
      'Email Address is Required',
      name: 'emailAddressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get captain {
    return Intl.message(
      'Captain',
      name: 'captain',
      desc: '',
      args: [],
    );
  }

  /// `Store Owner`
  String get storeOwner {
    return Intl.message(
      'Store Owner',
      name: 'storeOwner',
      desc: '',
      args: [],
    );
  }

  /// `Chat Room`
  String get chatRoom {
    return Intl.message(
      'Chat Room',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Start Writing`
  String get startWriting {
    return Intl.message(
      'Start Writing',
      name: 'startWriting',
      desc: '',
      args: [],
    );
  }

  /// `Accept Order`
  String get acceptOrder {
    return Intl.message(
      'Accept Order',
      name: 'acceptOrder',
      desc: '',
      args: [],
    );
  }

  /// `I Arrived at the Store`
  String get iArrivedAtTheStore {
    return Intl.message(
      'I Arrived at the Store',
      name: 'iArrivedAtTheStore',
      desc: '',
      args: [],
    );
  }

  /// `I Got the Package`
  String get iGotThePackage {
    return Intl.message(
      'I Got the Package',
      name: 'iGotThePackage',
      desc: '',
      args: [],
    );
  }

  /// `I Got the Cash`
  String get iGotTheCash {
    return Intl.message(
      'I Got the Cash',
      name: 'iGotTheCash',
      desc: '',
      args: [],
    );
  }

  /// `I Finished Delivering`
  String get iFinishedDelivering {
    return Intl.message(
      'I Finished Delivering',
      name: 'iFinishedDelivering',
      desc: '',
      args: [],
    );
  }

  /// `Order is in undefined State`
  String get orderIsInUndefinedState {
    return Intl.message(
      'Order is in undefined State',
      name: 'orderIsInUndefinedState',
      desc: '',
      args: [],
    );
  }

  /// `Searching for Captain`
  String get searchingForCaptain {
    return Intl.message(
      'Searching for Captain',
      name: 'searchingForCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Captain is in the way`
  String get captainIsInTheWay {
    return Intl.message(
      'Captain is in the way',
      name: 'captainIsInTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Captain is in store`
  String get captainIsInStore {
    return Intl.message(
      'Captain is in store',
      name: 'captainIsInStore',
      desc: '',
      args: [],
    );
  }

  /// `Captain is Delivering`
  String get captainIsDelivering {
    return Intl.message(
      'Captain is Delivering',
      name: 'captainIsDelivering',
      desc: '',
      args: [],
    );
  }

  /// `Captain got the cash`
  String get captainGotTheCash {
    return Intl.message(
      'Captain got the cash',
      name: 'captainGotTheCash',
      desc: '',
      args: [],
    );
  }

  /// `Order is done!`
  String get orderIsDone {
    return Intl.message(
      'Order is done!',
      name: 'orderIsDone',
      desc: '',
      args: [],
    );
  }

  /// `Please input phone number`
  String get pleaseInputPhoneNumber {
    return Intl.message(
      'Please input phone number',
      name: 'pleaseInputPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Code`
  String get confirmCode {
    return Intl.message(
      'Confirm Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudiArabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon`
  String get lebanon {
    return Intl.message(
      'Lebanon',
      name: 'lebanon',
      desc: '',
      args: [],
    );
  }

  /// `Syria`
  String get syria {
    return Intl.message(
      'Syria',
      name: 'syria',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Send me code`
  String get sendMeCode {
    return Intl.message(
      'Send me code',
      name: 'sendMeCode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Created, Return to Orders`
  String get orderCreatedReturnToOrders {
    return Intl.message(
      'Order Created, Return to Orders',
      name: 'orderCreatedReturnToOrders',
      desc: '',
      args: [],
    );
  }

  /// `New Order`
  String get newOrder {
    return Intl.message(
      'New Order',
      name: 'newOrder',
      desc: '',
      args: [],
    );
  }

  /// `Renew Subscription`
  String get renewSubscription {
    return Intl.message(
      'Renew Subscription',
      name: 'renewSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Register Success, Setup my profile`
  String get registerSuccessSetupMyProfile {
    return Intl.message(
      'Register Success, Setup my profile',
      name: 'registerSuccessSetupMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Size`
  String get chooseYourSize {
    return Intl.message(
      'Choose Your Size',
      name: 'chooseYourSize',
      desc: '',
      args: [],
    );
  }

  /// `1 - 20 Employee`
  String get smallLessThan20Employee {
    return Intl.message(
      '1 - 20 Employee',
      name: 'smallLessThan20Employee',
      desc: '',
      args: [],
    );
  }

  /// `21 - 100 Employees`
  String get mediumMoreThan20EmployeesLessThan100 {
    return Intl.message(
      '21 - 100 Employees',
      name: 'mediumMoreThan20EmployeesLessThan100',
      desc: '',
      args: [],
    );
  }

  /// `+100 Employees`
  String get largeMoreThan100Employees {
    return Intl.message(
      '+100 Employees',
      name: 'largeMoreThan100Employees',
      desc: '',
      args: [],
    );
  }

  /// `Open Chat Room`
  String get openChatRoom {
    return Intl.message(
      'Open Chat Room',
      name: 'openChatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Current Orders`
  String get currentOrders {
    return Intl.message(
      'Current Orders',
      name: 'currentOrders',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Orders`
  String get nearbyOrders {
    return Intl.message(
      'Nearby Orders',
      name: 'nearbyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Chat with Store Owner`
  String get chatWithStoreOwner {
    return Intl.message(
      'Chat with Store Owner',
      name: 'chatWithStoreOwner',
      desc: '',
      args: [],
    );
  }

  /// `Store Owner`
  String get whatsappWithStoreOwner {
    return Intl.message(
      'Store Owner',
      name: 'whatsappWithStoreOwner',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get whatsappWithClient {
    return Intl.message(
      'Client',
      name: 'whatsappWithClient',
      desc: '',
      args: [],
    );
  }

  /// `Get Direction`
  String get getDirection {
    return Intl.message(
      'Get Direction',
      name: 'getDirection',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `I am`
  String get iAm {
    return Intl.message(
      'I am',
      name: 'iAm',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Preferred language`
  String get iSpeak {
    return Intl.message(
      'Preferred language',
      name: 'iSpeak',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `And I am`
  String get andIAm {
    return Intl.message(
      'And I am',
      name: 'andIAm',
      desc: '',
      args: [],
    );
  }

  /// `ME`
  String get me {
    return Intl.message(
      'ME',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `We need your image and your driver licence in order to sign up`
  String get weNeedYourImageAndYourDriverLicenceInOrder {
    return Intl.message(
      'We need your image and your driver licence in order to sign up',
      name: 'weNeedYourImageAndYourDriverLicenceInOrder',
      desc: '',
      args: [],
    );
  }

  /// `We need  your image in order to sign up`
  String get weNeedYourImageInOrderToSignUp {
    return Intl.message(
      'We need  your image in order to sign up',
      name: 'weNeedYourImageInOrderToSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Upload and submit`
  String get uploadAndSubmit {
    return Intl.message(
      'Upload and submit',
      name: 'uploadAndSubmit',
      desc: '',
      args: [],
    );
  }

  /// `This Might Take a while, please wait`
  String get thisMightTakeAWhilePleaseWait {
    return Intl.message(
      'This Might Take a while, please wait',
      name: 'thisMightTakeAWhilePleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Uploading Image, Please Wait`
  String get uploadingImagesPleaseWait {
    return Intl.message(
      'Uploading Image, Please Wait',
      name: 'uploadingImagesPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Driver Licence`
  String get driverLicence {
    return Intl.message(
      'Driver Licence',
      name: 'driverLicence',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Uploading and Submitting`
  String get uploadingAndSubmitting {
    return Intl.message(
      'Uploading and Submitting',
      name: 'uploadingAndSubmitting',
      desc: '',
      args: [],
    );
  }

  /// `Uploading Images`
  String get uploadingImages {
    return Intl.message(
      'Uploading Images',
      name: 'uploadingImages',
      desc: '',
      args: [],
    );
  }

  /// `Submitting Profile`
  String get submittingProfile {
    return Intl.message(
      'Submitting Profile',
      name: 'submittingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Error Uploading Images!!`
  String get errorUploadingImages {
    return Intl.message(
      'Error Uploading Images!!',
      name: 'errorUploadingImages',
      desc: '',
      args: [],
    );
  }

  /// `Account Created`
  String get accountCreated {
    return Intl.message(
      'Account Created',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Move to Orders`
  String get moveToOrders {
    return Intl.message(
      'Move to Orders',
      name: 'moveToOrders',
      desc: '',
      args: [],
    );
  }

  /// `Contact Phone Number`
  String get contactPhoneNumber {
    return Intl.message(
      'Contact Phone Number',
      name: 'contactPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pay Subscription`
  String get paySubscription {
    return Intl.message(
      'Pay Subscription',
      name: 'paySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Earn Cash`
  String get earnCash {
    return Intl.message(
      'Earn Cash',
      name: 'earnCash',
      desc: '',
      args: [],
    );
  }

  /// `Deliver`
  String get deliver {
    return Intl.message(
      'Deliver',
      name: 'deliver',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Check Orders`
  String get checkOrders {
    return Intl.message(
      'Check Orders',
      name: 'checkOrders',
      desc: '',
      args: [],
    );
  }

  /// `Open the app`
  String get openTheApp {
    return Intl.message(
      'Open the app',
      name: 'openTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Book a car`
  String get bookACar {
    return Intl.message(
      'Book a car',
      name: 'bookACar',
      desc: '',
      args: [],
    );
  }

  /// `We Deliver`
  String get weDeliver {
    return Intl.message(
      'We Deliver',
      name: 'weDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Help me more`
  String get helpMeMore {
    return Intl.message(
      'Help me more',
      name: 'helpMeMore',
      desc: '',
      args: [],
    );
  }

  /// `Request Meeting`
  String get requestMeeting {
    return Intl.message(
      'Request Meeting',
      name: 'requestMeeting',
      desc: '',
      args: [],
    );
  }

  /// `To find out more, please leave your phone.\nand we will contact you personally`
  String get toFindOutMorePleaseLeaveYourPhonenandWeWill {
    return Intl.message(
      'To find out more, please leave your phone.\nand we will contact you personally',
      name: 'toFindOutMorePleaseLeaveYourPhonenandWeWill',
      desc: '',
      args: [],
    );
  }

  /// `We will contact you soon`
  String get weWillContactYouSoon {
    return Intl.message(
      'We will contact you soon',
      name: 'weWillContactYouSoon',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to mandob_moshtarayat_dashboad`
  String get welcomeTomandob_moshtarayat_dashboad {
    return Intl.message(
      'Welcome to mandob_moshtarayat_dashboad',
      name: 'welcomeTomandob_moshtarayat_dashboad',
      desc: '',
      args: [],
    );
  }

  /// `Init Data`
  String get initData {
    return Intl.message(
      'Init Data',
      name: 'initData',
      desc: '',
      args: [],
    );
  }

  /// `Save Location as Branch 01`
  String get saveLocationAsBranch01 {
    return Intl.message(
      'Save Location as Branch 01',
      name: 'saveLocationAsBranch01',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Orders Screen`
  String get welcomeToOrdersScreen {
    return Intl.message(
      'Welcome to Orders Screen',
      name: 'welcomeToOrdersScreen',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get passwordIsTooShort {
    return Intl.message(
      'Password is too short',
      name: 'passwordIsTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameIsRequired {
    return Intl.message(
      'Name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your City`
  String get chooseYourCity {
    return Intl.message(
      'Choose Your City',
      name: 'chooseYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `From WhatsApp`
  String get fromWhatsapp {
    return Intl.message(
      'From WhatsApp',
      name: 'fromWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Default Branch`
  String get defaultBranch {
    return Intl.message(
      'Default Branch',
      name: 'defaultBranch',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Mohammad`
  String get mohammad {
    return Intl.message(
      'Mohammad',
      name: 'mohammad',
      desc: '',
      args: [],
    );
  }

  /// `Deliver To`
  String get deliverTo {
    return Intl.message(
      'Deliver To',
      name: 'deliverTo',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get whatsappWithCaptain {
    return Intl.message(
      'Captain',
      name: 'whatsappWithCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `order`
  String get sOrder {
    return Intl.message(
      'order',
      name: 'sOrder',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Branch 01`
  String get branch01 {
    return Intl.message(
      'Branch 01',
      name: 'branch01',
      desc: '',
      args: [],
    );
  }

  /// `Create new order`
  String get createNewOrder {
    return Intl.message(
      'Create new order',
      name: 'createNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get branch {
    return Intl.message(
      'Branch',
      name: 'branch',
      desc: '',
      args: [],
    );
  }

  /// `Save Branches`
  String get saveBranches {
    return Intl.message(
      'Save Branches',
      name: 'saveBranches',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Branches`
  String get errorLoadingBranches {
    return Intl.message(
      'Error Loading Branches',
      name: 'errorLoadingBranches',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Our Bank Name`
  String get ourBankName {
    return Intl.message(
      'Our Bank Name',
      name: 'ourBankName',
      desc: '',
      args: [],
    );
  }

  /// `Our Bank Account Number`
  String get ourBankAccountNumber {
    return Intl.message(
      'Our Bank Account Number',
      name: 'ourBankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Order/Month`
  String get ordermonth {
    return Intl.message(
      'Order/Month',
      name: 'ordermonth',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get car {
    return Intl.message(
      'Car',
      name: 'car',
      desc: '',
      args: [],
    );
  }

  /// `APPLY`
  String get apply {
    return Intl.message(
      'APPLY',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Recipient Phone Number`
  String get recipientPhoneNumber {
    return Intl.message(
      'Recipient Phone Number',
      name: 'recipientPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Language`
  String get pickALanguage {
    return Intl.message(
      'Pick a Language',
      name: 'pickALanguage',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Job`
  String get pickAJob {
    return Intl.message(
      'Pick a Job',
      name: 'pickAJob',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Branch`
  String get pleaseSelectABranch {
    return Intl.message(
      'Please Select a Branch',
      name: 'pleaseSelectABranch',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Captain Accepted Order`
  String get captainAcceptedOrder {
    return Intl.message(
      'Captain Accepted Order',
      name: 'captainAcceptedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Captain in Store`
  String get captainInStore {
    return Intl.message(
      'Captain in Store',
      name: 'captainInStore',
      desc: '',
      args: [],
    );
  }

  /// `Captain Started Delivery`
  String get captainStartedDelivery {
    return Intl.message(
      'Captain Started Delivery',
      name: 'captainStartedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Captain Got Cash`
  String get captainGotCash {
    return Intl.message(
      'Captain Got Cash',
      name: 'captainGotCash',
      desc: '',
      args: [],
    );
  }

  /// `Order is finished`
  String get orderIsFinished {
    return Intl.message(
      'Order is finished',
      name: 'orderIsFinished',
      desc: '',
      args: [],
    );
  }

  /// `Order is created`
  String get orderIsCreated {
    return Intl.message(
      'Order is created',
      name: 'orderIsCreated',
      desc: '',
      args: [],
    );
  }

  /// `Activity Log`
  String get activityLog {
    return Intl.message(
      'Activity Log',
      name: 'activityLog',
      desc: '',
      args: [],
    );
  }

  /// `Save Success`
  String get saveSuccess {
    return Intl.message(
      'Save Success',
      name: 'saveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Reason of the report`
  String get reasonOfTheReport {
    return Intl.message(
      'Reason of the report',
      name: 'reasonOfTheReport',
      desc: '',
      args: [],
    );
  }

  /// `Create new Report`
  String get createNewReport {
    return Intl.message(
      'Create new Report',
      name: 'createNewReport',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Please Complete the Form`
  String get pleaseCompleteTheForm {
    return Intl.message(
      'Please Complete the Form',
      name: 'pleaseCompleteTheForm',
      desc: '',
      args: [],
    );
  }

  /// `Report sent`
  String get reportSent {
    return Intl.message(
      'Report sent',
      name: 'reportSent',
      desc: '',
      args: [],
    );
  }

  /// `Reason is Required`
  String get reasonIsRequired {
    return Intl.message(
      'Reason is Required',
      name: 'reasonIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide us with the Client Name`
  String get pleaseProvideUsWithTheClientName {
    return Intl.message(
      'Please Provide us with the Client Name',
      name: 'pleaseProvideUsWithTheClientName',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide us the client phone number`
  String get pleaseProvideUsTheClientPhoneNumber {
    return Intl.message(
      'Please Provide us the client phone number',
      name: 'pleaseProvideUsTheClientPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get storeName {
    return Intl.message(
      'Store Name',
      name: 'storeName',
      desc: '',
      args: [],
    );
  }

  /// `Store Phone`
  String get storePhone {
    return Intl.message(
      'Store Phone',
      name: 'storePhone',
      desc: '',
      args: [],
    );
  }

  /// `Phone is required`
  String get phoneIsRequired {
    return Intl.message(
      'Phone is required',
      name: 'phoneIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `New name`
  String get newName {
    return Intl.message(
      'New name',
      name: 'newName',
      desc: '',
      args: [],
    );
  }

  /// `Our Packages`
  String get ourPackages {
    return Intl.message(
      'Our Packages',
      name: 'ourPackages',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide the distance`
  String get pleaseProvideTheDistance {
    return Intl.message(
      'Please Provide the distance',
      name: 'pleaseProvideTheDistance',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order, Provide distance in KM`
  String get finishOrderProvideDistanceInKm {
    return Intl.message(
      'Finish Order, Provide distance in KM',
      name: 'finishOrderProvideDistanceInKm',
      desc: '',
      args: [],
    );
  }

  /// `My Status`
  String get myStatus {
    return Intl.message(
      'My Status',
      name: 'myStatus',
      desc: '',
      args: [],
    );
  }

  /// `Direct Support`
  String get directSupport {
    return Intl.message(
      'Direct Support',
      name: 'directSupport',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Please Download mandob_moshtarayat_dashboad`
  String get pleaseDownloadmandob_moshtarayat_dashboad {
    return Intl.message(
      'Please Download mandob_moshtarayat_dashboad',
      name: 'pleaseDownloadmandob_moshtarayat_dashboad',
      desc: '',
      args: [],
    );
  }

  /// `My Plan`
  String get myPlan {
    return Intl.message(
      'My Plan',
      name: 'myPlan',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get bankAccountNumber {
    return Intl.message(
      'Bank Account Number',
      name: 'bankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `STC Pay Code`
  String get stcPayCode {
    return Intl.message(
      'STC Pay Code',
      name: 'stcPayCode',
      desc: '',
      args: [],
    );
  }

  /// `Current Balance:`
  String get currentBalance {
    return Intl.message(
      'Current Balance:',
      name: 'currentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Next Payment Date:`
  String get nextPaymentDate {
    return Intl.message(
      'Next Payment Date:',
      name: 'nextPaymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Riyal`
  String get saudiRiyal {
    return Intl.message(
      'Saudi Riyal',
      name: 'saudiRiyal',
      desc: '',
      args: [],
    );
  }

  /// `Active Plan`
  String get activePlan {
    return Intl.message(
      'Active Plan',
      name: 'activePlan',
      desc: '',
      args: [],
    );
  }

  /// `Active Cars`
  String get activeCars {
    return Intl.message(
      'Active Cars',
      name: 'activeCars',
      desc: '',
      args: [],
    );
  }

  /// `Orders / Month`
  String get ordersMonth {
    return Intl.message(
      'Orders / Month',
      name: 'ordersMonth',
      desc: '',
      args: [],
    );
  }

  /// `Payment History`
  String get paymentHistory {
    return Intl.message(
      'Payment History',
      name: 'paymentHistory',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get completedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'completedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Latest Updates`
  String get latestUpdates {
    return Intl.message(
      'Latest Updates',
      name: 'latestUpdates',
      desc: '',
      args: [],
    );
  }

  /// `My Balance`
  String get myBalance {
    return Intl.message(
      'My Balance',
      name: 'myBalance',
      desc: '',
      args: [],
    );
  }

  /// `No Image`
  String get noImage {
    return Intl.message(
      'No Image',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `How we work`
  String get howWeWork {
    return Intl.message(
      'How we work',
      name: 'howWeWork',
      desc: '',
      args: [],
    );
  }

  /// `Took`
  String get took {
    return Intl.message(
      'Took',
      name: 'took',
      desc: '',
      args: [],
    );
  }

  /// `I Agree to the Terms os service.`
  String get iAgreeToTheTermsOsService {
    return Intl.message(
      'I Agree to the Terms os service.',
      name: 'iAgreeToTheTermsOsService',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms of service & privacy policy`
  String get iAgreeToTheTermsOfServicePrivacyPolicy {
    return Intl.message(
      'I agree to the terms of service & privacy policy',
      name: 'iAgreeToTheTermsOfServicePrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `The number of cars unknown`
  String get unknownNumberOfCar {
    return Intl.message(
      'The number of cars unknown',
      name: 'unknownNumberOfCar',
      desc: '',
      args: [],
    );
  }

  /// `Recipient Name`
  String get recipientName {
    return Intl.message(
      'Recipient Name',
      name: 'recipientName',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get go {
    return Intl.message(
      'Go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Error logging in, firebase account not found`
  String get errorLoggingInFirebaseAccountNotFound {
    return Intl.message(
      'Error logging in, firebase account not found',
      name: 'errorLoggingInFirebaseAccountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Location of customer`
  String get locationOfCustomer {
    return Intl.message(
      'Location of customer',
      name: 'locationOfCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting this order , please confirm`
  String get sureForDelete {
    return Intl.message(
      'Are you sure about deleting this order , please confirm',
      name: 'sureForDelete',
      desc: '',
      args: [],
    );
  }

  /// `the order has been deleted successfully`
  String get deleteSuccess {
    return Intl.message(
      'the order has been deleted successfully',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `distance in KM`
  String get ProvideDistanceInKm {
    return Intl.message(
      'distance in KM',
      name: 'ProvideDistanceInKm',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription not verified yet`
  String get notVerified {
    return Intl.message(
      'Your subscription not verified yet',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Subscription options`
  String get renewPlan {
    return Intl.message(
      'Subscription options',
      name: 'renewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Renew old package`
  String get renewOldPlan {
    return Intl.message(
      'Renew old package',
      name: 'renewOldPlan',
      desc: '',
      args: [],
    );
  }

  /// `Subscription with new package`
  String get renewNewPlan {
    return Intl.message(
      'Subscription with new package',
      name: 'renewNewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription has been renewed`
  String get successRenew {
    return Intl.message(
      'Your subscription has been renewed',
      name: 'successRenew',
      desc: '',
      args: [],
    );
  }

  /// `Important Note`
  String get warnning {
    return Intl.message(
      'Important Note',
      name: 'warnning',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription not activate yet please wait`
  String get inactive {
    return Intl.message(
      'Your subscription not activate yet please wait',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `You reach your limit of orders you can renew your subscription from settings`
  String get outOforders {
    return Intl.message(
      'You reach your limit of orders you can renew your subscription from settings',
      name: 'outOforders',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription is out of date please renew your subscription`
  String get finishedDate {
    return Intl.message(
      'Your subscription is out of date please renew your subscription',
      name: 'finishedDate',
      desc: '',
      args: [],
    );
  }

  /// `Your request not accepted from administration you can contact us to get info`
  String get unaccept {
    return Intl.message(
      'Your request not accepted from administration you can contact us to get info',
      name: 'unaccept',
      desc: '',
      args: [],
    );
  }

  /// `There is no car available please wait your ongoing orders to finish`
  String get outOfCars {
    return Intl.message(
      'There is no car available please wait your ongoing orders to finish',
      name: 'outOfCars',
      desc: '',
      args: [],
    );
  }

  /// `You dont have a subscription yet`
  String get notSubscription {
    return Intl.message(
      'You dont have a subscription yet',
      name: 'notSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Your account not activated yet please wait`
  String get captainNotActive {
    return Intl.message(
      'Your account not activated yet please wait',
      name: 'captainNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Your renew has been failed please try again`
  String get failureRenew {
    return Intl.message(
      'Your renew has been failed please try again',
      name: 'failureRenew',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Update Branches`
  String get updateBranches {
    return Intl.message(
      'Update Branches',
      name: 'updateBranches',
      desc: '',
      args: [],
    );
  }

  /// `Update Branch`
  String get updateBranch {
    return Intl.message(
      'Update Branch',
      name: 'updateBranch',
      desc: '',
      args: [],
    );
  }

  /// `Save Branch`
  String get saveBranch {
    return Intl.message(
      'Save Branch',
      name: 'saveBranch',
      desc: '',
      args: [],
    );
  }

  /// `Edit Branch Name`
  String get editBranchName {
    return Intl.message(
      'Edit Branch Name',
      name: 'editBranchName',
      desc: '',
      args: [],
    );
  }

  /// `Branch has been updated successfully`
  String get updateBranchSuccess {
    return Intl.message(
      'Branch has been updated successfully',
      name: 'updateBranchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sorry your request for update branch faild please try again`
  String get updateBranchFailure {
    return Intl.message(
      'Sorry your request for update branch faild please try again',
      name: 'updateBranchFailure',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is too short`
  String get phoneNumbertooShort {
    return Intl.message(
      'Phone number is too short',
      name: 'phoneNumbertooShort',
      desc: '',
      args: [],
    );
  }

  /// `Add Branch`
  String get addBranch {
    return Intl.message(
      'Add Branch',
      name: 'addBranch',
      desc: '',
      args: [],
    );
  }

  /// `Branch has been added successfully`
  String get addBranchSuccess {
    return Intl.message(
      'Branch has been added successfully',
      name: 'addBranchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sorry your request for add branch faild please try again`
  String get addBranchFailure {
    return Intl.message(
      'Sorry your request for add branch faild please try again',
      name: 'addBranchFailure',
      desc: '',
      args: [],
    );
  }

  /// `Our Service`
  String get ourService {
    return Intl.message(
      'Our Service',
      name: 'ourService',
      desc: '',
      args: [],
    );
  }

  /// `Most Sold Product`
  String get mostSoldProduct {
    return Intl.message(
      'Most Sold Product',
      name: 'mostSoldProduct',
      desc: '',
      args: [],
    );
  }

  /// `Best Store`
  String get bestStore {
    return Intl.message(
      'Best Store',
      name: 'bestStore',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Store`
  String get nearbyStore {
    return Intl.message(
      'Nearby Store',
      name: 'nearbyStore',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Deliver on me`
  String get deliverForMe {
    return Intl.message(
      'Deliver on me',
      name: 'deliverForMe',
      desc: '',
      args: [],
    );
  }

  /// `External Order`
  String get externalOrder {
    return Intl.message(
      'External Order',
      name: 'externalOrder',
      desc: '',
      args: [],
    );
  }

  /// `Best Stores`
  String get BestStores {
    return Intl.message(
      'Best Stores',
      name: 'BestStores',
      desc: '',
      args: [],
    );
  }

  /// `Search for store , product`
  String get searchFor {
    return Intl.message(
      'Search for store , product',
      name: 'searchFor',
      desc: '',
      args: [],
    );
  }

  /// `views`
  String get views {
    return Intl.message(
      'views',
      name: 'views',
      desc: '',
      args: [],
    );
  }

  /// `highest rate`
  String get sortByRate {
    return Intl.message(
      'highest rate',
      name: 'sortByRate',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNumber {
    return Intl.message(
      'Order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `order date`
  String get orderDate {
    return Intl.message(
      'order date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `cost`
  String get cost {
    return Intl.message(
      'cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Highest Rate`
  String get highestRate {
    return Intl.message(
      'Highest Rate',
      name: 'highestRate',
      desc: '',
      args: [],
    );
  }

  /// `By Earlier`
  String get sortByEarlier {
    return Intl.message(
      'By Earlier',
      name: 'sortByEarlier',
      desc: '',
      args: [],
    );
  }

  /// `search for order by order number`
  String get searchForOrder {
    return Intl.message(
      'search for order by order number',
      name: 'searchForOrder',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Orders Log`
  String get orderLog {
    return Intl.message(
      'Orders Log',
      name: 'orderLog',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Social Media`
  String get socialMedia {
    return Intl.message(
      'Social Media',
      name: 'socialMedia',
      desc: '',
      args: [],
    );
  }

  /// `Search for a notification`
  String get searchForNotifications {
    return Intl.message(
      'Search for a notification',
      name: 'searchForNotifications',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get category {
    return Intl.message(
      'category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `product`
  String get product {
    return Intl.message(
      'product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `There is problem with your connection , please try again`
  String get networkError {
    return Intl.message(
      'There is problem with your connection , please try again',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Search for`
  String get searchF {
    return Intl.message(
      'Search for',
      name: 'searchF',
      desc: '',
      args: [],
    );
  }

  /// `Most wanted`
  String get mostWanted {
    return Intl.message(
      'Most wanted',
      name: 'mostWanted',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message(
      'Birth Date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `e.g yazan`
  String get nameHint {
    return Intl.message(
      'e.g yazan',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `choose your birth data`
  String get birthDateHint {
    return Intl.message(
      'choose your birth data',
      name: 'birthDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get updateYourData {
    return Intl.message(
      'Update Data',
      name: 'updateYourData',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `waiting`
  String get waiting {
    return Intl.message(
      'waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Order List`
  String get orderList {
    return Intl.message(
      'Order List',
      name: 'orderList',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `order price`
  String get orderPrice {
    return Intl.message(
      'order price',
      name: 'orderPrice',
      desc: '',
      args: [],
    );
  }

  /// `total`
  String get sum {
    return Intl.message(
      'total',
      name: 'sum',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `Deliver Price`
  String get deliverPrice {
    return Intl.message(
      'Deliver Price',
      name: 'deliverPrice',
      desc: '',
      args: [],
    );
  }

  /// `waiting for a captain to accept this order`
  String get waitingDescription {
    return Intl.message(
      'waiting for a captain to accept this order',
      name: 'waitingDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain packing your order`
  String get captainInStoreDescription {
    return Intl.message(
      'captain packing your order',
      name: 'captainInStoreDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain on his way to you`
  String get deliveringDescription {
    return Intl.message(
      'captain on his way to you',
      name: 'deliveringDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain headed to store`
  String get captainAcceptOrderDescription {
    return Intl.message(
      'captain headed to store',
      name: 'captainAcceptOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `your order has delivered`
  String get orderDeliveredDescription {
    return Intl.message(
      'your order has delivered',
      name: 'orderDeliveredDescription',
      desc: '',
      args: [],
    );
  }

  /// `You can know your order status in this interface`
  String get orderStatusDescription {
    return Intl.message(
      'You can know your order status in this interface',
      name: 'orderStatusDescription',
      desc: '',
      args: [],
    );
  }

  /// `Destination Address`
  String get destinationAddress {
    return Intl.message(
      'Destination Address',
      name: 'destinationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Receipt point`
  String get myAddress {
    return Intl.message(
      'Receipt point',
      name: 'myAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please place your order details here`
  String get orderDetailHint {
    return Intl.message(
      'Please place your order details here',
      name: 'orderDetailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please place your destination address`
  String get destinationAddressHint {
    return Intl.message(
      'Please place your destination address',
      name: 'destinationAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Please place your address`
  String get myAddressHint {
    return Intl.message(
      'Please place your address',
      name: 'myAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Please update your current location if you want to`
  String get chooseAddressNote {
    return Intl.message(
      'Please update your current location if you want to',
      name: 'chooseAddressNote',
      desc: '',
      args: [],
    );
  }

  /// `Order Time`
  String get orderTime {
    return Intl.message(
      'Order Time',
      name: 'orderTime',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get deliveryTime {
    return Intl.message(
      'Delivery Time',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get paymentMethodHint {
    return Intl.message(
      'Choose',
      name: 'paymentMethodHint',
      desc: '',
      args: [],
    );
  }

  /// `Data fetched succesfuly`
  String get statusCodeOk {
    return Intl.message(
      'Data fetched succesfuly',
      name: 'statusCodeOk',
      desc: '',
      args: [],
    );
  }

  /// `The request has succeeded and a new resource has been created as a result`
  String get statusCodeCreated {
    return Intl.message(
      'The request has succeeded and a new resource has been created as a result',
      name: 'statusCodeCreated',
      desc: '',
      args: [],
    );
  }

  /// `The server could not understand the request due to invalid syntax`
  String get statusCodeBadRequest {
    return Intl.message(
      'The server could not understand the request due to invalid syntax',
      name: 'statusCodeBadRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get statusCodeUnauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'statusCodeUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Data not found`
  String get StatusCodeNotFound {
    return Intl.message(
      'Data not found',
      name: 'StatusCodeNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Order created successfully`
  String get successCreateOrder {
    return Intl.message(
      'Order created successfully',
      name: 'successCreateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please choose payment method`
  String get pleaseProvidePaymentMethode {
    return Intl.message(
      'Please choose payment method',
      name: 'pleaseProvidePaymentMethode',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your address on our map`
  String get pleaseProvideYourAddress {
    return Intl.message(
      'Please provide your address on our map',
      name: 'pleaseProvideYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty please choose items to add`
  String get yourCartEmpty {
    return Intl.message(
      'Your cart is empty please choose items to add',
      name: 'yourCartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please place your order notes`
  String get noteOfOrder {
    return Intl.message(
      'Please place your order notes',
      name: 'noteOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `choose location`
  String get chooseLocation {
    return Intl.message(
      'choose location',
      name: 'chooseLocation',
      desc: '',
      args: [],
    );
  }

  /// `Choose Receipt Location`
  String get chooseReceiptPoint {
    return Intl.message(
      'Choose Receipt Location',
      name: 'chooseReceiptPoint',
      desc: '',
      args: [],
    );
  }

  /// `Choose Destination Location`
  String get chooseDestinationPoint {
    return Intl.message(
      'Choose Destination Location',
      name: 'chooseDestinationPoint',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order`
  String get finishedOrdering {
    return Intl.message(
      'Finish Order',
      name: 'finishedOrdering',
      desc: '',
      args: [],
    );
  }

  /// `Private Order`
  String get privateOrder {
    return Intl.message(
      'Private Order',
      name: 'privateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Store Products`
  String get storeProducts {
    return Intl.message(
      'Store Products',
      name: 'storeProducts',
      desc: '',
      args: [],
    );
  }

  /// `Order Type`
  String get orderType {
    return Intl.message(
      'Order Type',
      name: 'orderType',
      desc: '',
      args: [],
    );
  }

  /// `Order number not found!!`
  String get orderNumberNotFound {
    return Intl.message(
      'Order number not found!!',
      name: 'orderNumberNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Can not remove it, Exceeded time allowed`
  String get exceededAllowedTime {
    return Intl.message(
      'Can not remove it, Exceeded time allowed',
      name: 'exceededAllowedTime',
      desc: '',
      args: [],
    );
  }

  /// `Can not remove it, The captain received the order`
  String get notAllowedCaptainReceived {
    return Intl.message(
      'Can not remove it, The captain received the order',
      name: 'notAllowedCaptainReceived',
      desc: '',
      args: [],
    );
  }

  /// `Orders Details`
  String get updateOrders {
    return Intl.message(
      'Orders Details',
      name: 'updateOrders',
      desc: '',
      args: [],
    );
  }

  /// `You can update your order item from this interface`
  String get updateOrderNote {
    return Intl.message(
      'You can update your order item from this interface',
      name: 'updateOrderNote',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME TO MANDOOB APP`
  String get welcomeToOurApp {
    return Intl.message(
      'WELCOME TO MANDOOB APP',
      name: 'welcomeToOurApp',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been updated`
  String get updateOrderSuccess {
    return Intl.message(
      'Your order has been updated',
      name: 'updateOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `username or phone number`
  String get registerHint {
    return Intl.message(
      'username or phone number',
      name: 'registerHint',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been registered successfully`
  String get registerSuccess {
    return Intl.message(
      'Your account has been registered successfully',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been logged successfully`
  String get loginSuccess {
    return Intl.message(
      'Your account has been logged successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `There is no data to show you yet`
  String get homeDataEmpty {
    return Intl.message(
      'There is no data to show you yet',
      name: 'homeDataEmpty',
      desc: '',
      args: [],
    );
  }

  /// `refresh`
  String get refresh {
    return Intl.message(
      'refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `The next problems occurred`
  String get errOc {
    return Intl.message(
      'The next problems occurred',
      name: 'errOc',
      desc: '',
      args: [],
    );
  }

  /// `Please login to resuming order sending`
  String get pleaseLoginToMakeOrder {
    return Intl.message(
      'Please login to resuming order sending',
      name: 'pleaseLoginToMakeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please fill the field`
  String get pleaseCompleteField {
    return Intl.message(
      'Please fill the field',
      name: 'pleaseCompleteField',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `This Error happened`
  String get thisErrorHappened {
    return Intl.message(
      'This Error happened',
      name: 'thisErrorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get pleaseLoginToContinue {
    return Intl.message(
      'Please login to continue',
      name: 'pleaseLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `You can't edit, captain in the store.`
  String get notAllowedCaptainInStore {
    return Intl.message(
      'You can\'t edit, captain in the store.',
      name: 'notAllowedCaptainInStore',
      desc: '',
      args: [],
    );
  }

  /// `Wrong username or password`
  String get invalidCredentials {
    return Intl.message(
      'Wrong username or password',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Error with Decoding Data`
  String get dataDecodeError {
    return Intl.message(
      'Error with Decoding Data',
      name: 'dataDecodeError',
      desc: '',
      args: [],
    );
  }

  /// `Add Products`
  String get addProducts {
    return Intl.message(
      'Add Products',
      name: 'addProducts',
      desc: '',
      args: [],
    );
  }

  /// `There is no profile data available`
  String get profileDataEmpty {
    return Intl.message(
      'There is no profile data available',
      name: 'profileDataEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Profile Data Fetched Successfully`
  String get profileFetchedSuccessfully {
    return Intl.message(
      'Profile Data Fetched Successfully',
      name: 'profileFetchedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Upload profile was a success`
  String get uploadProfileSuccess {
    return Intl.message(
      'Upload profile was a success',
      name: 'uploadProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upload image was a success`
  String get uploadImageSuccess {
    return Intl.message(
      'Upload image was a success',
      name: 'uploadImageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `error download image`
  String get errorDownloadingImage {
    return Intl.message(
      'error download image',
      name: 'errorDownloadingImage',
      desc: '',
      args: [],
    );
  }

  /// `Launch our app`
  String get launch {
    return Intl.message(
      'Launch our app',
      name: 'launch',
      desc: '',
      args: [],
    );
  }

  /// `If you have somthing to deliver far from you dont wory just open our app`
  String get lanchDescribtion {
    return Intl.message(
      'If you have somthing to deliver far from you dont wory just open our app',
      name: 'lanchDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `You need to book a car to deliver your package to your destenation`
  String get bookACarDescribtion {
    return Intl.message(
      'You need to book a car to deliver your package to your destenation',
      name: 'bookACarDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `We will deliver your package for you in the fastest way and the best`
  String get weDeliverDescribtion {
    return Intl.message(
      'We will deliver your package for you in the fastest way and the best',
      name: 'weDeliverDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `If you have the ability to deliver packages for us you are welcome`
  String get lanchDescribtionCaptain {
    return Intl.message(
      'If you have the ability to deliver packages for us you are welcome',
      name: 'lanchDescribtionCaptain',
      desc: '',
      args: [],
    );
  }

  /// `You can check the app for packages near you to deliver`
  String get checkOrdersDescribtion {
    return Intl.message(
      'You can check the app for packages near you to deliver',
      name: 'checkOrdersDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `You can accept your mission to deliver package`
  String get acceptOrderDescribtion {
    return Intl.message(
      'You can accept your mission to deliver package',
      name: 'acceptOrderDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `After accepting your mission you will deliver package to the right destination`
  String get deliverDescribtion {
    return Intl.message(
      'After accepting your mission you will deliver package to the right destination',
      name: 'deliverDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `After you doing your job your effort will be rewarded by earning money`
  String get earnCashDescribtion {
    return Intl.message(
      'After you doing your job your effort will be rewarded by earning money',
      name: 'earnCashDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to update this order status , please confirm`
  String get confirmUpdateOrderStatus {
    return Intl.message(
      'Are you want to update this order status , please confirm',
      name: 'confirmUpdateOrderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `The order has been receved by another captain`
  String get orderReceved {
    return Intl.message(
      'The order has been receved by another captain',
      name: 'orderReceved',
      desc: '',
      args: [],
    );
  }

  /// `All City`
  String get allcity {
    return Intl.message(
      'All City',
      name: 'allcity',
      desc: '',
      args: [],
    );
  }

  /// `Empty Stuff`
  String get emptyStaff {
    return Intl.message(
      'Empty Stuff',
      name: 'emptyStaff',
      desc: '',
      args: [],
    );
  }

  /// `You have reached `
  String get youReached {
    return Intl.message(
      'You have reached ',
      name: 'youReached',
      desc: '',
      args: [],
    );
  }

  /// `percent of your orders limit`
  String get orderAverage {
    return Intl.message(
      'percent of your orders limit',
      name: 'orderAverage',
      desc: '',
      args: [],
    );
  }

  /// `Are your sure about renewing your subscription`
  String get confirmRenewSub {
    return Intl.message(
      'Are your sure about renewing your subscription',
      name: 'confirmRenewSub',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Mechanich Licence`
  String get mechanichLicence {
    return Intl.message(
      'Mechanich Licence',
      name: 'mechanichLicence',
      desc: '',
      args: [],
    );
  }

  /// `Identity`
  String get identity {
    return Intl.message(
      'Identity',
      name: 'identity',
      desc: '',
      args: [],
    );
  }

  /// `Bonus`
  String get bonus {
    return Intl.message(
      'Bonus',
      name: 'bonus',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Bonus`
  String get kiloBonus {
    return Intl.message(
      'Fuel Bonus',
      name: 'kiloBonus',
      desc: '',
      args: [],
    );
  }

  /// `Sum Balance`
  String get sumBalance {
    return Intl.message(
      'Sum Balance',
      name: 'sumBalance',
      desc: '',
      args: [],
    );
  }

  /// `Total Salary`
  String get totalBonus {
    return Intl.message(
      'Total Salary',
      name: 'totalBonus',
      desc: '',
      args: [],
    );
  }

  /// `General Profite`
  String get netProfite {
    return Intl.message(
      'General Profite',
      name: 'netProfite',
      desc: '',
      args: [],
    );
  }

  /// `Balance Details`
  String get balanceDetails {
    return Intl.message(
      'Balance Details',
      name: 'balanceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sending record has been failed`
  String get sendToRecordFaild {
    return Intl.message(
      'Sending record has been failed',
      name: 'sendToRecordFaild',
      desc: '',
      args: [],
    );
  }

  /// `The report send with a success`
  String get sendToRecordSuccess {
    return Intl.message(
      'The report send with a success',
      name: 'sendToRecordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Confirm with yes and no if captain reach you`
  String get confirmingCaptainLocation {
    return Intl.message(
      'Confirm with yes and no if captain reach you',
      name: 'confirmingCaptainLocation',
      desc: '',
      args: [],
    );
  }

  /// `Redo`
  String get redo {
    return Intl.message(
      'Redo',
      name: 'redo',
      desc: '',
      args: [],
    );
  }

  /// `Sending report within 15 seconds`
  String get sendingReport {
    return Intl.message(
      'Sending report within 15 seconds',
      name: 'sendingReport',
      desc: '',
      args: [],
    );
  }

  /// `Company contact info`
  String get social {
    return Intl.message(
      'Company contact info',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 35%`
  String get orderAverage35 {
    return Intl.message(
      'You have consumed 35%',
      name: 'orderAverage35',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 40%`
  String get orderAverage40 {
    return Intl.message(
      'You have consumed 40%',
      name: 'orderAverage40',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 75%`
  String get orderAverage75 {
    return Intl.message(
      'You have consumed 75%',
      name: 'orderAverage75',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 80%`
  String get orderAverage80 {
    return Intl.message(
      'You have consumed 80%',
      name: 'orderAverage80',
      desc: '',
      args: [],
    );
  }

  /// `Dear`
  String get dear {
    return Intl.message(
      'Dear',
      name: 'dear',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Kilometers limit`
  String get kilometerLimt {
    return Intl.message(
      'Kilometers limit',
      name: 'kilometerLimt',
      desc: '',
      args: [],
    );
  }

  /// `bonus on max limit`
  String get kilometerLimtMax {
    return Intl.message(
      'bonus on max limit',
      name: 'kilometerLimtMax',
      desc: '',
      args: [],
    );
  }

  /// `bonus on min limit`
  String get kilometerLimtMin {
    return Intl.message(
      'bonus on min limit',
      name: 'kilometerLimtMin',
      desc: '',
      args: [],
    );
  }

  /// `You have new notification`
  String get newMessageCommingOut {
    return Intl.message(
      'You have new notification',
      name: 'newMessageCommingOut',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get captainStateActive {
    return Intl.message(
      'Active',
      name: 'captainStateActive',
      desc: '',
      args: [],
    );
  }

  /// `UnActive`
  String get captainStateInactive {
    return Intl.message(
      'UnActive',
      name: 'captainStateInactive',
      desc: '',
      args: [],
    );
  }

  /// `choose your state`
  String get chooseYourState {
    return Intl.message(
      'choose your state',
      name: 'chooseYourState',
      desc: '',
      args: [],
    );
  }

  /// `update profile`
  String get updateProfile {
    return Intl.message(
      'update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about dispose your changes`
  String get areYouSureToDisposeThis {
    return Intl.message(
      'Are you sure about dispose your changes',
      name: 'areYouSureToDisposeThis',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get km {
    return Intl.message(
      'km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Store location`
  String get storeLocation {
    return Intl.message(
      'Store location',
      name: 'storeLocation',
      desc: '',
      args: [],
    );
  }

  /// `chat with client`
  String get chatWithClient {
    return Intl.message(
      'chat with client',
      name: 'chatWithClient',
      desc: '',
      args: [],
    );
  }

  /// `The order has been cancelled by the client`
  String get cancelledHint {
    return Intl.message(
      'The order has been cancelled by the client',
      name: 'cancelledHint',
      desc: '',
      args: [],
    );
  }

  /// `Upload Bill`
  String get makeBill {
    return Intl.message(
      'Upload Bill',
      name: 'makeBill',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the bill of the order`
  String get pleaseProvideStoreBill {
    return Intl.message(
      'Please provide the bill of the order',
      name: 'pleaseProvideStoreBill',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Location`
  String get receiptPoint {
    return Intl.message(
      'Receipt Location',
      name: 'receiptPoint',
      desc: '',
      args: [],
    );
  }

  /// `Destination Location`
  String get destinationPoint {
    return Intl.message(
      'Destination Location',
      name: 'destinationPoint',
      desc: '',
      args: [],
    );
  }

  /// `Expected Order Bill`
  String get expectedOrderBill {
    return Intl.message(
      'Expected Order Bill',
      name: 'expectedOrderBill',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get receipt {
    return Intl.message(
      'Receipt',
      name: 'receipt',
      desc: '',
      args: [],
    );
  }

  /// `Saving invoice process has been failed`
  String get saveInvoiceFailed {
    return Intl.message(
      'Saving invoice process has been failed',
      name: 'saveInvoiceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Saving invoice was a success`
  String get saveInvoiceSuccess {
    return Intl.message(
      'Saving invoice was a success',
      name: 'saveInvoiceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The total cost without delivery cost`
  String get totalBillCostHint {
    return Intl.message(
      'The total cost without delivery cost',
      name: 'totalBillCostHint',
      desc: '',
      args: [],
    );
  }

  /// `Total cost of store invoice`
  String get totalBillCost {
    return Intl.message(
      'Total cost of store invoice',
      name: 'totalBillCost',
      desc: '',
      args: [],
    );
  }

  /// `Please wait we are invoice saving ...`
  String get savingInvoice {
    return Intl.message(
      'Please wait we are invoice saving ...',
      name: 'savingInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Be the first one to send message`
  String get firstSendMessage {
    return Intl.message(
      'Be the first one to send message',
      name: 'firstSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `New Messages`
  String get lastSeenMessage {
    return Intl.message(
      'New Messages',
      name: 'lastSeenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Actual`
  String get actual {
    return Intl.message(
      'Actual',
      name: 'actual',
      desc: '',
      args: [],
    );
  }

  /// `Last Month`
  String get lastMonth {
    return Intl.message(
      'Last Month',
      name: 'lastMonth',
      desc: '',
      args: [],
    );
  }

  /// `Here we are showing captain balance status`
  String get myBalanceHint {
    return Intl.message(
      'Here we are showing captain balance status',
      name: 'myBalanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments To Company`
  String get sumPaymentsToCompany {
    return Intl.message(
      'Total Payments To Company',
      name: 'sumPaymentsToCompany',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments From Company`
  String get sumPaymentsFromCompany {
    return Intl.message(
      'Total Payments From Company',
      name: 'sumPaymentsFromCompany',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments To Captain`
  String get sumPaymentsToCaptain {
    return Intl.message(
      'Total Payments To Captain',
      name: 'sumPaymentsToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments From Captain`
  String get sumPaymentsFromCaptain {
    return Intl.message(
      'Total Payments From Captain',
      name: 'sumPaymentsFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Count Orders Delivered`
  String get countOrdersDelivered {
    return Intl.message(
      'Count Orders Delivered',
      name: 'countOrdersDelivered',
      desc: '',
      args: [],
    );
  }

  /// `My Actual Balance`
  String get amountYouOwn {
    return Intl.message(
      'My Actual Balance',
      name: 'amountYouOwn',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Amount For Company`
  String get remainingAmountForCompany {
    return Intl.message(
      'Remaining Amount For Company',
      name: 'remainingAmountForCompany',
      desc: '',
      args: [],
    );
  }

  /// `Bounce`
  String get bounce {
    return Intl.message(
      'Bounce',
      name: 'bounce',
      desc: '',
      args: [],
    );
  }

  /// `Kilometer Bonus`
  String get kilometerBonus {
    return Intl.message(
      'Kilometer Bonus',
      name: 'kilometerBonus',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get netProfit {
    return Intl.message(
      'Profit',
      name: 'netProfit',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `There is no permission to handle this feature`
  String get thereIsNoPermission {
    return Intl.message(
      'There is no permission to handle this feature',
      name: 'thereIsNoPermission',
      desc: '',
      args: [],
    );
  }

  /// `Completion Time`
  String get completeTime {
    return Intl.message(
      'Completion Time',
      name: 'completeTime',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `This account already exist`
  String get accountAlreadyExist {
    return Intl.message(
      'This account already exist',
      name: 'accountAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Stores Categories`
  String get storeCategories {
    return Intl.message(
      'Stores Categories',
      name: 'storeCategories',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addNewCategory {
    return Intl.message(
      'Add Category',
      name: 'addNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `CategoryName`
  String get categoryName {
    return Intl.message(
      'CategoryName',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Category created successfully`
  String get categoryCreatedSuccessfully {
    return Intl.message(
      'Category created successfully',
      name: 'categoryCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Stores List`
  String get storesList {
    return Intl.message(
      'Stores List',
      name: 'storesList',
      desc: '',
      args: [],
    );
  }

  /// `Add Stores`
  String get addStore {
    return Intl.message(
      'Add Stores',
      name: 'addStore',
      desc: '',
      args: [],
    );
  }

  /// `Product Category`
  String get productCategory {
    return Intl.message(
      'Product Category',
      name: 'productCategory',
      desc: '',
      args: [],
    );
  }

  /// `Product Categories`
  String get productCategories {
    return Intl.message(
      'Product Categories',
      name: 'productCategories',
      desc: '',
      args: [],
    );
  }

  /// `Choose Category`
  String get chooseCategory {
    return Intl.message(
      'Choose Category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Store Info`
  String get storeInfo {
    return Intl.message(
      'Store Info',
      name: 'storeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Don't Serve`
  String get notServe {
    return Intl.message(
      'Don\'t Serve',
      name: 'notServe',
      desc: '',
      args: [],
    );
  }

  /// `Serve`
  String get serve {
    return Intl.message(
      'Serve',
      name: 'serve',
      desc: '',
      args: [],
    );
  }

  /// `Store Management`
  String get storeManagment {
    return Intl.message(
      'Store Management',
      name: 'storeManagment',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get productPrice {
    return Intl.message(
      'Product Price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Captains`
  String get inActiveCaptains {
    return Intl.message(
      'Inactive Captains',
      name: 'inActiveCaptains',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get salary {
    return Intl.message(
      'Salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Account Status`
  String get captainStatus {
    return Intl.message(
      'Account Status',
      name: 'captainStatus',
      desc: '',
      args: [],
    );
  }

  /// `Online Status`
  String get status {
    return Intl.message(
      'Online Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Captain Activated Successfully`
  String get captainActivated {
    return Intl.message(
      'Captain Activated Successfully',
      name: 'captainActivated',
      desc: '',
      args: [],
    );
  }

  /// `Store Category Updated Successfully`
  String get updateStoreCategory {
    return Intl.message(
      'Store Category Updated Successfully',
      name: 'updateStoreCategory',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update Store`
  String get updateStore {
    return Intl.message(
      'Update Store',
      name: 'updateStore',
      desc: '',
      args: [],
    );
  }

  /// `Update Product Category`
  String get updateProductCategory {
    return Intl.message(
      'Update Product Category',
      name: 'updateProductCategory',
      desc: '',
      args: [],
    );
  }

  /// `Update Product`
  String get updateProduct {
    return Intl.message(
      'Update Product',
      name: 'updateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone 2`
  String get phone2 {
    return Intl.message(
      'Phone 2',
      name: 'phone2',
      desc: '',
      args: [],
    );
  }

  /// `Fax`
  String get fax {
    return Intl.message(
      'Fax',
      name: 'fax',
      desc: '',
      args: [],
    );
  }

  /// `STC`
  String get stc {
    return Intl.message(
      'STC',
      name: 'stc',
      desc: '',
      args: [],
    );
  }

  /// `Company Info`
  String get companyInfo {
    return Intl.message(
      'Company Info',
      name: 'companyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Captains`
  String get captains {
    return Intl.message(
      'Captains',
      name: 'captains',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get countCompletedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'countCompletedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Orders`
  String get countOngoingOrders {
    return Intl.message(
      'Ongoing Orders',
      name: 'countOngoingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Clients Count`
  String get countClients {
    return Intl.message(
      'Clients Count',
      name: 'countClients',
      desc: '',
      args: [],
    );
  }

  /// `Captains Count`
  String get countCaptains {
    return Intl.message(
      'Captains Count',
      name: 'countCaptains',
      desc: '',
      args: [],
    );
  }

  /// `Products Count`
  String get countProducts {
    return Intl.message(
      'Products Count',
      name: 'countProducts',
      desc: '',
      args: [],
    );
  }

  /// `Stores Count`
  String get countStores {
    return Intl.message(
      'Stores Count',
      name: 'countStores',
      desc: '',
      args: [],
    );
  }

  /// `Captains Balance`
  String get captainPayments {
    return Intl.message(
      'Captains Balance',
      name: 'captainPayments',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Image`
  String get invoiceImage {
    return Intl.message(
      'Invoice Image',
      name: 'invoiceImage',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Cost`
  String get invoiceCost {
    return Intl.message(
      'Invoice Cost',
      name: 'invoiceCost',
      desc: '',
      args: [],
    );
  }

  /// `Pending Orders`
  String get orderPending {
    return Intl.message(
      'Pending Orders',
      name: 'orderPending',
      desc: '',
      args: [],
    );
  }

  /// `Company Finance`
  String get companyFinance {
    return Intl.message(
      'Company Finance',
      name: 'companyFinance',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get financeProfileUpdateSuccessfully {
    return Intl.message(
      'Updated Successfully',
      name: 'financeProfileUpdateSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Mandoob Dashboard`
  String get twaslnaDashboard {
    return Intl.message(
      'Mandoob Dashboard',
      name: 'twaslnaDashboard',
      desc: '',
      args: [],
    );
  }

  /// `OnGoing Orders`
  String get ongoingOrders {
    return Intl.message(
      'OnGoing Orders',
      name: 'ongoingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Category Image`
  String get categoryImage {
    return Intl.message(
      'Category Image',
      name: 'categoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Store Created Successfully`
  String get storeCreatedSuccessfully {
    return Intl.message(
      'Store Created Successfully',
      name: 'storeCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store Updated Successfully`
  String get storeUpdatedSuccessfully {
    return Intl.message(
      'Store Updated Successfully',
      name: 'storeUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store Image`
  String get storeImage {
    return Intl.message(
      'Store Image',
      name: 'storeImage',
      desc: '',
      args: [],
    );
  }

  /// `Store Service`
  String get storeService {
    return Intl.message(
      'Store Service',
      name: 'storeService',
      desc: '',
      args: [],
    );
  }

  /// `Make Payments`
  String get paymentsManagement {
    return Intl.message(
      'Make Payments',
      name: 'paymentsManagement',
      desc: '',
      args: [],
    );
  }

  /// `Payment From Captain`
  String get paymentFromCaptain {
    return Intl.message(
      'Payment From Captain',
      name: 'paymentFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Payment To Captain`
  String get paymentToCaptain {
    return Intl.message(
      'Payment To Captain',
      name: 'paymentToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get paymentAmount {
    return Intl.message(
      'Payment amount',
      name: 'paymentAmount',
      desc: '',
      args: [],
    );
  }

  /// `Captain Info`
  String get captainInfo {
    return Intl.message(
      'Captain Info',
      name: 'captainInfo',
      desc: '',
      args: [],
    );
  }

  /// `Captain Balance Info`
  String get captainInfoBalance {
    return Intl.message(
      'Captain Balance Info',
      name: 'captainInfoBalance',
      desc: '',
      args: [],
    );
  }

  /// `Payments From Captain`
  String get paymentsFromCaptain {
    return Intl.message(
      'Payments From Captain',
      name: 'paymentsFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Payments To Captain`
  String get paymentsToCaptain {
    return Intl.message(
      'Payments To Captain',
      name: 'paymentsToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Payment has been registered successfully`
  String get paymentSuccessfully {
    return Intl.message(
      'Payment has been registered successfully',
      name: 'paymentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store Shift`
  String get workTime {
    return Intl.message(
      'Store Shift',
      name: 'workTime',
      desc: '',
      args: [],
    );
  }

  /// `Opening Time`
  String get openingTime {
    return Intl.message(
      'Opening Time',
      name: 'openingTime',
      desc: '',
      args: [],
    );
  }

  /// `Closing Time`
  String get closingTime {
    return Intl.message(
      'Closing Time',
      name: 'closingTime',
      desc: '',
      args: [],
    );
  }

  /// `Searching for categories`
  String get searchingForCategories {
    return Intl.message(
      'Searching for categories',
      name: 'searchingForCategories',
      desc: '',
      args: [],
    );
  }

  /// `searching for store`
  String get searchingForStores {
    return Intl.message(
      'searching for store',
      name: 'searchingForStores',
      desc: '',
      args: [],
    );
  }

  /// `Financial Dues`
  String get captainMoney {
    return Intl.message(
      'Financial Dues',
      name: 'captainMoney',
      desc: '',
      args: [],
    );
  }

  /// `Orders Account`
  String get ordersAccount {
    return Intl.message(
      'Orders Account',
      name: 'ordersAccount',
      desc: '',
      args: [],
    );
  }

  /// `Company profile created successfully`
  String get companyProfileCreatedSuccessfully {
    return Intl.message(
      'Company profile created successfully',
      name: 'companyProfileCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Company profile updated successfully`
  String get companyProfileUpdatedSuccessfully {
    return Intl.message(
      'Company profile updated successfully',
      name: 'companyProfileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get Logs {
    return Intl.message(
      'Logs',
      name: 'Logs',
      desc: '',
      args: [],
    );
  }

  /// `Captain Logs`
  String get captainLogs {
    return Intl.message(
      'Captain Logs',
      name: 'captainLogs',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search for store`
  String get searchForStore {
    return Intl.message(
      'Search for store',
      name: 'searchForStore',
      desc: '',
      args: [],
    );
  }

  /// `Store Logs`
  String get storeLogs {
    return Intl.message(
      'Store Logs',
      name: 'storeLogs',
      desc: '',
      args: [],
    );
  }

  /// `Today Order`
  String get countTodayOrder {
    return Intl.message(
      'Today Order',
      name: 'countTodayOrder',
      desc: '',
      args: [],
    );
  }

  /// `First Date`
  String get firstDate {
    return Intl.message(
      'First Date',
      name: 'firstDate',
      desc: '',
      args: [],
    );
  }

  /// `Last Date`
  String get lastDate {
    return Intl.message(
      'Last Date',
      name: 'lastDate',
      desc: '',
      args: [],
    );
  }

  /// `Captain Updated Successfully`
  String get captainUpdatedSuccessfully {
    return Intl.message(
      'Captain Updated Successfully',
      name: 'captainUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Distributor Updated Successfully`
  String get distroUpdatedSuccessfully {
    return Intl.message(
      'Distributor Updated Successfully',
      name: 'distroUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Products Report`
  String get productsReport {
    return Intl.message(
      'Products Report',
      name: 'productsReport',
      desc: '',
      args: [],
    );
  }

  /// `Clients Report`
  String get clientsReport {
    return Intl.message(
      'Clients Report',
      name: 'clientsReport',
      desc: '',
      args: [],
    );
  }

  /// `Stores Report`
  String get storesReports {
    return Intl.message(
      'Stores Report',
      name: 'storesReports',
      desc: '',
      args: [],
    );
  }

  /// `Captain Report`
  String get captainsReports {
    return Intl.message(
      'Captain Report',
      name: 'captainsReports',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message(
      'Score',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `deliver an order`
  String get captainDelivered {
    return Intl.message(
      'deliver an order',
      name: 'captainDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get captainDid {
    return Intl.message(
      'Captain',
      name: 'captainDid',
      desc: '',
      args: [],
    );
  }

  /// `received order`
  String get clientOrdered {
    return Intl.message(
      'received order',
      name: 'clientOrdered',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get clientDid {
    return Intl.message(
      'Client',
      name: 'clientDid',
      desc: '',
      args: [],
    );
  }

  /// `Order requested from store`
  String get storeDid {
    return Intl.message(
      'Order requested from store',
      name: 'storeDid',
      desc: '',
      args: [],
    );
  }

  /// `Request product`
  String get productOrdered {
    return Intl.message(
      'Request product',
      name: 'productOrdered',
      desc: '',
      args: [],
    );
  }

  /// `Specific`
  String get specific {
    return Intl.message(
      'Specific',
      name: 'specific',
      desc: '',
      args: [],
    );
  }

  /// `Clients`
  String get clients {
    return Intl.message(
      'Clients',
      name: 'clients',
      desc: '',
      args: [],
    );
  }

  /// `Store Availability`
  String get storeAvailable {
    return Intl.message(
      'Store Availability',
      name: 'storeAvailable',
      desc: '',
      args: [],
    );
  }

  /// ` Inactive Stores`
  String get storesInActive {
    return Intl.message(
      ' Inactive Stores',
      name: 'storesInActive',
      desc: '',
      args: [],
    );
  }

  /// `Orders Canceled`
  String get ordersCancel {
    return Intl.message(
      'Orders Canceled',
      name: 'ordersCancel',
      desc: '',
      args: [],
    );
  }

  /// `Create Date`
  String get createDate {
    return Intl.message(
      'Create Date',
      name: 'createDate',
      desc: '',
      args: [],
    );
  }

  /// `Main Categories`
  String get mainCategories {
    return Intl.message(
      'Main Categories',
      name: 'mainCategories',
      desc: '',
      args: [],
    );
  }

  /// `Please choose image of type (vector) with (96 px) rate with transparent background`
  String get imageSpecification {
    return Intl.message(
      'Please choose image of type (vector) with (96 px) rate with transparent background',
      name: 'imageSpecification',
      desc: '',
      args: [],
    );
  }

  /// `Please choose image with .png format`
  String get badFormat {
    return Intl.message(
      'Please choose image with .png format',
      name: 'badFormat',
      desc: '',
      args: [],
    );
  }

  /// `Sub Categories`
  String get subCategories {
    return Intl.message(
      'Sub Categories',
      name: 'subCategories',
      desc: '',
      args: [],
    );
  }

  /// `Update Category`
  String get updateCategory {
    return Intl.message(
      'Update Category',
      name: 'updateCategory',
      desc: '',
      args: [],
    );
  }

  /// `Categories Level 2`
  String get categoriesLevel2 {
    return Intl.message(
      'Categories Level 2',
      name: 'categoriesLevel2',
      desc: '',
      args: [],
    );
  }

  /// `Category Updated Successfully`
  String get updateCategorySuccessfully {
    return Intl.message(
      'Category Updated Successfully',
      name: 'updateCategorySuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sorry , We can't complete this action cause this category related with other items`
  String get errorDeleteCategory {
    return Intl.message(
      'Sorry , We can\'t complete this action cause this category related with other items',
      name: 'errorDeleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `Search for captain`
  String get searchForCaptain {
    return Intl.message(
      'Search for captain',
      name: 'searchForCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Language`
  String get preferredLanguage {
    return Intl.message(
      'Preferred Language',
      name: 'preferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this category`
  String get sureForDeleteCategories {
    return Intl.message(
      'Are you sure you want to delete this category',
      name: 'sureForDeleteCategories',
      desc: '',
      args: [],
    );
  }

  /// `Store Commission`
  String get commission {
    return Intl.message(
      'Store Commission',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `View products`
  String get viewProduct {
    return Intl.message(
      'View products',
      name: 'viewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `discount`
  String get discount {
    return Intl.message(
      'discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `commission`
  String get productCommission {
    return Intl.message(
      'commission',
      name: 'productCommission',
      desc: '',
      args: [],
    );
  }

  /// `Add commission`
  String get addCommission {
    return Intl.message(
      'Add commission',
      name: 'addCommission',
      desc: '',
      args: [],
    );
  }

  /// `Distributors`
  String get distributors {
    return Intl.message(
      'Distributors',
      name: 'distributors',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Distributors`
  String get inActiveDistributors {
    return Intl.message(
      'Inactive Distributors',
      name: 'inActiveDistributors',
      desc: '',
      args: [],
    );
  }

  /// `Search For Distributor`
  String get searchForDistributor {
    return Intl.message(
      'Search For Distributor',
      name: 'searchForDistributor',
      desc: '',
      args: [],
    );
  }

  /// `Store Balance`
  String get storeBalance {
    return Intl.message(
      'Store Balance',
      name: 'storeBalance',
      desc: '',
      args: [],
    );
  }

  /// `Payments for store`
  String get paymentsForStore {
    return Intl.message(
      'Payments for store',
      name: 'paymentsForStore',
      desc: '',
      args: [],
    );
  }

  /// `Amount owed for store`
  String get remainingAmountForStore {
    return Intl.message(
      'Amount owed for store',
      name: 'remainingAmountForStore',
      desc: '',
      args: [],
    );
  }

  /// `Total payments for store`
  String get sumPaymentsForStore {
    return Intl.message(
      'Total payments for store',
      name: 'sumPaymentsForStore',
      desc: '',
      args: [],
    );
  }

  /// `Private orders`
  String get outerOrder {
    return Intl.message(
      'Private orders',
      name: 'outerOrder',
      desc: '',
      args: [],
    );
  }

  /// `Categories Linking`
  String get categoriesLink {
    return Intl.message(
      'Categories Linking',
      name: 'categoriesLink',
      desc: '',
      args: [],
    );
  }

  /// `Linked Successfully`
  String get linkedSuccessfully {
    return Intl.message(
      'Linked Successfully',
      name: 'linkedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please press again to exit`
  String get exitWarning {
    return Intl.message(
      'Please press again to exit',
      name: 'exitWarning',
      desc: '',
      args: [],
    );
  }

  /// `Add new translate`
  String get addNewTrans {
    return Intl.message(
      'Add new translate',
      name: 'addNewTrans',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate Language Filed , please resolve it`
  String get duplicateLang {
    return Intl.message(
      'Duplicate Language Filed , please resolve it',
      name: 'duplicateLang',
      desc: '',
      args: [],
    );
  }

  /// `Price With Commission`
  String get priceWithComission {
    return Intl.message(
      'Price With Commission',
      name: 'priceWithComission',
      desc: '',
      args: [],
    );
  }

  /// `Payments List`
  String get paymentsList {
    return Intl.message(
      'Payments List',
      name: 'paymentsList',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get payStatus {
    return Intl.message(
      'Payment Status',
      name: 'payStatus',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this payment`
  String get areYouSureToDeleteThisPayment {
    return Intl.message(
      'Are you sure you want to delete this payment',
      name: 'areYouSureToDeleteThisPayment',
      desc: '',
      args: [],
    );
  }

  /// `Representative commission`
  String get representativeCommission {
    return Intl.message(
      'Representative commission',
      name: 'representativeCommission',
      desc: '',
      args: [],
    );
  }

  /// `Representative status`
  String get representativeStatus {
    return Intl.message(
      'Representative status',
      name: 'representativeStatus',
      desc: '',
      args: [],
    );
  }

  /// `Distributors Balance`
  String get distroPayments {
    return Intl.message(
      'Distributors Balance',
      name: 'distroPayments',
      desc: '',
      args: [],
    );
  }

  /// `Searching for Distributors`
  String get searchingForDistro {
    return Intl.message(
      'Searching for Distributors',
      name: 'searchingForDistro',
      desc: '',
      args: [],
    );
  }

  /// `Total payment to Distributors`
  String get totalPaymentToRepresentative {
    return Intl.message(
      'Total payment to Distributors',
      name: 'totalPaymentToRepresentative',
      desc: '',
      args: [],
    );
  }

  /// `Total dues to Distributors`
  String get totalDuToRepresentative {
    return Intl.message(
      'Total dues to Distributors',
      name: 'totalDuToRepresentative',
      desc: '',
      args: [],
    );
  }

  /// `Remaining amount to distributors`
  String get remainingAmountToDistro {
    return Intl.message(
      'Remaining amount to distributors',
      name: 'remainingAmountToDistro',
      desc: '',
      args: [],
    );
  }

  /// `Distributors info`
  String get distroInfo {
    return Intl.message(
      'Distributors info',
      name: 'distroInfo',
      desc: '',
      args: [],
    );
  }

  /// `Distributors Balance Info`
  String get distroInfoBalance {
    return Intl.message(
      'Distributors Balance Info',
      name: 'distroInfoBalance',
      desc: '',
      args: [],
    );
  }

  /// `Last Payments To Distributors`
  String get lastPaymentsToDistro {
    return Intl.message(
      'Last Payments To Distributors',
      name: 'lastPaymentsToDistro',
      desc: '',
      args: [],
    );
  }

  /// `Payment To Distributors`
  String get paymentToDistro {
    return Intl.message(
      'Payment To Distributors',
      name: 'paymentToDistro',
      desc: '',
      args: [],
    );
  }

  /// `Record number`
  String get recordNumber {
    return Intl.message(
      'Record number',
      name: 'recordNumber',
      desc: '',
      args: [],
    );
  }

  /// `Tax number`
  String get taxNumber {
    return Intl.message(
      'Tax number',
      name: 'taxNumber',
      desc: '',
      args: [],
    );
  }

  /// `National address`
  String get nationalAddress {
    return Intl.message(
      'National address',
      name: 'nationalAddress',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
