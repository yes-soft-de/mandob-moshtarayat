import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_empty_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_error_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/models/product.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;

  HomeStateManager(this._homeService);

  final PublishSubject<HomeState> stateSubject = PublishSubject<HomeState>();

  Stream<HomeState> get stateStream => stateSubject.stream;

  void getHomeData(HomeScreenState screenState) {
    stateSubject.add(HomeLoadingState(screenState));
    _homeService.getHomeData().then((value) {
      if (value.isEmpty) {
        stateSubject.add(HomeEmptyState(screenState, S.current.homeDataEmpty));
      } else if (value.hasData) {
        var data = value.data;
        stateSubject.add(HomeLoadedState(screenState,
            topProducts: data.topWanted,
            categories: data.storeCategory,
            bestStores: data.storeModel));
        if (value.hasErrors) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.errors[0])
              .show(screenState.context)
              .whenComplete(() {
            if (value.errors.length == 2) {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: value.errors[1],
                      timeout: 3)
                  .show(screenState.context);
            }
          });
        }
      } else {
        stateSubject.add(HomeErrorState(screenState, value.errors));
      }
    });
  }
}
