import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/cart_screen.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';

@injectable
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPage = 0;
  PageController homeController = PageController(initialPage: 0);
  bool flagPageIndex = true;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is int && flagPageIndex) {
      selectedPage = args;
      homeController = PageController(initialPage: args);
      flagPageIndex = false;
    }
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: homeController,
              onPageChanged: (index) {
                selectedPage = index;
                setState(() {});
                homeController.animateToPage(index,
                    duration: const Duration(milliseconds: 15),
                    curve: Curves.linear);
              },
              children: [
                getIt<HomeScreen>(),
                getIt<MyOrdersScreen>(),
                getIt<CartScreen>(),
                getIt<AccountScreen>()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 65,
                child: Scaffold(
                  backgroundColor: Colors.transparent.withOpacity(0.0),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      MandobIcons.logo,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ServicesRoutes.SEND_IT);
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
                    icons: const [
                      Icons.home,
                      Icons.list,
                      Icons.shopping_cart_rounded,
                      Icons.person_pin
                    ],
                    onTap: (int index) {
                      selectedPage = index;
                      homeController.animateToPage(index,
                          duration: const Duration(milliseconds: 15),
                          curve: Curves.linear);
                    },
                    activeIndex: selectedPage,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
