import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/terms/terms_respons.dart';
import 'package:mandob_moshtarayat_captain/module_profile/repository/profile/profile.repository.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/response/get_records_response.dart';
import 'package:mandob_moshtarayat_captain/module_profile/response/profile_response.dart';

@injectable
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<CreateCaptainProfileResponse?> createCaptainProfile(
          ProfileRequest profileRequest) =>
      _repository.createCaptainProfile(profileRequest);

  Future<ProfileResponse?> getCaptainProfile() =>
      _repository.getCaptainProfile();

  Future<List<ActivityRecord>?> getMyLog() => _repository.getUserActivityLog();
  Future<List<Terms>?> getTerms() => _repository.getTerms();
}
