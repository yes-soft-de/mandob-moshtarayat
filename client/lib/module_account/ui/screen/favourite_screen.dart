import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/state_manager/favorite_state_manager.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';

@injectable
class FavouritScreen extends StatefulWidget {
  final FavouriteStateManager _favouriteStateManager;

  const FavouritScreen(this._favouriteStateManager);

  @override
  FavoritScreenState createState() => FavoritScreenState();
}

class FavoritScreenState extends State<FavouritScreen> {
  States? currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._favouriteStateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._favouriteStateManager.getCategories(this);
    super.initState();
  }

  void updateCategories(FavoriteCategoriesRequest request) {
    widget._favouriteStateManager.updateFavoriteCategories(this, request);
  }

  bool canGoBack = getIt<AuthService>().isLoggedIn &&
      getIt<FavoriteHiveHelper>().getFavoriteCategory() != null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return canGoBack;
      },
      child: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          appBar: CustomTwaslnaAppBar.appBar(context,
              title: S.current.favoriteCategories, canGoBack: canGoBack),
          body: FixedContainer(
              child: currentState?.getUI(context) ?? const SizedBox()),
        ),
      ),
    );
  }
}
