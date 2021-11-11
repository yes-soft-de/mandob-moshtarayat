import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import '../../../global_nav_key.dart';

@injectable
class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  // int selectedPage = 0;
  // PageController homeController = PageController(initialPage: 0);
  // bool flagPageIndex = true;
   static var advancedController = AdvancedDrawerController();
  int _currentIndex = 0;
  final List<Widget> _widgetList = [
      getIt<HomeScreen>(),
    getIt<OnGoingOrdersScreen>(),
    Container(child: Text('fdf'),),
  ];
  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)?.settings.arguments;
    // if (args is int && flagPageIndex) {
    //   selectedPage = args;
    //   homeController = PageController(initialPage: args);
    //   flagPageIndex = false;
    // }
    return Scaffold(

      bottomNavigationBar:BottomNavigationBar(
        iconSize: 30,
        // showSelectedLabels: true,
        backgroundColor: StyleText.geyApp,
        // type: BottomNavigationBarType.fixed,
        // unselectedItemColor: Colors.grey,
        onTap: onTapped,
        currentIndex: _currentIndex,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
              label: S.of(context).home),
          BottomNavigationBarItem(
              label: S.of(context).order,
              icon:Image.asset(ImageAsset.ORDER,height: 30) ),
          BottomNavigationBarItem(
              icon:Image.asset(ImageAsset.PRODUCT,height: 30,),
              label: S.of(context).product),
        ],
      ),
      body:Container(
          // decoration: BoxDecoration(
          //   color:  Theme.of(context).scaffoldBackgroundColor,
          // ),
          child: Center(child: _widgetList[_currentIndex]),),
    );
  }
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
