import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_home/model/report_model.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/widget/drawer.dart';
import 'package:mandob_moshtarayat/module_main/ui/screen/main_screen.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

import 'home_state/home_state_loaded.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;

  HomeScreen(this._stateManager);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StoreProfileModel model = StoreProfileModel(id: 0,
      storeOwnerName: 'storeOwnerName', phone: '323230',
      deliveryCost: 0, image: '', privateOrders: true,
      hasProducts: true, categoryId: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandopAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.menu,colorIcon: AppThemeDataService.PrimaryDarker, onTap: () {
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
        drawer: MenuScreen(model),
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
    ReportModel model =ReportModel(countOngoingOrders: 5,countCaptains: 5,countClients: 8,countCompletedOrders: 3,countProducts: 6,countStores: 2);
    state = HomeLoadedState(this,model);
    widget._stateManager.stateStream.listen((event) {
      state = event;
     if (this.mounted){
       setState(() {
       });
     }
    });
    // getReport();
    super.initState();
  }

  void getReport() {
    widget._stateManager.getReport(this);
  }
}
