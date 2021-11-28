import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_init/model/profile_post_state.dart';
import 'package:mandob_moshtarayat_captain/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/terms/terms_respons.dart';
import 'package:mandob_moshtarayat_captain/module_orders/service/orders/orders.service.dart';
import 'package:mandob_moshtarayat_captain/module_profile/manager/profile/profile.manager.dart';
import 'package:mandob_moshtarayat_captain/module_profile/model/activity_model/activity_model.dart';
import 'package:mandob_moshtarayat_captain/module_profile/model/profile_model/profile_model.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/response/profile_response.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/status_code_helper.dart';

@injectable
class ProfileService {
  final ProfileManager _manager;
  final OrdersService _ordersService;

  ProfileService(this._manager, this._ordersService);

  Future<ProfileModel> getProfile() async {
    ProfileResponse? response = await _manager.getCaptainProfile();
    if (response == null) {
      return ProfileModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (response.statusCode != '200')
      return ProfileModel.error(StatusCodeHelper.getStatusCodeMessages(code));
    if (response.data == null) return ProfileModel.empty();
    return ProfileModel.withData(response.data!);
  }

  Future<ProfilePostState> createProfile(ProfileRequest profileRequest) async {
    CreateCaptainProfileResponse? clientOrderResponse =
        await _manager.createCaptainProfile(profileRequest);
    if (clientOrderResponse == null)
      return ProfilePostState.error(S.current.networkError);
    if (clientOrderResponse.statusCode != '204')
      return ProfilePostState.error(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    await _ordersService.insertWatcher();
    return ProfilePostState.empty();
  }

  Future<List<ActivityModel>?> getActivity() async {
    var records = await _manager.getMyLog();
    var activity = <int, ActivityModel>{};
    if (records == null) {
      return [];
    }
    if (records.isEmpty) {
      return [];
    }
    records.forEach((e) {
      if (e.state == 'delivered') {
        activity[e.id!] = ActivityModel(
            startDate: DateTime.fromMillisecondsSinceEpoch(
                e.record!.first.date!.timestamp! * 1000),
            endDate: DateTime.fromMillisecondsSinceEpoch(
                e.record!.last.date!.timestamp! * 1000),
            activity: '${e.brancheName}, #${e.id.toString()}');
      }
    });

    return activity.values.toList();
  }

  Future<List<Terms>?> getTerms() async {
    return await _manager.getTerms();
  }
}
