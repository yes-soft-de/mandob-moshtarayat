import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_main/widget/bottom_sheet.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/cart_screen.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/module_report/request/custom_product_request.dart';
import 'package:mandob_moshtarayat/module_report/service/report_service.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPage = 0;
  PageController homeController = PageController(initialPage: 0);
  bool flagPageIndex = true;
  final GlobalKey<ScaffoldState> bottomSheet = GlobalKey<ScaffoldState>();
  bool fade = false;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is int && flagPageIndex) {
      selectedPage = args;
      homeController = PageController(initialPage: args);
      flagPageIndex = false;
    }
    return WillPopScope(
      onWillPop: () async {
        if (fade) {
          fade = false;
          setState(() {});
        }
        return true;
      },
      child: Scaffold(
        key: bottomSheet,
        body: FixedContainer(
          child: SafeArea(
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
                Hider(
                    active: fade,
                    child: GestureDetector(
                      onTap: () {
                        if (fade) {
                          fade = false;
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      },
                      child: Container(
                        color: Colors.black38,
                      ),
                    )),
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
                          fade = true;
                          bottomSheet.currentState?.showBottomSheet(
                              (context) => OuterOrderBottomSheet(
                                    callback: (name, extraInfo, image) {
                                      Navigator.of(context).pop();
                                      fade = false;
                                      setState(() {});
                                      CustomFlushBarHelper.createSuccess(
                                              title: S.current.warnning,
                                              message: S.current.yourRequestSent,
                                              timeout: 1)
                                          .show(context);
                                      createCustomProduct(name, extraInfo, image);
                                    },
                                  ),
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ));
                          setState(() {});
                        },
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: AnimatedBottomNavigationBar(
                        inactiveColor: Theme.of(context).disabledColor,
                        activeColor: Theme.of(context).primaryColor,
                        gapLocation: GapLocation.center,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
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
        ),
      ),
    );
  }

  void createCustomProduct(name, extraInfo, image) {
    if (image == null) {
      getIt<ReportService>()
          .createCustomProduct(CustomProductRequest(
              productImage: image, detail: extraInfo, productName: name))
          .then((value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
              .show(context);
        } else {
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.successCreateOrder)
              .show(context);
        }
      });
    } else {
      getIt<ImageUploadService>().uploadImage(image).then((value) {
        if (value != null) {
          getIt<ReportService>()
              .createCustomProduct(CustomProductRequest(
                  productImage: image, detail: extraInfo, productName: name))
              .then((value) {
            if (value.hasError) {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning, message: value.error ?? '')
                  .show(context);
            } else {
              CustomFlushBarHelper.createSuccess(
                      title: S.current.warnning,
                      message: S.current.successCreateOrder)
                  .show(context);
            }
          });
        } else {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.errorUploadingImages)
              .show(context);
        }
      });
    }
  }
}
