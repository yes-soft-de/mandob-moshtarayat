import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/company_info/company_info.dart';
import 'package:mandob_moshtarayat_captain/module_orders/service/orders/orders.service.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state_error.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:mandob_moshtarayat_captain/module_profile/model/profile_model/profile_model.dart';
import 'package:mandob_moshtarayat_captain/module_profile/service/profile/profile.service.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainOrdersListStateManager {
  final OrdersService _ordersService;
  final ProfileService _profileService;

  final PublishSubject<CaptainOrdersListState> _stateSubject =
      PublishSubject<CaptainOrdersListState>();
  final PublishSubject<ProfileModel> _profileSubject =
      PublishSubject<ProfileModel>();
  final PublishSubject<CompanyInfoResponse> _companySubject =
      PublishSubject<CompanyInfoResponse>();
  Stream<ProfileModel> get profileStream => _profileSubject.stream;
  Stream<CaptainOrdersListState> get stateStream => _stateSubject.stream;
  Stream<CompanyInfoResponse> get companyStream => _companySubject.stream;

  CaptainOrdersListStateManager(this._ordersService, this._profileService);
  StreamSubscription? newActionSubscription;

  void getProfile(CaptainOrdersScreenState screenState) {
    _profileService.getProfile().then((profile) {
      if (profile.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: profile.error)
            .show(screenState.context);
      } else if (profile.empty) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: S.current.profileDataEmpty)
            .show(screenState.context);
      } else {
        _profileSubject.add(profile.data);
      }
    });
  }

  void getMyOrders(CaptainOrdersScreenState screenState) {
    _stateSubject.add(CaptainOrdersListStateLoading(screenState));
    Future.wait([
      _ordersService.getCaptainOrders(),
      _ordersService.getNearbyOrders(),
    ]).then((List value) {
      if (value[0].hasError && value[1].hasError) {
        _stateSubject.add(CaptainOrdersListStateError(
            [value[0].error, value[1].error], screenState));
      } else {
        _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
            screenState, value[0], value[1]));
        initListening(screenState);
      }
    });
  }

  void initListening(CaptainOrdersScreenState screenState) {
    newActionSubscription =
        _ordersService.onInsertChangeWatcher().listen((event) {
      getProfile(screenState);
      Future.wait([
        _ordersService.getCaptainOrders(),
        _ordersService.getNearbyOrders(),
      ]).then((List value) {
        if (value[0].hasError && value[1].hasError) {
          _stateSubject.add(CaptainOrdersListStateError(
              [value[0].error, value[1].error], screenState));
        } else {
          _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
              screenState, value[0], value[1]));
        }
      });
    });
  }

  void companyInfo() {
    _ordersService.getCompanyInfo().then((info) => _companySubject.add(info!));
  }
}
