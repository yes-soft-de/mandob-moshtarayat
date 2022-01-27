import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_products/response/cart_response/data.dart';

class CartValidationModel extends DataModel {
  late bool attention;
  CartValidationModel({required this.attention});
  CartValidationModel.withData(Data data) {
    List<CartModel> carts = [];
    data.products?.forEach((element) {
      carts.add(CartModel(
        id: element.id ?? -1,
        quantity: (element.maxQuantity! > element.userQuantity!)
            ? element.userQuantity ?? -1
            : element.maxQuantity ?? -1,
        price: element.productPrice ?? 0,
        storeID: element.storeOwnerProfileId?.toString() ?? '-1',
        name: element.productName,
        image: element.productImage,
      ));
    });
    attention = data.attention ?? false;
  }
  bool get notify => attention;
}
