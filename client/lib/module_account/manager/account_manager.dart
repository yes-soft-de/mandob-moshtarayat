import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_account/repository/account_repository.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/response/post_profile_response.dart';
import 'package:mandob_moshtarayat/module_account/response/profile_response.dart';

@injectable
class AccountManager {
  final AccountRepository _accountRepository;
  AccountManager(this._accountRepository);

  Future<ProfileResponse?> getProfile() =>
      _accountRepository.getClientProfile();
  Future<PostProfilerResponse?> postClientProfile(ProfileRequest request) =>
      _accountRepository.postClientProfile(request);
}
