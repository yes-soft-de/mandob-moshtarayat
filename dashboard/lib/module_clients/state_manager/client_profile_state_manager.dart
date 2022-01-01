import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/service/clients_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/state/client_profile/client_profile.dart';

@injectable
class ClientProfileStateManager {
  final ClientsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  ClientProfileStateManager(this._captainsService);

  void getClientProfile(ClientProfileScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getClientProfile(captainId).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ClientProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            ClientProfileLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ClientProfileModel _model = value as ClientProfileModel;
        _stateSubject.add(ClientProfileLoadedState(screenState, _model.data));
      }
    });
  }
}
