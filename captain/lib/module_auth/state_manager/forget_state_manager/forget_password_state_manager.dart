import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_captain/module_auth/enums/auth_status.dart';
import 'package:mandob_moshtarayat_captain/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:mandob_moshtarayat_captain/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/states/forget_password_state/forget_password_code_sent.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/states/forget_password_state/forget_state_update_password.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ForgotPassStateManager {
  final AuthService _authService;
  final PublishSubject<States> _forgotStateSubject = PublishSubject<States>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late ForgotPassScreenState _screenState;

  ForgotPassStateManager(this._authService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(const AsyncSnapshot.nothing());
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
      _loadingStateSubject.add(const AsyncSnapshot.nothing());
      _forgotStateSubject
          .add(ForgotStatePhoneCodeSent(_screenState, error: err));
    });
  }

  Stream<States> get stateStream => _forgotStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void loginClient(
    String username,
    String password,
    ForgotPassScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _authService.loginApi(username, password);
  }

  void verifyResetPassCodeRequest(VerifyResetPassCodeRequest request,
      ForgotPassScreenState _forgotScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _screenState = _forgotScreenState;
    _authService.verifyResetPassCodeRequest(request).whenComplete(
        () => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }

  void updatePassword(
      UpdatePassRequest request, ForgotPassScreenState _forgotScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _screenState = _forgotScreenState;
    _authService.updatePassword(request).whenComplete(
        () => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }
}
