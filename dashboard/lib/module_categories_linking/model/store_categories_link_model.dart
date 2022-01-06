import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/store_categories_linking_response/datum.dart';

class StoreCategoriesLinksModel extends DataModel {
  int id = -1;
  String categoryName = '';
  String image = '';
  String? imageUrl;
  String? baseImage;
  bool linked = false;
  List<StoreCategoriesLinksModel> _models = [];

  StoreCategoriesLinksModel.withData(List<Datum> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(StoreCategoriesLinksModel(
          id: element.id ?? -1,
          categoryName: element.storeCategoryName ?? S.current.storeCategories,
          image: element.image?.image ?? '',
          linked: element.linked ?? false));
    }
  }

  StoreCategoriesLinksModel(
      {required this.id,
      required this.categoryName,
      required this.image,
      this.baseImage,
      this.imageUrl,
      required this.linked});

  List<StoreCategoriesLinksModel> get data => _models;
}
