import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
  import 'package:mandob_moshtarayat/module_stores/manager/store_manager.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_model.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class StoreService {
  final StoreManager _storeManager;

  StoreService(this._storeManager);

  Future<DataModel> getStores() async {
    StoreResponse? _storeResponse = await _storeManager.getStores();

    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreModel.withData(_storeResponse.data!);
  }

}
