
import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ReportResponse {
  String? statusCode;
  String? msg;
  Data? data;

  ReportResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  ReportResponse.fromJson(dynamic json) {
  try{
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  catch (e){
    statusCode = '-1';
    Logger().error('Report Response', e.toString(), StackTrace.current);
  }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  String? countCompletedOrders;
  String? countOngoingOrders;
  String? countCaptains;
  String? countClients;
  String? countStores;
  String? countProducts;
  String? countOrdersInToday;

  Data({
      this.countCompletedOrders, 
      this.countOngoingOrders, 
      this.countCaptains, 
      this.countClients, 
      this.countStores, 
      this.countProducts, 
      this.countOrdersInToday});

  Data.fromJson(dynamic json) {
    countCompletedOrders = json['countCompletedOrders'];
    countOngoingOrders = json['countOngoingOrders'];
    countCaptains = json['countCaptains'];
    countClients = json['countClients'];
    countStores = json['countStores'];
    countProducts = json['countProducts'];
    countOrdersInToday = json['countOrdersInToday'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['countCompletedOrders'] = countCompletedOrders;
    map['countOngoingOrders'] = countOngoingOrders;
    map['countCaptains'] = countCaptains;
    map['countClients'] = countClients;
    map['countStores'] = countStores;
    map['countProducts'] = countProducts;
    map['countOrdersInToday'] = countOrdersInToday;
    return map;
  }

}