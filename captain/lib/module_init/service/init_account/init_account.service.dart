import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_init/manager/init_account/init_account.manager.dart';
import 'package:mandob_moshtarayat_captain/module_init/model/profile_post_state.dart';
import 'package:mandob_moshtarayat_captain/module_init/request/create_bank_account/create_bank_account.dart';
import 'package:mandob_moshtarayat_captain/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/status_code_helper.dart';

@injectable
class InitAccountService {
  final InitAccountManager _manager;

  InitAccountService(
    this._manager,
  );

  Future<ProfilePostState> createCaptainProfile(
      CreateCaptainProfileRequest request) async {
    CreateCaptainProfileResponse? clientOrderResponse =
        await _manager.createCaptainProfile(request);
    if (clientOrderResponse == null)
      return ProfilePostState.error(S.current.networkError);
    if (clientOrderResponse.statusCode != '204')
      return ProfilePostState.error(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    return ProfilePostState.empty();
  }

  Future<dynamic> createBankDetails(String bankName, String bankAccountNumber) {
    return _manager.createBankAccount(
        CreateBankAccountRequest(bankName, bankAccountNumber));
  }
}
