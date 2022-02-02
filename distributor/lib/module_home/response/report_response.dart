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



}

class Data {
  int? totalLinkedStores;
  int? representativeTotalLinkedStores;
  int? representativeLinkedStoresLastMonth;

  Data({
      this.totalLinkedStores,
      this.representativeTotalLinkedStores,
      this.representativeLinkedStoresLastMonth});

  Data.fromJson(dynamic json) {
    totalLinkedStores = json['totalLinkedStores'];
    representativeTotalLinkedStores = json['representativeTotalLinkedStores'];
    representativeLinkedStoresLastMonth = json['representativeLinkedStoresLastMonth'];
  }


}