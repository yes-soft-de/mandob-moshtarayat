import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_profile/repository/profile_repository.dart';
import 'package:mandob_moshtarayat/module_profile/response/action_response.dart';
import 'package:mandob_moshtarayat/module_profile/response/profile_response.dart';

@injectable
class ProfileManager {

  final ProfileRepository _storesRepository;

  ProfileManager(this._storesRepository);

  Future<ProfileResponse?> getProfile() => _storesRepository.getProfile();
  Future<ActionResponse?> updateStore(CreateMandobRequest request) => _storesRepository.updateProfile(request);

}
