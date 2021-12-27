import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/widget/drawer.dart';
import 'package:mandob_moshtarayat/module_main/ui/screen/main_screen.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/response/store_profile_response.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

import 'home_state/home_state_loaded.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;
  final AuthService _authService;
  HomeScreen(this._stateManager, this._authService);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandopAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.menu, onTap: () {
            MainScreenState.advancedController.showDrawer();
          }),
      body: AdvancedDrawer(
        controller: MainScreenState.advancedController,
        rtlOpening:Localizations.localeOf(context).languageCode != 'en' ,
        childDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
        ),
        child: Container(
            decoration: BoxDecoration(
              color:  Theme.of(context).scaffoldBackgroundColor,
            ),
            child:  Stack(
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
                state.getUI(context)
              ],
            ),),
        drawer: MenuScreen(widget._authService.isLoggedIn),
      ),
    );
  }

  late States state;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    state = HomeLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      state = event;
     if (this.mounted){
       setState(() {
       });
     }
    });
    getReport();
    super.initState();
  }

  Future<void> getReport() async {
    widget._stateManager.getReport(this);
  }
}
