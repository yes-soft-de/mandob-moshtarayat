import 'created_at.dart';
import 'delivery_date.dart';
import 'destination.dart';

class Order {
  int? id;
  List<dynamic>? source;
  Destination? destination;
  DeliveryDate? deliveryDate;
  dynamic updatedAt;
  String? note;
  String? payment;
  String? recipientName;
  String? recipientPhone;
  String? state;
  String? roomId;
  int? captainId;
  CreatedAt? createdAt;
  String? detail;
  num? deliveryCost;
  num? orderCost;
  int? orderType;
  Order({
    this.id,
    this.source,
    this.destination,
    this.deliveryDate,
    this.updatedAt,
    this.note,
    this.payment,
    this.recipientName,
    this.recipientPhone,
    this.state,
    this.roomId,
    this.captainId,
    this.createdAt,
    this.detail,
    this.deliveryCost,
    this.orderCost,
    this.orderType,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      source: json['source'] as List<dynamic>?,
      destination: json['destination'] == null
          ? null
          : Destination.fromJson(json['destination'] as Map<String, dynamic>),
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DeliveryDate.fromJson(json['deliveryDate'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as dynamic?,
      note: json['note'] as String?,
      payment: json['payment'] as String?,
      recipientName: json['recipientName'] as String?,
      recipientPhone: json['recipientPhone'] as String?,
      state: json['state'] as String?,
      roomId: json['roomID'] as String?,
      captainId: json['captainID'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      detail: json['detail'] as String?,
      deliveryCost: json['deliveryCost'] as num?,
      orderCost: json['orderCost'] as num?,
      orderType: json['orderType'] as int?,
      
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'destination': destination?.toJson(),
        'deliveryDate': deliveryDate?.toJson(),
        'updatedAt': updatedAt,
        'note': note,
        'payment': payment,
        'recipientName': recipientName,
        'recipientPhone': recipientPhone,
        'state': state,
        'roomID': roomId,
        'captainID': captainId,
        'createdAt': createdAt?.toJson(),
        'detail': detail,
        'deliveryCost': deliveryCost,
        'orderCost': orderCost,
        'orderType': orderType,
      };
}
