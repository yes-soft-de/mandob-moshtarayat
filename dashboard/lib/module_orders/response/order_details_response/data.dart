import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/invoice.dart';

import 'order.dart';
import 'order_detail.dart';

class Data {
  Order? order;
  List<OrderDetail>? orderDetails;
  String? deliveryCost;
  String? rate;
  List<Invoice>? invoices;
  Data(
      {this.order,
      this.orderDetails,
      this.deliveryCost,
      this.rate,
      this.invoices});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        orderDetails: (json['orderDetails'] as List<dynamic>?)
            ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        deliveryCost: json['deliveryCost'] as String?,
        rate: json['rate']?.toString(),
        invoices: (json['Invoice'] as List<dynamic>?)
            ?.map((e) => Invoice.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'order': order?.toJson(),
        'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
        'deliveryCost': deliveryCost,
        'rate': rate,
      };
}
