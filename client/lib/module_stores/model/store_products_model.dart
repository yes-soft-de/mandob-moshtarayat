import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/model/category_model.dart';
import 'package:mandob_moshtarayat/utils/models/product.dart';

class StoreProductsData {
  bool _empty = false;
  List<String> errors = [];

  late List<ProductModel> topWanted;
  late List<CategoryModel> storeCategories;
  StoreProductsData? storeData;

  StoreProductsData({
    required this.topWanted,
    required this.storeCategories,
  });

  StoreProductsData.Empty() {
    _empty = true;
  }

  StoreProductsData.Error(List<String> error) {
    errors = error;
  }

  bool get hasErrors => errors.isNotEmpty;

  StoreProductsData.Data(List<ProductModel> topWantedProductsModel,
      List<CategoryModel> storeCategories, List<String> homeErrors) {
    storeData = StoreProductsData(
        topWanted: topWantedProductsModel, storeCategories: storeCategories);
    errors = homeErrors;
  }

  bool get isEmpty => _empty;
  bool get hasData => storeData != null;
  StoreProductsData get data =>
      storeData ?? StoreProductsData(topWanted: [], storeCategories: []);
}
