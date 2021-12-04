class Urls {
  static const String DOMAIN = 'http://138.197.186.138';

//  //newfl
//  static const String DOMAIN = 'http://206.189.61.207';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/storeownerregister';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const NOTIFICATIONNEWCHAT_API = BASE_API + '/notificationnewchat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const CREATE_STORE_PROFILE = BASE_API + '/storeowner' ;
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';
  static const STORE_CATEGORIES = BASE_API + '/storecategories';
  static const GET_STORE_PROFILE = BASE_API + '/storeownerprofilebyid';
  static const CREATE_PRODUCTS = BASE_API + '/createproductbystore';
  static const UPDATE_PRODUCT = BASE_API + '/updateproductbystore';
  static const GET_REPORT = BASE_API + '/countreportforstoreowner';
  static const GET_PENDING_ORDER = BASE_API + '/storeorderspending';
  static const GET_ONGOING_ORDERS = BASE_API + '/getstoreordersongoing';
  static const GET_SPECIFIC_DATE_ORDERS = BASE_API + '/getstoreordersinspecificdate/';
  static const GET_ORDER_DETAILS = BASE_API + '/orderdetailsforstore/';
  static const GET_ORDER_TIMELINE = BASE_API + '/orderLogsTimeLine/';
  static const CATEGORY_LEVEL_ONE = BASE_API + '/storeproductscategorylevelone/';
  static const CATEGORY_LEVEL_TWO = BASE_API + '/storeproductscategoryleveltwo/';
  static const GET_STORE_PRODUCT_BY_Category = BASE_API + '/productsbystoreproductcategoryidforstore/';
  static const GET_STORE_PRODUCT_BY_Category_LEVEL_ONE = BASE_API + '/productsbystorecategroylevelone/';
  static const GET_STORE_PRODUCT = BASE_API + '/getproductsstore';
  static const GET_LAST_PRODUCT = BASE_API + '/productslast30';
  static const GET_CAT_AND_STORE = BASE_API + '/storecategoriesandstores';
  static const UPDATE_PRODUCT_Status = BASE_API + '/updateproductstatusbystore';




}
