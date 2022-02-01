import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/response/products_similer_response/datum.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details_response.dart';

class ProductsSimilarModel extends DataModel {
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
  CostDetailsResponse? costDetails;
  ProductsSimilarModel(
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
      required this.storeName,
      required this.costDetails});

  List<ProductsSimilarModel> _products = [];

  ProductsSimilarModel.withData(List<Datum> data) {
    data.forEach((element) {
      _products.add(ProductsSimilarModel(
          id: element.id ?? -1,
          productName: element.productName ?? S.current.unknown,
          productPrice: element.productPrice ?? 0,
          storeOwnerProfileID: element.store?.id ?? -1,
          storeProductCategoryID: element.storeProductCategoryId ?? -1,
          image: element.image?.image ?? ImageAsset.PLACEHOLDER,
          description: element.description ?? '',
          discount: element.discount?.toString() ?? '0',
          rate: num.parse(element.rate ?? '0'),
          soldCount: element.soldCount ?? '0',
          storeName: element.store?.storeOwnerName ?? S.current.unknown,
          costDetails: element.costDetails));
    });
  }

  List<ProductsSimilarModel> get data => _products;
}
