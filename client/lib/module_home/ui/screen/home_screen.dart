import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_home/state_manager/home_state_manager.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/utils/global/global_state_manager.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _homeStateManager;

  const HomeScreen(this._homeStateManager);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeState? currentState;
  late AsyncSnapshot snapshot = const AsyncSnapshot.nothing();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getHomeData([bool loading = true]) async {
    if (getIt<AuthService>().isLoggedIn &&
        getIt<FavoriteHiveHelper>().getFavoriteCategory() != null) {
      widget._homeStateManager.getHomeFavoriteData(
          this, getIt<FavoriteHiveHelper>().getFavoriteCategory() ?? '-1');
    } else if (getIt<AuthService>().isLoggedIn &&
        getIt<FavoriteHiveHelper>().getFavoriteCategory() == null) {
      showDialog(
          context: context,
          builder: (_) {
            return getIt<FavouritScreen>();
          });
    } else {
      widget._homeStateManager.getHomeData(this, loading);
    }
  }

  void getCategories(catId, categories) async {
    widget._homeStateManager.getHomeFilterData(this, catId, categories);
  }

  void getProductsByStore(String storeID) {
    widget._homeStateManager.getProductsByStore(this, storeID);
  }

  void getProducts(catId) {
    widget._homeStateManager.getFilteredProducts(this, catId);
  }

  void getSubCategoriesProducts(catId) {
    widget._homeStateManager.getSubCategoriesProducts(this, catId);
  }

  void getMainCategoryProducts(catId) {
    widget._homeStateManager.getMainCategoryProducts(this, catId);
  }

  @override
  void initState() {
    currentState = HomeLoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (getIt<FavoriteHiveHelper>().getFavoriteCategory() == null &&
          getIt<AuthService>().isLoggedIn) {
        showDialog(
            context: context, builder: (context) => getIt<FavouritScreen>());
      }
    });
    if (getIt<FavoriteHiveHelper>().getFavoriteCategory() != null) {
      String catID =
          getIt<FavoriteHiveHelper>().getFavoriteCategory().toString();
      widget._homeStateManager.getHomeFavoriteData(this, catID);
      getMainCategoryProducts(catID);
    } else {
      widget._homeStateManager.getHomeData(this);
    }
    widget._homeStateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._homeStateManager.productsStream.listen((event) {
      snapshot = event;
      if (mounted) {
        setState(() {});
      }
    });
    Hive.box('Authorization')
        .listenable(keys: [getIt<FavoriteHiveHelper>().favKey]).addListener(() {
      String catID =
          getIt<FavoriteHiveHelper>().getFavoriteCategory().toString();
      widget._homeStateManager.getHomeFavoriteData(this, catID);
      getMainCategoryProducts(catID);
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: currentState?.getUI(context),
      ),
    );
  }
}
