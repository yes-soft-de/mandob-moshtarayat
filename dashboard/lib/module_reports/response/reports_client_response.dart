import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class ReportsClientResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ReportsClientResponse({this.statusCode, this.msg, this.data});

  ReportsClientResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    } catch (e) {
      Logger()
          .error('Reports Client Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  String? clientID;
  int? countOrdersInMonth;
  String? clientName;
  String? image;

  Data({this.clientID, this.countOrdersInMonth, this.clientName, this.image});

  Data.fromJson(dynamic json) {
    clientID = json['clientID'];
    countOrdersInMonth = json['countOrdersInMonth'];
    clientName = json['clientName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['clientID'] = clientID;
    map['countOrdersInMonth'] = countOrdersInMonth;
    map['clientName'] = clientName;
    map['image'] = image;
    return map;
  }
}
