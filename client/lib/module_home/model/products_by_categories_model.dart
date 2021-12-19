import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/products_by_categories_response.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductsByCategoriesModel extends DataModel {
  late int id;
  late String productName;
  late num productPrice;
  late int storeOwnerProfileID;
  late int storeProductCategoryID;
  late String image;
  late String discount;
  late num rate;
  late String soldCount;
  late String description;
  late String storeName;
  ProductsByCategoriesModel(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.storeOwnerProfileID,
      required this.storeProductCategoryID,
      required this.image,
      required this.description,
      required this.rate,
      required this.discount,
      required this.soldCount,
      required this.storeName});

  List<ProductsByCategoriesModel> _products = [];

  ProductsByCategoriesModel.withData(List<Data> data) {
    data.forEach((element) {
      _products.add(ProductsByCategoriesModel(
          id: element.id ?? -1,
          productName: element.productName ?? S.current.unknown,
          productPrice: element.productPrice ?? 0,
          storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
          storeProductCategoryID: element.storeProductCategoryID ?? -1,
          image: element.image?.image ?? ImageAsset.PLACEHOLDER,
          description: element.description ?? '',
          discount: element.discount ?? '0',
          rate: num.parse(element.rate ?? '0'),
          soldCount: element.soldCount ?? '0',
          storeName: element.store?.storeOwnerName ?? S.current.unknown));
    });
  }

  List<ProductsByCategoriesModel> get data => _products;
}
