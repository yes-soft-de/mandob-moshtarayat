import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/enums/auth_status.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/update_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/verify_code_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/forgot_pass_screen/forgot_pass_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/forgot_pass_states/forgot_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/forgot_pass_states/forgot_state_code_sent.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/forgot_pass_states/forgot_state_update_pass.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ForgotPassStateManager {
  final AuthService _authService;
  final PublishSubject<ForgotPassState> _forgotStateSubject =
  PublishSubject<ForgotPassState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late ForgotPassScreenState _screenState;

  ForgotPassStateManager(this._authService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _screenState.moveToLogin();
          break;
        case AuthStatus.VERIFIED:
          _forgotStateSubject.add(ForgotStateUpdatePassword(_screenState));
          break;
        case AuthStatus.CODE_SENT:
          _forgotStateSubject.add(ForgotStatePhoneCodeSent(_screenState));
          break;
        default:
          _forgotStateSubject.add(ForgotStatePhoneCodeSent(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _forgotStateSubject.add(ForgotStatePhoneCodeSent(_screenState, error: err));
    });
  }

  Stream<ForgotPassState> get stateStream => _forgotStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void loginClient(
      String username,
      String password,
      ForgotPassScreenState _loginScreenState,
      ) {
    _screenState = _loginScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.loginApi(username, password);
  }
  void verifyResetPassCodeRequest(
      VerifyResetPassCodeRequest request, ForgotPassScreenState _forgotScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _screenState = _forgotScreenState;
    _authService
        .verifyResetPassCodeRequest(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
  void updatePassword(
      UpdatePassRequest request, ForgotPassScreenState _forgotScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _screenState = _forgotScreenState;
    _authService
        .updatePassword(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
//  void resendCode(
//      VerifyCodeRequest request, LoginScreenState _loginScreenState) {
//    _loadingStateSubject.add(AsyncSnapshot.waiting());
//    _screenState = _loginScreenState;
//    _authService
//        .resendCode(request)
//        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
//  }
}