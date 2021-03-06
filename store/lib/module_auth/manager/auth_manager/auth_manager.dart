import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/repository/auth/auth_repository.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/reset_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/update_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/verify_code_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/login_request/login_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/response/login_response/login_response.dart';
import 'package:mandob_moshtarayat/module_auth/response/regester_response/regester_response.dart';

@injectable
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<RegisterResponse?> register(RegisterRequest registerRequest) =>
      _authRepository.createUser(registerRequest);

  Future<RegisterResponse?> verify(VerifyCodeRequest registerRequest) =>
      _authRepository.verifyUser(registerRequest);

  Future<RegisterResponse?> checkUserIfVerified(VerifyCodeRequest registerRequest) =>
      _authRepository.checkUserIfVerified(registerRequest);
  Future<RegisterResponse?> resendCode(VerifyCodeRequest registerRequest) =>
      _authRepository.resendCode(registerRequest);

  Future<LoginResponse?> login(LoginRequest loginRequest) =>
      _authRepository.getToken(loginRequest);

  Future<RegisterResponse?> userTypeCheck(String role,String token) =>
      _authRepository.checkUserType(role,token);


  Future<RegisterResponse?> checkUserProfile( String token) =>
      _authRepository.checkUserProfile(token);



  Future<RegisterResponse?> resetPassRequest(ResetPassRequest request) =>
      _authRepository.resetPassRequest(request);

  Future<RegisterResponse?> updatePassRequest(UpdatePassRequest request) =>
      _authRepository.updatePassRequest(request);

  Future<RegisterResponse?> verifyResetPassCodeRequest(VerifyResetPassCodeRequest request) =>
      _authRepository.verifyResetPassCodeRequest(request);
}
