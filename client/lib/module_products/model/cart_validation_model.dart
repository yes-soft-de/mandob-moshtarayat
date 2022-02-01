import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_products/response/cart_response/data.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';

class CartValidationModel extends DataModel {
  late bool attention;
  CartValidationModel({required this.attention});
  CartValidationModel.withData(Data data) {
    List<CartModel> carts = [];
    data.products?.forEach((element) {
      var max = element.maxQuantity ?? 0;
      carts.add(CartModel(
        id: element.id ?? -1,
        quantity: (max > (element.userQuantity ?? 0))
            ? element.userQuantity ?? 0
            : max,
        price: element.productPrice ?? 0,
        storeID: element.storeOwnerProfileId?.toString() ?? '-1',
        name: element.productName,
        image: element.productImage,
      ));
    });
    CartHiveHelper().setCart(carts);
    attention = data.attention ?? false;
  }
  bool get notify => attention;
}
