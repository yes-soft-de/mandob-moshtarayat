import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class FinancialCompensationsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  FinancialCompensationsResponse({this.statusCode, this.msg, this.data});

  FinancialCompensationsResponse.fromJson(dynamic json) {
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
      Logger().error('Fniance', e.toString(), StackTrace.current);
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
  int? kilometers;
  int? maxKilometerBonus;
  int? minKilometerBonus;

  Data(
      {this.id,
      this.kilometers,
      this.maxKilometerBonus,
      this.minKilometerBonus});

  Data.fromJson(dynamic json) {
    id = json['id'];
    kilometers = json['kilometers'];
    maxKilometerBonus = json['maxKilometerBonus'];
    minKilometerBonus = json['minKilometerBonus'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['kilometers'] = kilometers;
    map['maxKilometerBonus'] = maxKilometerBonus;
    map['minKilometerBonus'] = minKilometerBonus;
    return map;
  }
}
