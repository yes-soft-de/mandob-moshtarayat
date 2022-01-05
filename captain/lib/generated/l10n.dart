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

  /// `Welcome to mandob_moshtarayat_captain`
  String get welcomeTomandob_moshtarayat_captain {
    return Intl.message(
      'Welcome to mandob_moshtarayat_captain',
      name: 'welcomeTomandob_moshtarayat_captain',
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

  /// `Please Download mandob_moshtarayat_captain`
  String get pleaseDownloadmandob_moshtarayat_captain {
    return Intl.message(
      'Please Download mandob_moshtarayat_captain',
      name: 'pleaseDownloadmandob_moshtarayat_captain',
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

  /// `deliver price`
  String get deliverPrice {
    return Intl.message(
      'deliver price',
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

  /// `WELCOME TO TWASLNA APP`
  String get welcomeToOurApp {
    return Intl.message(
      'WELCOME TO TWASLNA APP',
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

  /// `Here we are showing your balance status`
  String get myBalanceHint {
    return Intl.message(
      'Here we are showing your balance status',
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

  /// `Captain Account In Active , Please wait the administration to activate your account`
  String get captainAccountInActive {
    return Intl.message(
      'Captain Account In Active , Please wait the administration to activate your account',
      name: 'captainAccountInActive',
      desc: '',
      args: [],
    );
  }

  /// `Is billed on company`
  String get isBilledForCompany {
    return Intl.message(
      'Is billed on company',
      name: 'isBilledForCompany',
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

  /// `Choose captain profile photo`
  String get chooseCaptainProfile {
    return Intl.message(
      'Choose captain profile photo',
      name: 'chooseCaptainProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please provide driving license image`
  String get pleaseProvideDrivingImage {
    return Intl.message(
      'Please provide driving license image',
      name: 'pleaseProvideDrivingImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide identity image`
  String get pleaseProvideIdentityImage {
    return Intl.message(
      'Please provide identity image',
      name: 'pleaseProvideIdentityImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide Mechanic image`
  String get pleaseProvideMechImage {
    return Intl.message(
      'Please provide Mechanic image',
      name: 'pleaseProvideMechImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide profile image`
  String get pleaseProvideProfileImage {
    return Intl.message(
      'Please provide profile image',
      name: 'pleaseProvideProfileImage',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get invalidNumber {
    return Intl.message(
      'Invalid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Code`
  String get invalidCode {
    return Intl.message(
      'Invalid Code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Code number`
  String get codeNumber {
    return Intl.message(
      'Code number',
      name: 'codeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Code has expired`
  String get codeTimeOut {
    return Intl.message(
      'Code has expired',
      name: 'codeTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `The code has been successfully sent`
  String get resendCodeSuccessfully {
    return Intl.message(
      'The code has been successfully sent',
      name: 'resendCodeSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the code first`
  String get notVerifiedNumber {
    return Intl.message(
      'You must enter the code first',
      name: 'notVerifiedNumber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPass {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get passwordUpdatedSuccess {
    return Intl.message(
      'Password updated successfully',
      name: 'passwordUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `We will send a verification code to your number`
  String get informSendCode {
    return Intl.message(
      'We will send a verification code to your number',
      name: 'informSendCode',
      desc: '',
      args: [],
    );
  }

  /// `Password not matching`
  String get passwordNotMatch {
    return Intl.message(
      'Password not matching',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPass {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone number invalid format , cause is more than 9`
  String get phoneNumberLong {
    return Intl.message(
      'Phone number invalid format , cause is more than 9',
      name: 'phoneNumberLong',
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
