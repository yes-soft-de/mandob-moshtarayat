import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_home/model/report_model.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_state/home_state_loaded.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/service/store_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  HomeStateManager(this._homeService,this._storesService);

  void getReport(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getReport().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState,null, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(HomeLoadedState(screenState,null ,null));
      } else {
        ReportModel data = value as ReportModel;
        StoreProfileModel model = value as StoreProfileModel;
        _stateSubject.add(HomeLoadedState(screenState,null, model));
      }
    });
  }
  void getProfileStore(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreProfile().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState, null,null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(HomeLoadedState(screenState, null,null));
      } else {
        ReportModel report = ReportModel(countCaptains: 5,countClients: 2,countCompletedOrders: 2,countOngoingOrders: 1,countProducts: 2,countStores: 2);
        StoreProfileModel model = value as StoreProfileModel;
        print('in staet');
        print(model.categoryId);
        _stateSubject.add(HomeLoadedState(screenState, report,model));
      }
    });
  }

}
