import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class ClientsListProfileResponse {
  ClientsListProfileResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  ClientsListProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    try {} catch (e) {
      Logger().error('Client List Profile', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
  String? statusCode;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.clientID,
    this.clientName,
    this.phone,
    this.image,
    this.imageURL,
    this.location,
    this.baseURL,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    clientID = json['clientID'];
    clientName = json['clientName'];
    phone = json['phone'];
    image = json['image'];
    imageURL = json['imageURL'];
    location = json['location'];
    baseURL = json['baseURL'];
  }
  int? id;
  String? clientID;
  String? clientName;
  dynamic phone;
  String? image;
  dynamic imageURL;
  dynamic location;
  String? baseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['clientID'] = clientID;
    map['clientName'] = clientName;
    map['phone'] = phone;
    map['image'] = image;
    map['imageURL'] = imageURL;
    map['location'] = location;
    map['baseURL'] = baseURL;
    return map;
  }
}
