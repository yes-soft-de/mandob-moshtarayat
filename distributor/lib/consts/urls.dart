class Urls {
//  static const String DOMAIN = 'http://138.197.186.138';
  static const String DOMAIN = 'https://api.al-mandob.com';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/mandobregister';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const CREATE_MANDOB_PROFILE = BASE_API + '/mandobprofile';
  static const GET_MANDOB_PROFILE = BASE_API + '/representativeprofile';
//  static const REPORT_API = BASE_API +'/representativestatistics';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
   static const CHECK_USER_ROLE = BASE_API + '/checkUserType';
  static const GET_REPORT = BASE_API + '/representativestatistics';
  static const VERIFY_CODE_API = BASE_API + '/verifycode';
  static const CHECK_USER_VERIFIED_API = BASE_API + '/checkverificationstatus';
  static const RESEND_CODE_API = BASE_API + '/resendnewverificationcode';
  static const RESET_PASSWORD = BASE_API + '/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      BASE_API + '/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = BASE_API + '/updatepassword';
  static const GOOGLE_LINK = BASE_API + '/getstoreappurl/';
  static const GET_STORES = BASE_API + '/linkedstoresprofiles';
  static const GET_BALANCE = BASE_API + '/representativefinancialaccountinspecificdate/';



}
