import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/manager/account_manager.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_post_stat.dart';
import 'package:mandob_moshtarayat/module_account/model/user_favorite_model.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/response/favourite_categories_response/favourite_categories_response.dart';
import 'package:mandob_moshtarayat/module_account/response/post_profile_response.dart';
import 'package:mandob_moshtarayat/module_account/response/profile_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/response/action_response.dart';

@injectable
class AccountService {
  final AccountManager _accountManager;

  AccountService(this._accountManager);

  Future<ProfileModel> getProfile() async {
    ProfileResponse? _profileResponse = await _accountManager.getProfile();
    if (_profileResponse == null) {
      return ProfileModel.Error(S.current.networkError);
    }
    if (_profileResponse.statusCode != '200') {
      return ProfileModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_profileResponse.statusCode));
    }
    if (_profileResponse.data == null) return ProfileModel.Empty();
    return ProfileModel.Data(_profileResponse);
  }

  Future<DataModel> getFavoriteCategoires() async {
    FavouriteCategoriesResponse? _profileResponse =
        await _accountManager.getFavoriteCategories();
    if (_profileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_profileResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_profileResponse.statusCode));
    }
    if (_profileResponse.data == null) return DataModel.empty();
    return UserFavouriteCategoriesModel.withData(_profileResponse.data ?? []);
  }

  Future<ProfilePostState> postClientProfile(ProfileRequest request) async {
    PostProfilerResponse? clientOrderResponse =
        await _accountManager.postClientProfile(request);
    if (clientOrderResponse == null) {
      return ProfilePostState.error(S.current.networkError);
    }
    if (clientOrderResponse.statusCode != '204') {
      return ProfilePostState.error(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    }
    return ProfilePostState.empty();
  }

  Future<DataModel> updatefavCategories(
      FavoriteCategoriesRequest request) async {
    ActionResponse? clientOrderResponse =
        await _accountManager.updateFavoriteCategories(request);
    if (clientOrderResponse == null) {
      await getIt<FavoriteHiveHelper>().clear();
      return DataModel.withError(S.current.networkError);
    }
    if (clientOrderResponse.statusCode != '204') {
      await getIt<FavoriteHiveHelper>().clear();
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    }
    getIt<FavoriteHiveHelper>().setFavoriteCategory(request.favouriteCategories!.first);
    return DataModel.empty();
  }
}
