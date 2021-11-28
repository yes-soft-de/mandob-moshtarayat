import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_init/repository/init_account/init_account.repository.dart';
import 'package:mandob_moshtarayat_captain/module_init/request/create_bank_account/create_bank_account.dart';
import 'package:mandob_moshtarayat_captain/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_init/response/create_profile_response/create_profile_response.dart';

@injectable
class InitAccountManager {
  final InitAccountRepository _repository;

  InitAccountManager(this._repository);

  Future<CreateCaptainProfileResponse?> createCaptainProfile(
          CreateCaptainProfileRequest request) =>
      _repository.createCaptainProfile(request);

  Future<dynamic> createBankAccount(
      CreateBankAccountRequest createBankAccountRequest) {
    return _repository.createBankAccount(createBankAccountRequest);
  }
}
