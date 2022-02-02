import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_need_support.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_needs_support_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/state/clients_supports/clients_support_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/service/clients_service.dart';

@injectable
class ClientsNeedsSupportStateManager {
  final ClientsService _clientsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  ClientsNeedsSupportStateManager(this._clientsService);

  void getClients(ClientsNeedsSupportScreenState screenState) {
    _clientsService.getClientNeedSupport().then((value) {
      if (value.hasError) {
        _stateSubject.add(ClientsNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(ClientsNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        ClientsNeedSupportModel _model = value as ClientsNeedSupportModel;
        _stateSubject
            .add(ClientsNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}
