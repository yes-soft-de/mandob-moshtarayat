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
      _models.add(StoreCategoriesModel(
        id: element.id ?? -1,
        categoryName: element.storeCategoryName ?? S.current.storeCategories,
        categoryDescription: element.description ?? '',
        image: element.image?.image ?? '',
        baseImage:element.image?.baseURL,
        imageUrl:element.image?.imageURL,
      ));
    }
  }

  StoreCategoriesModel(
      {required this.id,
      required this.categoryName,
      required this.categoryDescription,
      required this.image,this.baseImage,this.imageUrl});

  List<StoreCategoriesModel> get data => _models;
}
