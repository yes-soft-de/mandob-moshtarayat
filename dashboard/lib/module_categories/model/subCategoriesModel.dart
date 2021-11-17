import 'dart:math';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';

class SubCategoriesModel extends DataModel {
  int id = -1;
  String categoryName = '';
  String image = '';
  String? imageUrl;
  String? baseImage;
  List<SubCategoriesModel> _models = [];

  SubCategoriesModel.withData(List<Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(SubCategoriesModel(
        id: element.id ?? -1,
        categoryName: element.productCategoryName ?? S.current.storeCategories,
        image: element.productCategoryImage?.image ?? '',
      ));
    }
  }

  SubCategoriesModel(
      {required this.id,
        required this.categoryName,
        required this.image});

  List<SubCategoriesModel> get data => _models;
}
