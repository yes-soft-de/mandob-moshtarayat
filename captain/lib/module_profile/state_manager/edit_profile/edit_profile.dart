import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/service/profile/profile.service.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:mandob_moshtarayat_captain/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class EditProfileStateManager {
  final _stateSubject = PublishSubject<ProfileState>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;
  final AuthService _authService;

  EditProfileStateManager(
    this._imageUploadService,
    this._profileService,
    this._authService,
  );

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void uploadImage(
      EditProfileScreenState screenState, ProfileRequest request, String? type,
      [String? image]) {
    _imageUploadService
        .uploadImage(image ?? request.image!)
        .then((uploadedImageLink) {
      if (uploadedImageLink == null) {
        _stateSubject.add(ProfileStateDirtyProfile(screenState, request,
            backToProfile: request.canGoBack ?? false));
        screenState.showMessage(S.current.errorUploadingImages, false);
      } else {
        if (type == 'identity') {
          request.identity = uploadedImageLink;
        } else if (type == 'mechanic') {
          request.mechanicLicense = uploadedImageLink;
        } else if (type == 'driving') {
          request.drivingLicence = uploadedImageLink;
        } else {
          request.image = uploadedImageLink;
        }
        _stateSubject.add(ProfileStateDirtyProfile(screenState, request,
            backToProfile: request.canGoBack ?? false));
        screenState.showMessage(S.current.uploadImageSuccess, true);
      }
    });
  }

  void submitProfile(
      EditProfileScreenState screenState, ProfileRequest request) {
    _stateSubject.add(ProfileStateLoading(screenState));

    _profileService.createProfile(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ProfileStateDirtyProfile(screenState, request,
            backToProfile: request.canGoBack ?? false));
        screenState.showMessage(value.error, false);
      } else {
        getProfile(screenState, true);
      }
    });
  }

  void getProfile(EditProfileScreenState screenState, [bool updated = false]) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.getProfile().then((profile) {
      if (profile.hasError) {
        _stateSubject.add(ProfileStateDirtyProfile(
          screenState,
          ProfileRequest.empty(),
        ));
        screenState.showMessage(profile.error, false);
      } else if (profile.empty) {
        _stateSubject.add(ProfileStateDirtyProfile(
          screenState,
          ProfileRequest.empty(),
        ));
        screenState.showMessage(S.current.pleaseCompleteTheForm, false);
      } else {
        var value = profile.data;
        _stateSubject.add(ProfileStateGotProfile(
          screenState,
          ProfileRequest(
            name: value.name,
            image: value.image,
            phone: value.phone,
            drivingLicence: value.drivingLicence,
            bankName: value.bankName,
            bankAccountNumber: value.bankNumber,
            stcPay: value.stcPay,
            car: value.car,
            age: value.age.toString(),
            mechanicLicense: value.mechanicLicense,
            identity: value.identity,
            isOnline: value.isOnline,
            canGoBack: false,
          ),
        ));
        if (updated) {
          screenState.showMessage(S.current.uploadProfileSuccess, true);
        } else {
          screenState.showMessage(S.current.profileFetchedSuccessfully, true);
        }
      }
    });
  }
}
