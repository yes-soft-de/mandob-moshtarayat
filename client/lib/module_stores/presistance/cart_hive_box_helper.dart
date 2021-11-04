import 'package:hive_flutter/hive_flutter.dart';
import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';

class CartHiveHelper {
  var box = Hive.box('Order');
  String cartKey = 'cart';
  void setCart(dynamic products) {
    List<CartModel> cartModel = [];
    if (products is List<Products>) {
      products.forEach((element) {
        cartModel.add(CartModel(
            id: element.productID ?? -1,
            quantity: element.countProduct ?? 0,
            price: element.price ?? 0,
            name: element.productName,
            image: element.productsImage));
      });
      box.put(cartKey, cartModel);
    } else if (products is List<CartModel>) {
      box.put(cartKey, products);
    }
  }

  void setFinish() {
    box.put('finish', true);
  }

  List<CartModel>? getCart() {
    return box.get(cartKey);
  }

  List<Products>? getProduct() {
    List<CartModel>? cartModel = box.get(cartKey);
    if (cartModel == null) return null;
    List<Products> products = [];
    cartModel.forEach((element) {
      products.add(Products(
          productID: element.id,
          countProduct: element.quantity,
          price: element.price,
          productName: element.name,
          productsImage: element.image));
    });
    return products;
  }

  bool getFinish() {
    return box.get('finish') ?? false;
  }

  Future<void> deleteCart() async {
    await box.delete(cartKey);
    await box.delete('finish');
  }
}
