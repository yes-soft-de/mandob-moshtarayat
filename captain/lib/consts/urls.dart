// Developing Domain ===> 'http://138.197.186.138';
// Production Domain ===> 'http://206.189.61.207'
// Named Domain ===> 'https://api.al-mandob.com'

class Urls {
  static const String DOMAIN = 'https://api.al-mandob.com';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/captainregister';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const VERIFY_CODE_API = BASE_API + '/verifycode';
  static const CHECK_USER_VERIFIED_API = BASE_API + '/checkverificationstatus';
  static const RESEND_CODE_API = BASE_API + '/resendnewverificationcode';
  static const REPORT_API = BASE_API + '/report';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const COMPANYINFO_API = BASE_API + '/companyinfoforuser';
  static const NOTIFICATIONNEWCHAT_API = BASE_API + '/notificationnewchatbyuserid';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const CREATE_CAPTAIN_PROFILE = BASE_API + '/captainprofile';
  static const CAPTAIN_ACTIVE_STATUS_API = BASE_API + '/captainisactive';
  static const ORDER_STATUS_API = BASE_API + '/orderdetails/';
  static const NEARBY_ORDERS_API = BASE_API + '/closestorders';
  static const CAPTAIN_ACCEPTED_ORDERS_API = BASE_API + '/getacceptedorder';
  static const ACCEPT_ORDER_API = BASE_API + '/acceptedOrder';
  static const CAPTAIN_ORDER_UPDATE_API = BASE_API + '/orderupdatestate';
  static const ORDER_UPDATE_BILL_API =
      BASE_API + '/orderupdateinvoicebycaptain';
  static const BILLED_FOR_COMPANY_API =
      BASE_API + '/orderupdatebillcalculatedbycaptain';
  static const UPDATES_API = BASE_API + '/updateall';
  static const ORDER_BY_ID = BASE_API + '/orderStatus/';
  static const SEND_TO_RECORD = BASE_API + '/record';
  static const CAPTAIN_PROFILE_API = BASE_API + '/captainprofile';
  static const TERMS_CAPTAIN = BASE_API + '/termscaptain';
  static const LOG_API = BASE_API + '/getRecords';
  static const CAPTAIN_BALANCE_ACCOUNT = BASE_API + '/captainfinancialaccount';
  static const CAPTAIN_BALANCE_LAST_MONTH =
      BASE_API + '/captainfinancialaccountinlastmonth';
  static const GET_ORDER_LOGS = BASE_API + '/orderlogs';
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';
  static const UPDATE_STORE_ORDER_STATE =
      BASE_API + '/orderupdatestateforeachstore';
        static const RESET_PASSWORD = BASE_API + '/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      BASE_API + '/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = BASE_API + '/updatepassword';
}
