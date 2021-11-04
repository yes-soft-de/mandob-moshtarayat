class PrivateOrderRequest {
  dynamic destination;
  String? note;
  String? payment;
  String? ownerID;
  String? detail;
  String? deliveryDate;
  int? storeOwnerProfileID;

  PrivateOrderRequest({
      this.destination, 
      this.note, 
      this.payment, 
      this.ownerID, 
      this.detail, 
      this.deliveryDate, 
      this.storeOwnerProfileID});

  PrivateOrderRequest.fromJson(dynamic json) {
    destination = json['destination'];
    note = json['note'];
    payment = json['payment'];
    ownerID = json['ownerID'];
    detail = json['detail'];
    deliveryDate = json['deliveryDate'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['destination'] = destination is String ? destination : destination.toJson();
    map['note'] = note;
    map['payment'] = payment;
    //map['ownerID'] = ownerID;
    map['detail'] = detail;
    map['deliveryDate'] = deliveryDate;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
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