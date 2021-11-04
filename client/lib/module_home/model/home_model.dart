import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class HomeModel {
  bool _empty = false;
  List<String> errors = [];

  late List<TopWantedProductsModel> topWanted;
  late List<StoreCategoryModel> storeCategory;
  late List<StoreModel> storeModel;
  HomeModel? homeData;

  HomeModel(
      {required this.topWanted,
      required this.storeCategory,
      required this.storeModel});

  HomeModel.Empty() {
    _empty = true;
  }

  HomeModel.Error(List<String> error) {
    errors = error;
  }

  bool get hasErrors => errors.isNotEmpty;

  HomeModel.Data(
      List<TopWantedProductsModel> topWantedProductsModel,
      List<StoreModel> storeModel,
      List<StoreCategoryModel> storeCategoryModel,
      List<String> homeErrors) {
    homeData = HomeModel(
        topWanted: topWantedProductsModel,
        storeCategory: storeCategoryModel,
        storeModel: storeModel);
    errors = homeErrors;
  }

  bool get isEmpty => _empty;
  bool get hasData => homeData != null;
  HomeModel get data =>
      homeData ?? HomeModel(topWanted: [], storeCategory: [], storeModel: []);
}
