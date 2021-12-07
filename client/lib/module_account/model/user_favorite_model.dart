import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/response/favourite_categories_response/datum.dart';

class UserFavouriteCategoriesModel extends DataModel {
  late int id;
  late String categoriesName;
  late bool fav;

  UserFavouriteCategoriesModel(
      {required this.id, required this.categoriesName,required this.fav});

  List<UserFavouriteCategoriesModel> _categories = [];

  UserFavouriteCategoriesModel.withData(List<Datum> data) {
    for (var element in data) {
      _categories.add(UserFavouriteCategoriesModel(
        id: element.id ?? -1,
        categoriesName: element.storeCategoryName ?? S.current.unknown,
        fav: false
      ));
    }
  }

  List<UserFavouriteCategoriesModel> get data => _categories;
}
