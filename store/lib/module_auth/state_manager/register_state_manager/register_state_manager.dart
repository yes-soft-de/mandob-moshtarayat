import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_about/service/about_service/about_service.dart';
import 'package:mandob_moshtarayat/module_auth/enums/auth_status.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RegisterStateManager {
  final AuthService _authService;
  final AboutService _aboutService;
  final _registerStateSubject = PublishSubject<RegisterState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late RegisterScreenState _registerScreen;
  bool? registered ;
  RegisterStateManager(this._authService,this._aboutService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.CODE_SENT:
//          _registerScreen.verifyFirst();
          _registerStateSubject.add(RegisterStatePhoneCodeSent(_registerScreen));
          break;
          case AuthStatus.CODE_RESENT:
          _registerScreen.resentCodeSucc();
          break;
          case AuthStatus.UNVERIFIED:
          _registerScreen.resendError();
          break;
           case AuthStatus.CODE_TIMEOUT:
          _registerScreen.wrongCode();
          break;
        case AuthStatus.AUTHORIZED:
          _aboutService.setInitialized();
          _registerScreen.moveToNext(_registerScreen.userID);
          break;
        case AuthStatus.REGISTERED:
          registered = true;
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreen));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _registerStateSubject.add(RegisterStateInit(_registerScreen, error: err,registered: registered??false));
    });
  }

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void registerClient(
      RegisterRequest request, RegisterScreenState _registerScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _registerScreen = _registerScreenState;
    _authService
        .registerApi(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
  void verifyClient(
      VerifyCodeRequest request, RegisterScreenState _registerScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _registerScreen = _registerScreenState;
    _authService
        .verifyCodeApi(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
  void resendCode(
      VerifyCodeRequest request, RegisterScreenState _registerScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _registerScreen = _registerScreenState;
    _authService
        .resendCode(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
}
