import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/widget/drawer.dart';
import 'package:mandob_moshtarayat/module_main/ui/screen/main_screen.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/response/store_profile_response.dart';
import 'package:mandob_moshtarayat/module_stores/state_manager/stores_state_manager.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_loading_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_loaded_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_loading_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/global/screen_type.dart';

@injectable
class StoresScreen extends StatefulWidget {
  final StoresStateManager _homeStateManager;
  final AuthService _authService;

  StoresScreen(this._homeStateManager, this._authService);

  @override
  StoresScreenState createState() => StoresScreenState();
}

class StoresScreenState extends State<StoresScreen> {
  StoresState? currentState;
//  late AsyncSnapshot snapshot = AsyncSnapshot.nothing();
//  StoreProfileModel model = StoreProfileModel(id: 0,
//      storeOwnerName: 'storeOwnerName', phone: '323230',
//      deliveryCost: 0, image: ImageUrl(image: ''), privateOrders: true,
//      storeCategoryName: '',
//      hasProducts: true, storeCategoryId: -1);
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void getStoreAndCat() {
    widget._homeStateManager.getStoreAndCat(this);
  }

//  void getCategories(catId,categories) async {
//    widget._homeStateManager.getHomeFilterData(this,catId,categories);
//  }
//  void getProducts(catId)  {
//    widget._homeStateManager.getFilteredProducts(this,catId);
//  }
//  void getSubCategoriesProducts(catId)  {
//    widget._homeStateManager.getSubCategoriesProducts(this,catId);
//  }
//  void getMainCategoryProducts(catId)  {
//    widget._homeStateManager.getMainCategoryProducts(this,catId);
//  }

  @override
  void initState() {
    currentState = StoresLoadingState(this);
    widget._homeStateManager.getStoreAndCat(this);
    widget._homeStateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
//    widget._homeStateManager.productsStream.listen((event) {
//      snapshot = event;
//      if (mounted) {
//        setState(() {});
//      }
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ScreenType.isDesktop()) {
      if (widget._authService.isLoggedIn) {
        return Scaffold(
          appBar: CustomMandopAppBar.appBar(context,
              title: S.of(context).anotherStore,
              icon: Icons.arrow_back, onTap: () {
            Navigator.pop(context);
          }),
          body:
              FixedContainer(child: currentState?.getUI(context) ?? SizedBox()),
        );
      }
      return Scaffold(
          appBar: CustomMandopAppBar.appBar(context,
              title: S.of(context).home, icon: Icons.menu, onTap: () {
            MainScreenState.advancedController.showDrawer();
          }),
          body: Row(
            children: [
              SizedBox(
                  width: 400,
                  child: MenuScreen(widget._authService.isLoggedIn)),
              Expanded(child: currentState!.getUI(context)),
            ],
          ));
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: widget._authService.isLoggedIn
          ? Scaffold(
              appBar: CustomMandopAppBar.appBar(context,
                  title: S.of(context).anotherStore,
                  icon: Icons.arrow_back, onTap: () {
                Navigator.pop(context);
              }),
              body: FixedContainer(
                  child: currentState?.getUI(context) ?? SizedBox()),
            )
          : Scaffold(
              appBar: CustomMandopAppBar.appBar(context,
                  title: S.of(context).home, icon: Icons.menu, onTap: () {
                MainScreenState.advancedController.showDrawer();
              }),
              body: AdvancedDrawer(
                controller: MainScreenState.advancedController,
                rtlOpening:
                    Localizations.localeOf(context).languageCode != 'en',
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: currentState?.getUI(context)),
                childDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18)),
                drawer: MenuScreen(widget._authService.isLoggedIn),
              ),
            ),
    );
  }
}
