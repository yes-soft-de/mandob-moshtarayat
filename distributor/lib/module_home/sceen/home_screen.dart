import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/widget/menu_screen.dart';
import 'package:mandob_moshtarayat/module_my_code/my_code_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/utils/components/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'home_state/home_state_loaded.dart';



@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;

  HomeScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
 late States currentState;
  ProfileModel? _currentProfile;
//  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final advancedController = AdvancedDrawerController();

  void getMyOrders() {
//    ordersPageController = PageController(initialPage: currentPage);
//    widget._stateManager.getProfile(this);
//    widget._stateManager.getMyOrders(this);
  }

  Future<void> refreshOrders() async {
//    ordersPageController = PageController(initialPage: currentPage);
//    widget._stateManager.getProfile(this);
//    widget._stateManager.getMyOrders(this);
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
  void getReport(){
    widget._stateManager.getProfile(this);
  }

  @override
  void initState() {
    super.initState();
    currentState = HomeLoadingState(this);

//    widget._stateManager.getProfile(this);
    //widget._stateManager.companyInfo();

  widget._stateManager.stateStream.listen((event) {
    print('eventHere');
      print(event);
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
    widget._stateManager.getProfile(this);
  }
  Future<void> getHome() async {
    widget._stateManager.getProfile(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: CustomMandobAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.menu, onTap: () {
                advancedController.showDrawer();
          }),
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
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          ImageAsset.DELIVERY_CAR,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          height: 2000,
                        ))),
              ),
              currentState.getUI(context),
            ],
          ),
        ),
        drawer: MenuScreen(this, _currentProfile ?? ProfileModel.empty()),
      ),
      floatingActionButton:
      _currentProfile !=null?
      FloatingActionButton(onPressed: (){
        if(_currentProfile?.status =='inactive'){
          showDialog(
              context: context,
              builder: (_) {
                return CustomAlertNoAcDialog(onPressed: () {
                  Navigator.pop(context);
                },message: S.of(context).noScan,);
              });
        }
       else  Navigator.pushNamed(context, MyCodeRoutes.MyCode_SCREEN  , arguments: _currentProfile);
      },child: Icon(Icons.qr_code,size: 30,),elevation: 5.0,):Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileSubscription?.cancel();
  }
}
