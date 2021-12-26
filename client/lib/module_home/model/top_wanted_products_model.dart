import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details_response.dart';

class TopWantedProductsModel {
  late String title;
  late String image;
  late double price;
  late int id;
  late int quantity;
  late int ownerId;
  late String storeName;
  late String storeImage;
  late String phone;
  late double deliveryCost;
  String? error;
  bool empty = false;
  List<TopWantedProductsModel> models = [];
  CostDetailsResponse? costDetails;
  TopWantedProductsModel(
      {required this.title,
      required this.image,
      required this.price,
      required this.id,
      this.quantity = 0,
      required this.ownerId,
      required this.storeName,
      required this.storeImage,
      required this.phone,
      required this.deliveryCost,
      required this.costDetails
      });

  TopWantedProductsModel.Empty() {
    this.empty = true;
  }
  TopWantedProductsModel.Error(this.error);

  TopWantedProductsModel.Data(ProductsResponse topProducts) {
    var data = topProducts.data;
    data!.forEach((element) {
      models.add(TopWantedProductsModel(
          title: element.productName ?? S.current.product,
          image: element.productImage ?? '',
          price: element.productPrice ?? 0,
          id: element.id ?? -1,
          ownerId: element.storeOwnerProfileID ?? -1,
          storeImage:
              'https://www.gannett-cdn.com/media/2020/03/23/USATODAY/usatsports/247WallSt.com-247WS-657876-imageforentry9-vp7.jpg?width=660&height=371&fit=crop&format=pjpg&auto=webp',
          storeName: element.storeOwnerName ?? S.current.storeOwner,
          phone: element.phone ?? '0',
          deliveryCost: element.deliveryCost ?? 0,
          costDetails: element.costDetails
          ));
    });
  }

  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<TopWantedProductsModel> get data {
    return models;
  }
}
