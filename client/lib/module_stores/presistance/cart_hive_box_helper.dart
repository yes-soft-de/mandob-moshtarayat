import 'dart:convert';

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
      List<Map> maps = [];
      cartModel.forEach((element) {
        maps.add(element.toJson(element));
      });
      box.put('cartJson', json.encode(maps));
    } else if (products is List<CartModel>) {
      box.put(cartKey, products);
      List<Map> maps = [];
      products.forEach((element) {
        maps.add(element.toJson(element));
      });
      box.put('cartJson', json.encode(maps));
    }
  }

  void addProductsToCart(CartModel model) {
    List<CartModel> cartModel = getCart();
    cartModel.removeWhere((element) => element.id == model.id);
    cartModel.add(model);
    setCart(cartModel);
  }

  void removeProductsToCart(CartModel model) {
    List<CartModel> cartModel = getCart();
    if (cartModel.isNotEmpty) {
      cartModel.removeWhere((element) => element.id == model.id);
    }
    setCart(cartModel);
  }

  void setFinish() {
    box.put('update', true);
  }

  void setStoreId(int id) {
    box.put('storeId', id);
  }

  List<CartModel> getCart() {
    dynamic dy = box.get(cartKey);
    List<CartModel> carts = [];
    if (dy is List<dynamic>) {
      List? js = json.decode(box.get('cartJson'));
      js?.forEach((element) {
        carts.add(CartModel.fromJson(element));
      });
      return carts;
    }
    return box.get(cartKey) ?? [];
  }

  List<Products>? getProduct() {
    List<CartModel>? cartModel = getCart();
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

  Future<void> deleteCart() async {
    await box.delete(cartKey);
    await box.delete('cartJson');
    await box.delete('storeId');
  }

  int getStoreID() {
    return box.get('storeId') ?? -1;
  }
}
