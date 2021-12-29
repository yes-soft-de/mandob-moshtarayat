import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_by_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_products.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details.dart';

class ProductModel {
  late String title;
  late String image;
  late num price;
  late int id;
  String? storeImage;
  String? storeName;
  num? deliveryCost;
  CostDetails? costDetails;
  int? quantity;
  ProductModel(
      {required this.title,
      required this.image,
      required this.price,
      required this.id,
      this.storeName,
      this.deliveryCost,
      this.storeImage,
      this.quantity = 0,
      this.costDetails});

  List<ProductModel> models = [];

  bool empty = false;

  ProductModel.Empty() {
    empty = true;
  }

  String? error;

  ProductModel.Error(this.error);

  ProductModel.Data(ProductsByCategory productsByCategory) {
    productsByCategory.data?.forEach((element) {
      models.add(ProductModel(
          title: element.productName ?? S.current.product,
          image: element.productImage?.image ?? '',
          price: element.productPrice ?? 0,
          id: element.id ?? -1,
          costDetails: element.costDetails));
    });
  }

  ProductModel.topWantedData(StoreProducts storeProducts) {
    storeProducts.data?.forEach((element) {
      models.add(ProductModel(
          title: element.productName ?? S.current.product,
          image: element.productImage?.image ??
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
          id: element.id ?? -1,
          price: element.productPrice ?? 0,
          costDetails: element.costDetails));
    });
  }

  bool get isEmpty => empty;

  bool get hasError => error != null;

  List<ProductModel> get data => models;
}
