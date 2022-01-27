import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/enums/auth_status.dart';
import 'package:mandob_moshtarayat/module_auth/exceptions/auth_exception.dart';
import 'package:mandob_moshtarayat/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:mandob_moshtarayat/module_auth/presistance/auth_prefs_helper.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/reset_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/update_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/verify_code_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/login_request/login_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/response/login_response/login_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_auth/response/regester_response/regester_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@Injectable()
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthService(
    this._prefsHelper,
    this._authManager,
  );

  bool get isLoggedIn => _prefsHelper.isSignedIn();
  bool get needToInitAccount => _prefsHelper.needInit();
  String get username => _prefsHelper.getUsername() ?? '';
  void profiled() {
    _prefsHelper.setNeedInit(false);
  }

  Stream<AuthStatus> get authListener => _authSubject.stream;

  Future<void> loginApi(String username, String password) async {
    LoginResponse? loginResult = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResult == null) {
      await logout();
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.statusCode == '401') {
      await logout();
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.token == null) {
      await logout();
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
    }
    RegisterResponse? response =
        await _authManager.userTypeCheck('ROLE_OWNER', loginResult.token ?? '');

    if (response?.statusCode != '201') {
      await logout();
      _authSubject.addError(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
      throw AuthorizationException(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
    }
    RegisterResponse? responseVerify = await _authManager
        .checkUserIfVerified(VerifyCodeRequest(userID: username));
    if (responseVerify?.statusCode != '200') {
      await logout();
      _authSubject.add(AuthStatus.CODE_SENT);
      throw AuthorizationException(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
    }
    RegisterResponse? responseProfile =
    await _authManager.checkUserProfile(loginResult.token ?? '');
    if (responseProfile?.statusCode != '200') {
      print('INsProfile');
      _prefsHelper.setNeedInit(true);

      _prefsHelper.setUsername(username);
      _prefsHelper.setPassword(password);
      _prefsHelper.setToken(loginResult.token);

      _authSubject.add(AuthStatus.UNREGISTERED);
      throw AuthorizationException(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));

    }

    _prefsHelper.setUsername(username);
    _prefsHelper.setPassword(password);
    _prefsHelper.setToken(loginResult.token);

    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> registerApi(RegisterRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.register(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    _authSubject.add(AuthStatus.CODE_SENT);

//    await loginApi(request.userID ?? '', request.password ?? '');
  }

  Future<void> verifyCodeApi(VerifyCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.verify(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '200') {
      _authSubject.add(AuthStatus.CODE_TIMEOUT);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    _authSubject.add(AuthStatus.REGISTERED);
//    _prefsHelper.setNeedInit(true);
    await loginApi(request.userID, request.password ?? '');
  }

  Future<String?> getToken() async {
    try {
      var tokenDate = this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created ${diff} minutes ago');
      }
      return await this._prefsHelper.getToken();
    } on AuthorizationException {
      _prefsHelper.deleteToken();
      return null;
    } on TokenExpiredException {
      return await refreshToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String?> refreshToken() async {
    String? username = await _prefsHelper.getUsername();
    String? password = await _prefsHelper.getPassword();
    LoginResponse? loginResponse = await _authManager.login(LoginRequest(
      username: username ?? '',
      password: password,
    ));
    if (loginResponse == null) {
      await _prefsHelper.cleanAll();
      return null;
    }
    _prefsHelper.setToken(loginResponse.token);

    return loginResponse.token;
  }

  Future<void> logout() async {
    await _prefsHelper.cleanAll();
  }

  Future<void> resendCode(VerifyCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.resendCode(request);
    if (registerResponse == null) {
//      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.add(AuthStatus.UNVERIFIED);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _authSubject.add(AuthStatus.CODE_RESENT);
    }
  }

  Future<void> resetPassRequest(ResetPassRequest request) async {
    request.role = 'ROLE_OWNER';
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.resetPassRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _prefsHelper.setUsername(request.userID);
      _authSubject.add(AuthStatus.NOT_LOGGED_IN);
    }
  }

  Future<void> verifyResetPassCodeRequest(
      VerifyResetPassCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.verifyResetPassCodeRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '200') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _authSubject.add(AuthStatus.VERIFIED);
    }
  }

  Future<void> updatePassword(UpdatePassRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.updatePassRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '204') {
      _authSubject.add(AuthStatus.UNVERIFIED);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      loginApi(username, request.newPassword);
    }
  }
}
