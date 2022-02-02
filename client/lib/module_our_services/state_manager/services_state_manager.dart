import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/service/services_service.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_loading_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_state.dart';

@injectable
class ServicesStateManager {
  final ServicesService _servicesService;
  final AuthService _authService;

  ServicesStateManager(this._servicesService, this._authService);

  PublishSubject<SendItState> stateSubject = PublishSubject<SendItState>();

  Stream<SendItState> get stateStream => stateSubject.stream;

  void SendItClientOrder(SendItRequest request, SendItScreenState screenState) {
    if (_authService.isLoggedIn) {
      stateSubject.add(SendItLoadingState(screenState));
      _servicesService.sendItClintOrder(request).then((value) {
        if (value.hasError) {
          screenState.moveDecision(false, value.getError);
        } else {
          screenState.moveDecision(true);
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}
