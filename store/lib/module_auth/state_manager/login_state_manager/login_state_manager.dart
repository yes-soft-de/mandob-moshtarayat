import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/enums/auth_status.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/reset_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late LoginScreenState _screenState;

  LoginStateManager(this._authService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _screenState.moveToNext();
          break;
          case AuthStatus.UNREGISTERED:
          _screenState.moveToProfileInit();
          break;
          case AuthStatus.CODE_SENT:
          _screenState.verifyFirst();
          break;
        case AuthStatus.NOT_LOGGED_IN:
          _screenState.moveToForgetPage();
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _loginStateSubject.add(LoginStateInit(_screenState, error: err));
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void loginClient(
    String username,
    String password,
    LoginScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.loginApi(username, password);
  }

  void resetCodeRequest(
      ResetPassRequest request, LoginScreenState _loginScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _screenState = _loginScreenState;
    _authService
        .resetPassRequest(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
}
