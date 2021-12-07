import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/model/user_favorite_model.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_tile.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class FavoriteLoadedState extends States {
  FavoritScreenState screenState;
  List<UserFavouriteCategoriesModel> userfav;
  List<StoreCategoryModel> categories;
  FavoriteLoadedState(this.screenState,
      {required this.userfav, required this.categories})
      : super(screenState) {
    categories.forEach((element) {
      favCatgories.add(UserFavouriteCategoriesModel(
          categoriesName: element.storeCategoryName,
          id: element.id,
          fav: userfav.any((u) => element.id == u.id)));
    });
  }
  List<UserFavouriteCategoriesModel> favCatgories = [];
  @override
  Widget getUI(BuildContext context) {
    return StackedForm(
      label: S.current.save,
      child: CustomListView.custom(
        children: getFavorite(),
      ),
      onTap: () {
        List<String> favorits = [];
        for (var element in favCatgories) {
          if (element.fav) {
            favorits.add(element.id.toString());
          }
        }
        screenState.updateCategories(FavoriteCategoriesRequest(
          favouriteCategories: favorits
        ));
      },
    );
  }

  List<Widget> getFavorite() {
    List<Widget> widgets = [];
    favCatgories.forEach((element) {
      widgets.add(CheckboxListTile(
        key: ValueKey(element.id),
        value: element.fav,
        onChanged: (value) {
          element.fav = value ?? false;
          screenState.refresh();
        },
        title: Text(
          element.categoriesName,
        ),
      ));
    });
    widgets.add(const SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
