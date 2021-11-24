import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/response/response.dart';
import 'package:mandob_moshtarayat/module_profile/manager/stores_manager.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/response/store_profile_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class StoresService {
  final StoreManager _storeManager;

  StoresService(this._storeManager);

  Future<DataModel> getStoreProfile() async {
    StoreProfileResponse? _storeResponse = await _storeManager.getStoreProfile();

    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreProfileModel.withData(_storeResponse.data!);
  }
  Future<DataModel> updateStore(CreateStoreRequest request) async {
    ActionResponse? actionResponse =
    await _storeManager.updateStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }

}
