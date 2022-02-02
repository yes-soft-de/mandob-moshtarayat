import 'order.dart';
import 'order_detail.dart';

class Data {
  Order? order;
  List<OrderDetail>? orderDetails;
  String? deliveryCost;
  String? rate;
  Data(
      {this.order,
      this.orderDetails,
      this.deliveryCost,
      this.rate,
      });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        orderDetails: (json['orderDetails'] as List<dynamic>?)
            ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        deliveryCost: json['deliveryCost'] as String?,
        rate: json['rate']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'order': order?.toJson(),
        'orderDetails': orderDetails?.map((e) => e.toJson()).toList(),
        'deliveryCost': deliveryCost,
        'rate': rate,
      };
}
