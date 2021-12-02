import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/datum.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/store.dart';

class FavoriteCategoriesModel extends DataModel {
  late int id;
  late String categoriesName;
  late List<FavoriteStore> stores;

  FavoriteCategoriesModel(
      {required this.id, required this.stores, required this.categoriesName});

  List<FavoriteCategoriesModel> _products = [];

  FavoriteCategoriesModel.withData(List<Datum> data) {
    for (var element in data) {
      _products.add(FavoriteCategoriesModel(
        id: element.id ?? -1,
        categoriesName: element.storeCategoryName ?? S.current.unknown,
        stores: _getStores(element.stores ?? []),
      ));
    }
  }

  List<FavoriteStore> _getStores(List<Store> strs) {
    List<FavoriteStore> stores = [];
    strs.forEach((element) {
      stores.add(FavoriteStore(
          image: element.image?.image ?? '',
          storeId: element.id ?? -1,
          storeName: element.storeOwnerName ?? S.current.unknown));
    });
    return stores;
  }

  List<FavoriteCategoriesModel> get data => _products;
}

class FavoriteStore {
  final String storeName;
  final int storeId;
  final String image;

  FavoriteStore({
    required this.storeName,
    required this.storeId,
    required this.image,
  });
}
