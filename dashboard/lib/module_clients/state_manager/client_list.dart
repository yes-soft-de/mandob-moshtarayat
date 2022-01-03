import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_list_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/service/clients_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/state/client_list/clients_loaded_state.dart';

@injectable
class ClientsStateManager {
  final ClientsService _clientsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  ClientsStateManager(this._clientsService);

  void getClients(ClientsScreenState screenState) {
    _clientsService.getClients().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(ClientsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(ClientsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ClientsListModel _model = value as ClientsListModel;
        _stateSubject.add(ClientsLoadedState(screenState, _model.data));
      }
    });
  }

  void getClientsFiltered(ClientsScreenState screenState, String searchKey) {
    _clientsService.getClientsFilter(searchKey).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(ClientsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(ClientsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ClientsListModel _model = value as ClientsListModel;
        _stateSubject.add(ClientsLoadedState(screenState, _model.data));
      }
    });
  }
}
