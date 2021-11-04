import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_category.dart';

class CategoryModel {
  late int id;
  late String label;
  List<CategoryModel> models = [];
  CategoryModel({required this.id, required this.label});
  bool empty = false;
  CategoryModel.Empty() {
    empty = true;
  }
  String? error;
  CategoryModel.Error(this.error);
  CategoryModel.Data(ProductsCategory category) {
    category.data?.forEach((element) {
      models.add(CategoryModel(
          id: element.id ?? -1,
          label: element.productCategoryName ?? S.current.categories));
    });
  }
  bool get isEmpty => empty;
  bool get hasError => error != null;
  List<CategoryModel> get data => models;
}
