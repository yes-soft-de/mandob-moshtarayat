import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_profile/repository/profile_repository.dart';
import 'package:mandob_moshtarayat/module_profile/response/profile_response.dart';

@injectable
class ProfileManager {

  final ProfileRepository _storesRepository;

  ProfileManager(this._storesRepository);

  Future<ProfileResponse?> getProfile() => _storesRepository.getProfile();
//  Future<ActionResponse?> updateStore(CreateStoreRequest request) => _storesRepository.updateStore(request);

}
