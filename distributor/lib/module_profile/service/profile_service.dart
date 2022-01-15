import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/manager/profile_manager.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/response/profile_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class ProfileService {
  final ProfileManager _storeManager;

  ProfileService(this._storeManager);

  Future<DataModel> getProfile() async {
    ProfileResponse? _storeResponse = await _storeManager.getProfile();

    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return ProfileModel.withData(_storeResponse.data!);
  }
//  Future<DataModel> updateStore(CreateStoreRequest request) async {
//    ActionResponse? actionResponse =
//    await _storeManager.updateStore(request);
//
//    if (actionResponse == null) {
//      return DataModel.withError(S.current.networkError);
//    }
//    if (actionResponse.statusCode != '204') {
//      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
//          actionResponse.statusCode));
//    }
//    return DataModel.empty();
//  }

}
