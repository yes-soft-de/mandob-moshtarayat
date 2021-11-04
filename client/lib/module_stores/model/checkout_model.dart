import 'package:mandob_moshtarayat/hive/objects/cart_model/cart_model.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';

class CheckoutModel {
  int? ownerId;
  List<Products>? cart;
  double? orderCost;
  num? deliveryCost;

  CheckoutModel({this.ownerId, this.cart, this.orderCost, this.deliveryCost});
}
