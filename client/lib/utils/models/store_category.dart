import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';

class StoreCategoryModel {
  late int id;
  late String storeCategoryName;
  late String description;
  late String image;
  String? error;
  bool empty = false;
  List<StoreCategoryModel> models = [];

  StoreCategoryModel(
      {required this.id,
      required this.storeCategoryName,
      required this.description,
      required this.image});

  StoreCategoryModel.Empty() {
    this.empty = true;
  }

  StoreCategoryModel.Data(StoreCategoriesResponse storeCategoriesResponse) {
    var data = storeCategoriesResponse.data;
    data!.forEach((element) {
      models.add(StoreCategoryModel(
          id: element.id ?? -1,
          storeCategoryName: element.storeCategoryName ?? S.current.category,
          description: element.description ?? '',
          image: element.image ?? ''));
    });
  }

  StoreCategoryModel.Error(this.error);

  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<StoreCategoryModel> get data {
    return models;
  }
}
