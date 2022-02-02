import 'dart:collection';

import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/favorite_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class HomeModel {
  bool _empty = false;
  List<String> errors = [];

  late List<FavoriteCategoriesModel> favorite;
  late List<StoreCategoryModel> storeCategory;
  HomeModel? homeData;

  HomeModel({
    required this.favorite,
    required this.storeCategory,
  });

  HomeModel.Empty() {
    _empty = true;
  }

  HomeModel.Error(List<String> error) {
    errors = error;
  }

  bool get hasErrors => errors.isNotEmpty;

  HomeModel.Data(List<FavoriteCategoriesModel> favoriteModel,
      List<StoreCategoryModel> storeCategoryModel, List<String> homeErrors) {
    homeData = HomeModel(
      favorite: favoriteModel,
      storeCategory: storeCategoryModel,
    );
    errors = homeErrors;
  }
  List<FavoriteStore> getFullStores() {
    List<FavoriteStore> stores = [];
    favorite.forEach((cats) {
      for (var element in cats.stores) {
        if (stores.any((e) => e.storeId == element.storeId)) {
          continue;
        }
        stores.add(FavoriteStore(
            storeName: element.storeName,
            storeId: element.storeId,
            image: element.image));
      }
    });
    return stores;
  }

  bool get isEmpty => _empty;
  bool get hasData => homeData != null;
  HomeModel get data => homeData ?? HomeModel(favorite: [], storeCategory: []);
}
