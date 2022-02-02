//import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
//import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_categories.dart';

////import 'package:mandob_moshtarayat/module_home/response/products_by_categories_response.dart';
//import 'package:mandob_moshtarayat/utils/images/images.dart';
//
//class ProductsByCategoriesModel extends DataModel {
//  late int id;
//  late String productName;
//  late int productPrice;
//  late int storeOwnerProfileID;
//  late int storeProductCategoryID;
//  late String image;
//  late String discount;
//  late num rate;
//  late String soldCount;
//  late String description;
//
//  ProductsByCategoriesModel(
//      {required this.id,
//      required this.productName,
//      required this.productPrice,
//      required this.storeOwnerProfileID,
//      required this.storeProductCategoryID,
//      required this.image,
//      required this.description,
//      required this.rate,
//      required this.discount,
//      required this.soldCount});
//
//  List<ProductsByCategoriesModel> _products = [];
//
//  ProductsByCategoriesModel.withData(List<Data> data) {
//    data.forEach((element) {
//      _products.add(ProductsByCategoriesModel(
//          id: element.id ?? -1,
//          productName: element.productName ?? S.current.unknown,
//          productPrice: element.productPrice ?? 0,
//          storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
//          storeProductCategoryID: element.storeProductCategoryID ?? -1,
//          image: element.image?.image ?? ImageAsset.PLACEHOLDER,
//          description: element.description ?? '',
//          discount: element.discount ?? '0',
//          rate: num.parse(element.rate ?? '0'),
//          soldCount: element.soldCount ?? '0'
//      ));
//    });
//  }
//
//  List<ProductsByCategoriesModel> get data => _products;
//}

class StoreCategoryModel {
  late int id;
  late String storeCategoryName;
  late String image;
  String? error;
  bool empty = false;
  List<StoreCategoryModel> models = [];

  StoreCategoryModel(
      {required this.id,
        required this.storeCategoryName,
        required this.image});

  StoreCategoryModel.Empty() {
    this.empty = true;
  }

  StoreCategoryModel.Data(List<StoreCategoriesData>? storeCategoriesResponse) {
    var data = storeCategoriesResponse;
    data!.forEach((element) {
      models.add(StoreCategoryModel(
          id: element.id ?? -1,
          storeCategoryName: element.storeCategoryName ?? S.current.category,
          image: element.image?.image ?? ''));
    });
  }

  StoreCategoryModel.Error(this.error);

  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<StoreCategoryModel> get data {
    return models;
  }
}

class StoreModel {
  late int id;
  late String storeOwnerName;
  late String image;
  String? error;
  bool empty = false;
  List<StoreModel> models = [];
  StoreModel(
      {
        required this.id,
        required this.storeOwnerName,
        required this.image,

       });
  StoreModel.none();
  StoreModel.withData(data);

  StoreModel.Empty() {
    this.empty = true;
  }

  StoreModel.Error(this.error);

  StoreModel.Data(List<StoresData>? bestStores) {
    var data = bestStores;
    data!.forEach((element) {
      models.add(StoreModel(
          id: element.id ?? -1,
          storeOwnerName: element.storeOwnerName ?? S.current.store,

          image: element.image?.image ?? '',
      ));
    });
  }

  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<StoreModel> get data {
    return models;
  }
}