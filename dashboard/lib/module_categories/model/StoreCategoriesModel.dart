import 'dart:math';

import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';

class StoreCategoriesModel extends DataModel {
  int id = -1;
  String categoryName = '';
  String categoryDescription = '';
  String image = '';
  String? imageUrl;
  String? baseImage;
  List<StoreCategoriesModel> _models = [];

  StoreCategoriesModel.withData(List<Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      if (element.image != null &&
          (element.image?.contains('original-image') ?? false) == false) {
        int f = Random().nextInt(1600);
        int s = Random().nextInt(900);
        element.image = 'https://source.unsplash.com/${f}x${s}/?store';
      }
      _models.add(StoreCategoriesModel(
        id: element.id ?? -1,
        categoryName: element.storeCategoryName ?? S.current.storeCategories,
        categoryDescription: element.description ?? '',
        image: element.image ?? '',
      ));
    }
  }

  StoreCategoriesModel(
      {required this.id,
      required this.categoryName,
      required this.categoryDescription,
      required this.image});

  List<StoreCategoriesModel> get data => _models;
}
