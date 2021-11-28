import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_captain/module_navigation/menu.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/company_info/company_info.dart';
import 'package:mandob_moshtarayat_captain/module_orders/state_manager/captain_orders/captain_orders.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:mandob_moshtarayat_captain/module_profile/model/profile_model/profile_model.dart';

@injectable
class CaptainOrdersScreen extends StatefulWidget {
  final CaptainOrdersListStateManager _stateManager;

  CaptainOrdersScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => CaptainOrdersScreenState();
}

class CaptainOrdersScreenState extends State<CaptainOrdersScreen> {
  CaptainOrdersListState? currentState;
  ProfileModel? _currentProfile;
  CompanyInfoResponse? _companyInfo;
  int currentPage = 0;
  PageController ordersPageController = PageController(initialPage: 0);
  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final advancedController = AdvancedDrawerController();

  void getMyOrders() {
    ordersPageController = PageController(initialPage: currentPage);
    widget._stateManager.getProfile(this);
    widget._stateManager.getMyOrders(this);
  }

  Future<void> refreshOrders() async {
    ordersPageController = PageController(initialPage: currentPage);
    widget._stateManager.getProfile(this);
    widget._stateManager.getMyOrders(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestAuthorization() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthorizationRoutes.LOGIN_SCREEN,
        (r) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    currentState = CaptainOrdersListStateLoading(this);
    widget._stateManager.getProfile(this);
    //widget._stateManager.companyInfo();
    widget._stateManager.getMyOrders(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _profileSubscription = widget._stateManager.profileStream.listen((event) {
      _currentProfile = event;
      if (mounted) {
        setState(() {});
      }
    });
    _companySubscription = widget._stateManager.companyStream.listen((event) {
      _companyInfo = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: AdvancedDrawer(
        controller: advancedController,
        rtlOpening: Localizations.localeOf(context).languageCode != 'en',
        childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        backdropColor: Theme.of(context).backgroundColor,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: currentState?.getUI(context)),
        drawer: MenuScreen(this, _currentProfile ?? ProfileModel.empty()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stateSubscription?.cancel();
    _profileSubscription?.cancel();
    _companySubscription?.cancel();
    widget._stateManager.newActionSubscription?.cancel();
  }
}
