import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_my_notifications/service/my_notification_service.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notification_empty_state.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_error_state.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_loaded_state.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_loading_state.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/state/my_notifications/my_notifications_state.dart';

@injectable
class MyNotificationsStateManager {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;

  MyNotificationsStateManager(this._myNotificationsService, this._authService);
  final PublishSubject<MyNotificationsState> _stateSubject =
      PublishSubject<MyNotificationsState>();

  Stream<MyNotificationsState> get stateStream => _stateSubject.stream;

  void getNotifications(MyNotificationsScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(MyNotificationsLoadingState(screenState));
      _myNotificationsService.getNotification().then((value) {
        if (value.hasError) {
          _stateSubject.add(MyNotificationsErrorState(
              screenState, value.error ?? S.current.errorHappened));
        } else if (value.isEmpty) {
          _stateSubject.add(
              MyNotificationsEmptyState(screenState, S.current.homeDataEmpty));
        } else {
          _stateSubject
              .add(MyNotificationsLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}
