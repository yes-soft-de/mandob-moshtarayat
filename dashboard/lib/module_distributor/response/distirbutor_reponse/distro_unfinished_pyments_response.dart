import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class DistroUnfinishedPaymentsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  DistroUnfinishedPaymentsResponse({this.statusCode, this.msg, this.data});

  DistroUnfinishedPaymentsResponse.fromJson(dynamic json) {
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
      Logger().error('Distro Payment List Response', e.toString(), StackTrace.current);
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
  int? id;
  String? mandobID;
  String? mandobName;
  String? roomID;
  Image? image;
  String? phone;
  num? remainingAmountForRepresentative;

  Data(
      {this.id,
      this.mandobID,
      this.mandobName,
      this.roomID,
      this.image,
      this.phone,
      this.remainingAmountForRepresentative});

  Data.fromJson(dynamic json) {
    id = json['id'];
    mandobID = json['mandobID'];
    mandobName = json['mandobName'];
    roomID = json['roomID'];
    image =Image.fromJson(json['image']);
    phone = json['phone'];
    remainingAmountForRepresentative = json['totalRemainingPaymentsToRepresentative'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['mandobID'] = mandobID;
    map['mandobName'] = mandobName;
    map['roomID'] = roomID;
    map['image'] = image;
    map['phone'] = phone;
    map['totalRemainingPaymentToRepresentative'] = remainingAmountForRepresentative;
    return map;
  }
}
