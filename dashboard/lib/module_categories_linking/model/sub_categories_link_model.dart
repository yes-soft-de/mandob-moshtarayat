import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/sub_categories_linking_response/datum.dart';

class SubCategoriesLinksModel extends DataModel {
  int id = -1;
  String categoryName = '';
  String image = '';
  String? imageUrl;
  String? baseImage;
  bool linked = false;
  List<SubCategoriesLinksModel> _models = [];

  SubCategoriesLinksModel.withData(List<Datum> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(SubCategoriesLinksModel(
          id: element.id ?? -1,
          categoryName:
              element.productCategoryName ?? S.current.storeCategories,
          image: element.productCategoryImage?.image ?? '',
          linked: element.linked ?? false));
    }
  }

  SubCategoriesLinksModel(
      {required this.id,
      required this.categoryName,
      required this.image,
      this.baseImage,
      this.imageUrl,
      required this.linked});

  List<SubCategoriesLinksModel> get data => _models;
}
