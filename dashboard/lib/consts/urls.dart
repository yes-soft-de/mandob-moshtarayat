// Developing Domain ===> 'http://138.197.186.138/';
// Production Domain ===> 'http://206.189.61.207'
// Named Domain ===> 'https://mandoob.password-please.com'
// Named Domain ===> 'https://api.al-mandob.com'

class Urls {
  static const String DOMAIN = 'http://138.197.186.138';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/createAdmin';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const REPORT_API = BASE_API + '/report';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const COMPANYINFO_API = BASE_API + '/companyinfoforuser';
  static const NOTIFICATIONNEWCHAT_API =
      BASE_API + '/notificationnewchatbyuserid';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      BASE_API + '/notificationnewchatanonymous';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const CREATE_CAPTAIN_PROFILE = BASE_API + '/captainprofile';
  static const CAPTAIN_ACTIVE_STATUS_API = BASE_API + '/captainisactive';
  static const ORDER_STATUS_API = BASE_API + '/orderDetails/';
  static const NEARBY_ORDERS_API = BASE_API + '/closestOrders';
  static const CAPTAIN_ACCEPTED_ORDERS_API = BASE_API + '/getAcceptedOrder';
  static const ACCEPT_ORDER_API = BASE_API + '/acceptedOrder';
  static const CAPTAIN_ORDER_UPDATE_API = BASE_API + '/orderUpdateState';
  static const ORDER_UPDATE_BILL_API =
      BASE_API + '/orderUpdateInvoiceByCaptain';
  static const UPDATES_API = BASE_API + '/updateall';
  static const ORDER_BY_ID = BASE_API + '/orderStatus/';
  static const SEND_TO_RECORD = BASE_API + '/record';
  static const CAPTAIN_PROFILE_API = BASE_API + '/captainprofile';
  static const TERMS_CAPTAIN = BASE_API + '/termscaptain';
  static const LOG_API = BASE_API + '/getRecords';
  static const CAPTAIN_BALANCE_ACCOUNT =
      BASE_API + '/captainfinancialaccountforadmin';
  static const CAPTAIN_BALANCE_LAST_MONTH =
      BASE_API + '/captainFinancialAccountInLastMonthForAdmin';
  static const GET_ORDER_LOGS = BASE_API + '/orderLogs';
  static const GET_CAPTAINS_LOGS = BASE_API + '/ordersandcountbycaptainid/';
  static const GET_STORES_LOGS = BASE_API + '/ordersandcountbystoreprofileid/';
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';
  static const STORE_CATEGORIES = BASE_API + '/storecategories';
  static const GET_STORE_CATEGORY = BASE_API + '/storecategory/';
  static const GET_PRODUCT_CATEGORY = BASE_API + '/storeproductcategory/';
  static const STORE_CATEGORIES_LINKING_API = BASE_API + '/allstorecategories';
  static const CREATE_STORE_CATEGORIES = BASE_API + '/createstorecategory';
  static const GET_STORES_BY_CATEGORY =
      BASE_API + '/storeownerbycategoryidforadmin';
  static const GET_STORES = BASE_API + '/storeowners';
  static const GET_STORES_INACTIVE = BASE_API + '/storesinactive';
  static const GET_STORES_INACTIVE_FILTER = BASE_API + '/storesinactivefilter/';
  static const GET_STORE_PROFILE = BASE_API + '/storeownerprofilebyid/';
  static const CREATE_STORES = BASE_API + '/storeownercreatbyadmin';
  static const CREATE_PAYMENTS_FOR_STORE =
      BASE_API + '/deliverycompanypaymentstostore';
  static const DELETE_PAYMENTS_FOR_STORE = BASE_API + '/paymenttostore';
  static const CREATE_SUB_CATEGORIES =
      BASE_API + '/storeproductcategorylevelone';
  static const GET_PRODUCTS_CATEGORY = BASE_API + '/storeProductsCategory/';
  static const GET_SUBCATEGORIES_LEVEL_ONE =
      BASE_API + '/storeproductscategorylevelonefroadmin';
  static const GET_ALL_SUBCATEGORIES_LEVEL_ONE =
      BASE_API + '/allproductcategorieslevelone';
  static const GET_ALL_SUBCATEGORIES_LEVEL_ONE_LINKING_API =
      BASE_API + '/allsubcategorieslevelone';
  static const GET_SUBCATEGORIES_LEVEL_TOW =
      BASE_API + '/storeproductscategoryleveltwoforadmin';
  static const GET_ALL_SUBCATEGORIES_LEVEL_TOW =
      BASE_API + '/allproductcategoriesleveltwo';
  static const GET_PRODUCTS = BASE_API + '/productsstorebyprofileid/';
  static const CREATE_PRODUCTS_CATEGORY = BASE_API + '/StoreProductCategory';
  static const CREATE_SUBCATEGORIES_LEVEL_TOW =
      BASE_API + '/storeproductcategoryleveltwo';
  static const CREATE_PRODUCTS = BASE_API + '/createproductbyadmin';
  static const CREATE_PRODUCTS_CATEGORY_FOR_STORE = '/StoreProductCategory';
  static const GET_IN_ACTIVE_CAPTAINS = BASE_API + '/getcaptainsinactive';
  static const CAPTAIN_FILTER = BASE_API + '/captainfilter/';
  static const STORE_FILTER = BASE_API + '/storeFilter/';
  static const CLIENT_FILTER = BASE_API + '/clientfilterbyname/';
  static const ACTIVATE_CAPTAIN = BASE_API + '/captainprofileupdatebyadmin';
  static const ACTIVATE_DISTRO = BASE_API + '/mandobupdatebyadmin';
  static const PAYMENTS_FROM_CAPTAIN =
      BASE_API + '/deliveryCompanyPaymentsFromCaptain';
  static const DELETE_PAYMENTS_FROM_CAPTAIN = BASE_API + '/paymentfromcaptain';
  static const PAYMENTS_TO_CAPTAIN =
      BASE_API + '/deliveryCompanyPaymentsToCaptain';
  static const PAYMENTS_TO_DISTRO =
      BASE_API + '/deliverycompanypaymenttorepresentative';
  static const DELETE_PAYMENTS_TO_CAPTAIN = BASE_API + '/paymenttocaptain';
  static const DELETE_PAYMENTS_TO_DISTRO = BASE_API + '/paymenttorepresentative';
  static const PAYMENTS_LIST = BASE_API + '/electronicpaymentinfo';
  static const GET_CAPTAIN_PROFILE = BASE_API + '/captainProfile/';
  static const GET_DISTRO_PROFILE = BASE_API + '/representativeprofile/';
  static const GET_CLIENT_PROFILE = BASE_API + '/clientprofilebyid/';
  static const UPDATE_STORE_CATEGORY = BASE_API + '/updatestorecategory';
  static const UPDATE_STORE = BASE_API + '/storeownerprofileupdatebyadmin';
  static const UPDATE_PRODUCT_CATEGORY = BASE_API + '/storeProductCategory';
  static const UPDATE_PRODUCT = BASE_API + '/updateProductByAdmin';
  static const GET_PROFILE_COMPANY = BASE_API + '/companyinfoall';
  static const GET_FINANCIAL_COMPANY = BASE_API + '/financialCompensations';
  static const UPDATE_FINANCIAL_COMPANY = BASE_API + '/financialCompensation';
  static const GET_DELIVERY_PRICE_COMPANY =
      BASE_API + '/getDeliveryCompanyFinancialById/1';
  static const UPDATE_DELIVERY_PRICE_COMPANY =
      BASE_API + '/deliveryCompanyFinancial';
  static const CREATE_COMPANY_PROFILE = BASE_API + '/companyinfo';
  static const GET_CAPTAINS_LIST = BASE_API + '/captains';
  static const GET_CLIENTS_LIST = BASE_API + '/clientsprofile';
  static const GET_REPORT = BASE_API + '/countreport';
  static const GET_ACCOUNT_BALANCE_CAPTAIN =
      BASE_API + '/captainfinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO =
      BASE_API + '/representativefinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_CAPTAIN_LAST_MONTH =
      BASE_API + '/captainfinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO_LAST_MONTH =
      BASE_API + '/representativefinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_CAPTAIN_SPECIFIC =
      BASE_API + '/captainfinancialaccountinspecificdateforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO_SPECIFIC =
      BASE_API + '/representativefinancialaccountinspecificdateforadmin/';
  static const GET_UNFINISHED_PAYMENT =
      BASE_API + '/captainsremainingforitamount';
  static const GET_REMAINING_PAYMENT =
      BASE_API + '/captainsremainingonitamount';
  static const GET_REMAINING_PAYMENT_TO_DISTRO =
      BASE_API + '/representativeremainigforitamount';
  static const GET_PENDING_ORDER = BASE_API + '/getpendingorders';
  static const GET_WITHOUT_PENDING_ORDER =
      BASE_API + '/getOrdersWithOutPending ';
  static const GET_ONGOING_ORDERS = BASE_API + '/getordersongoing';
  static const GET_SPECIFIC_DATE_ORDERS =
      BASE_API + '/getordersinspecificdate/';
  static const GET_ORDER_DETAILS = BASE_API + '/orderdetailsforadmin/';
  static const GET_ORDER_TIMELINE = BASE_API + '/orderlogstimeline/';
  static const GET_CAPTAINS_REPORT =
      BASE_API + '/countorderseverycaptaininlastmonth';
  static const GET_CAPTAINS_REPORT_SPECIFIC =
      BASE_API + '/countorderseverycaptaininspecificdate';
  static const GET_STORES_REPORT =
      BASE_API + '/countOrdersEveryStoreInLastMonth';
  static const GET_STORES_REPORT_SPECIFIC =
      BASE_API + '/countorderseverystoreinspecificdate';
  static const GET_CLIENTS_REPORT =
      BASE_API + '/countorderseveryclientinlastmonth';
  static const GET_CLIENTS_REPORT_SPECIFIC =
      BASE_API + '/countorderseveryclientinspecificdate';
  static const GET_PRODUCTS_REPORT =
      BASE_API + '/countorderseveryproductinlastmonth';
  static const GET_PRODUCTS_REPORT_SPECIFIC =
      BASE_API + '/countorderseveryproductinspecificdate';
  static const DELETE_SUB_CATEGORIES = BASE_API + '/storeproductcategory/';
  static const DELETE_CATEGORIES = BASE_API + '/storecategory/';
  static const UPDATE_PRODUCT_COMMISSION =
      BASE_API + '/updateproductcommissionbyadmin';
  static const GET_DISTRO_API = BASE_API + '/mandobfilterbystatus/';

  static const GET_ACCOUNT_BALANCE_STORE =
      BASE_API + '/storefinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_STORE_LAST_MONTH =
      BASE_API + '/captainfinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_STORE_SPECIFIC =
      BASE_API + '/captainfinancialaccountinspecificdateforadmin/';
  static const GET_CUSTOM_PRODUCTS_API = BASE_API + '/customproductsnotfound';
  static const GET_CLIENT_NEED_SUPPORT = BASE_API + '/clientwhoneedsupport';
  static const UPDATE_MAIN_CATEGORIES_LINK =
      BASE_API + '/mainsublevelonecategorieslink';
  static const UPDATE_SUB_CATEGORIES_LINK =
      BASE_API + '/levelonesubleveltwocategorieslink';

  static const CREATE_NEW_TRANS_STORE_CATEGORY =
      BASE_API + '/createstorecategorytranslation';
  static const CREATE_NEW_TRANS_PRODUCT_CATEGORY =
      BASE_API + '/createstoreproductcategorytranslation';
}
