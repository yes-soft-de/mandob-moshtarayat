
import 'package:mandob_moshtarayat/module_stores/response/store_categories.dart';

import 'productsByCategoriesModel.dart';

class StoreAndCatModel {
  bool _empty = false;
  String errors = '';


  late List<StoreCategoryModel> storeCategory;
  late List<StoreModel>  storeModel;
  StoreAndCatModel? homeData;

  StoreAndCatModel(
      {
      required this.storeCategory,
      required this.storeModel});

  StoreAndCatModel.Empty() {
    _empty = true;
  }

  StoreAndCatModel.Error(String error) {
    errors = error;
  }

  bool get hasErrors => errors.isNotEmpty;

  StoreAndCatModel.Data(
      List<StoreModel> storeModel,
      List<StoreCategoryModel> storeCategoryModel) {
    homeData = StoreAndCatModel(
        storeCategory: storeCategoryModel,
        storeModel: storeModel);
  }

  bool get isEmpty => _empty;
  bool get hasData => homeData != null;
  StoreAndCatModel get data =>
      homeData ?? StoreAndCatModel(storeCategory: [],storeModel: []);
}
