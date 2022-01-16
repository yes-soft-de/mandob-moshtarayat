

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_init/repository/init_account/init_account.repository.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_init/response/create_profile_response/create_profile_response.dart';

@injectable
class InitAccountManager{
  final InitAccountRepository _repository;

  InitAccountManager(
      this._repository
      );

  Future<CreateCaptainProfileResponse?> createMandobProfile(CreateMandobRequest request) => _repository.createStoreProfile(request);


}