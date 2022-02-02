import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/repository/clients_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_need_support_response/client_need_support_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/clients_list_profile.dart';

@injectable
class ClientsManager {
  final ClientsRepository _clientsRepository;

  ClientsManager(this._clientsRepository);

  Future<ClientsListProfileResponse?> getClients() =>
      _clientsRepository.getClients();
  Future<ClientProfileResponse?> getClientProfile(int captainId) =>
      _clientsRepository.getClientProfile(captainId);
  Future<ClientsListProfileResponse?> getClientsFilter(String searchKey) =>
      _clientsRepository.getClientFilters(searchKey);
  Future<ClientNeedSupportResponse?> getClientSupport() =>
      _clientsRepository.getClientSupport();
}
