import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/widget/drawer.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/customIcon/custom_icons.dart';
import 'package:share/share.dart';

import '../../../global_nav_key.dart';

@injectable
class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedPage = 0;
  PageController homeController = PageController(initialPage: 0);
  bool flagPageIndex = true;
   static var advancedController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)?.settings.arguments;
    // if (args is int && flagPageIndex) {
    //   selectedPage = args;
    //   homeController = PageController(initialPage: args);
    //   flagPageIndex = false;
    // }
    return Scaffold(

      body:Container(
          decoration: BoxDecoration(
            color:  Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Stack(
            children: [
              PageView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: homeController,
                onPageChanged: (index) {
                  selectedPage = index;
                  setState(() {});
                  homeController.animateToPage(index,
                      duration: Duration(milliseconds: 15), curve: Curves.linear);
                },
                children: [

                  getIt<HomeScreen>(),
                  getIt<OnGoingOrdersScreen>(),
                  // getIt<MyOrdersScreen>(),
                  // getIt<MyNotificationsScreen>(),
                  // getIt<AccountScreen>()
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  child: Scaffold(
                    backgroundColor: Colors.transparent.withOpacity(0.0),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onPressed: () {
                        // Share.share('${S.current.downloadTwaslnaApp} https://play.google.com/store/apps/details?id=de.yes_soft.twaslna');
                      },
                    ),
                    floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: AnimatedBottomNavigationBar(
                      inactiveColor: Theme.of(context).disabledColor,
                      activeColor: Theme.of(context).primaryColor,
                      gapLocation: GapLocation.center,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      notchSmoothness: NotchSmoothness.defaultEdge,
                      icons: [
                        Icons.home,
                        // Icons.list,
                        // Icons.notifications,
                        Icons.insert_invitation_outlined
                      ],
                      onTap: (int index) {
                        selectedPage = index;
                        homeController.animateToPage(index,
                            duration: Duration(milliseconds: 15),
                            curve: Curves.linear);
                      },
                      activeIndex: selectedPage,
                    ),
                  ),
                ),
              ),
            ],
          ),),
    );
  }
}
