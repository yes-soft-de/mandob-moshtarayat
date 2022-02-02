import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/service/account_service.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_loaded_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_loading_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_state.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class AccountStateManager {
  final AccountService _accountService;
  final AuthService _authService;
  AccountStateManager(this._accountService, this._authService);
  final PublishSubject<AccountState> _stateSubject =
      PublishSubject<AccountState>();

  Stream<AccountState> get stateStream => _stateSubject.stream;

  void getProfile(AccountScreenState screenState) {
    _stateSubject.add(AccountLoadingState(screenState));
    bool signIn = _authService.isLoggedIn;
    if (signIn) {
      _accountService.getProfile().then((value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error)
            ..show(screenState.context);
          _stateSubject.add(AccountLoadedState(screenState,
              signIn: signIn, profileModel: value));
        } else if (value.isEmpty) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.profileDataEmpty)
            ..show(screenState.context);
          _stateSubject.add(AccountLoadedState(screenState,
              signIn: signIn, profileModel: value));
        } else {
          _stateSubject.add(AccountLoadedState(screenState,
              signIn: signIn, profileModel: value.data));
        }
      });
    } else {
      _stateSubject.add(AccountLoadedState(screenState, signIn: signIn));
    }
  }
}
