import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/report_model.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_state/home_state_loaded.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/service/profile_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final ProfileService _profileService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  final PublishSubject<ProfileModel> _profileSubject = PublishSubject();

  Stream<ProfileModel> get profileStream => _profileSubject.stream;

  HomeStateManager(this._homeService, this._profileService);

//  void getReport(HomeScreenState screenState) {
//    ReportModel   data = ReportModel(countCompletedOrders: 5, countOngoingOrders: 5, countOrdersInToday: 1);
////        StoreProfileModel model = value as StoreProfileModel;
//    _stateSubject.add(HomeLoadedState(screenState,data));
//
////    print('dddfff');
////    _stateSubject.add(LoadingState(screenState));
////    _homeService.getReport().then((value) {
////      if (value.hasError) {
////        _stateSubject
////            .add(HomeLoadedState(screenState,null, error: value.error));
////      } else if (value.isEmpty) {
////        _stateSubject.add(HomeLoadedState(screenState,null));
////      } else {
////        ReportModel data = value as ReportModel;
////        data = ReportModel(countCompletedOrders: 5, countOngoingOrders: 5, countOrdersInToday: 1);
//////        StoreProfileModel model = value as StoreProfileModel;
////        _stateSubject.add(HomeLoadedState(screenState,data));
////      }
////    });
//  }
  void getProfile(HomeScreenState screenState) {
    _stateSubject.add(HomeLoadingState(screenState));
    _profileService.getProfile().then((profile) {
      if (profile.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState,null, error: profile.error));
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: profile.error??'')
            .show(screenState.context);
      } else if (profile.isEmpty) {
        _stateSubject
            .add(HomeLoadedState(screenState,null, error: profile.error));
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.profileDataEmpty)
            .show(screenState.context);
      } else {
        ProfileModel model= profile as ProfileModel;
        _profileSubject.add(model.data);
        _homeService.getReport().then((report) {
          if(report.hasError){
            _stateSubject
            .add(HomeLoadedState(screenState,null, error: report.error));
          }else{
            ReportModel   data = report as ReportModel;
            _stateSubject.add(HomeLoadedState(screenState,data));
          }
        });
      }
    });
  }
//  void getProfileStore(HomeScreenState screenState) {
//    _stateSubject.add(LoadingState(screenState));
//    _storesService.getStoreProfile().then((value) {
//      if (value.hasError) {
//        _stateSubject
//            .add(HomeLoadedState(screenState, null,null, error: value.error));
//      } else if (value.isEmpty) {
//        _stateSubject.add(HomeLoadedState(screenState, null,null));
//      } else {
//        ReportModel data = value as ReportModel;
//        StoreProfileModel model = value as StoreProfileModel;
//
//        _stateSubject.add(HomeLoadedState(screenState, report,model.data));
//      }
//    });
//  }

}
