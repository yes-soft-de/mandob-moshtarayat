import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/manager/clients_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_list_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_need_support.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_need_support_response/client_need_support_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/clients_list_profile.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class ClientsService {
  final ClientsManager _clientsManager;

  ClientsService(this._clientsManager);

  Future<DataModel> getClients() async {
    ClientsListProfileResponse? _clientsListResponse =
        await _clientsManager.getClients();
    if (_clientsListResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clientsListResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _clientsListResponse.statusCode));
    }
    if (_clientsListResponse.data == null) return DataModel.empty();
    return ClientsListModel.withData(_clientsListResponse.data!);
  }

  Future<DataModel> getClientProfile(int captainId) async {
    ClientProfileResponse? _clientProfileResponse =
        await _clientsManager.getClientProfile(captainId);
    if (_clientProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clientProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _clientProfileResponse.statusCode));
    }
    if (_clientProfileResponse.data == null) return DataModel.empty();
    return ClientProfileModel.withData(_clientProfileResponse.data!);
  }

  Future<DataModel> getClientsFilter(String key) async {
    ClientsListProfileResponse? _captainFilter =
        await _clientsManager.getClientsFilter(key);
    if (_captainFilter == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainFilter.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_captainFilter.statusCode));
    }
    if (_captainFilter.data == null) return DataModel.empty();
    return ClientsListModel.withData(_captainFilter.data!);
  }

  Future<DataModel> getClientNeedSupport() async {
    ClientNeedSupportResponse? _clients =
        await _clientsManager.getClientSupport();
    if (_clients == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clients.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_clients.statusCode));
    }
    if (_clients.data == null) return DataModel.empty();
    return ClientsNeedSupportModel.withData(_clients.data!);
  }
}
