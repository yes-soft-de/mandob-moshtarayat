class SendItRequest {
  dynamic destination;
  String? note;
  String? payment;
  dynamic source;
  String? deliveryDate;
  String? recipientName;
  String? recipientPhone;
  String? detail;

  SendItRequest({
      this.destination, 
      this.note, 
      this.payment, 
      this.source, 
      this.deliveryDate, 
      this.recipientName, 
      this.recipientPhone, 
      this.detail});

  SendItRequest.fromJson(dynamic json) {
    destination = json['destination'];
    note = json['note'];
    payment = json['payment'];
    source = json['source'];
    deliveryDate = json['deliveryDate'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['destination'] = destination is String ? destination : destination.toJson();
    map['note'] = note;
    map['payment'] = payment;
    map['source'] = source;
    map['deliveryDate'] = deliveryDate;
    map['recipientName'] = recipientName;
    map['recipientPhone'] = recipientPhone;
    map['detail'] = detail;
    return map;
  }

}
class GeoJson {
  double? long;
  double? lat;

  GeoJson({this.long, this.lat});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['long'] = long;
    map['lat'] = lat;
    return map;
  }
}