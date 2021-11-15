import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class InActiveCaptainResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  InActiveCaptainResponse({this.statusCode, this.msg, this.data});

  InActiveCaptainResponse.fromJson(dynamic json) {
    try {} catch (e) {
      statusCode = '-1';
      Logger()
          .error('InActiveCaptainResponse', e.toString(), StackTrace.current);
    }
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
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
  String? captainID;
  String? captainName;
  String? image;
  Location? location;
  String? age;
  String? car;
  String? drivingLicence;
  num? salary;
  String? status;
  dynamic state;
  num? bounce;
  String? roomID;
  dynamic specialLink;
  String? phone;
  dynamic isOnline;
  dynamic newMessageStatus;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? mechanicLicense;
  String? identity;

  Data(
      {this.id,
      this.captainID,
      this.captainName,
      this.image,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.salary,
      this.status,
      this.state,
      this.bounce,
      this.roomID,
      this.specialLink,
      this.phone,
      this.isOnline,
      this.newMessageStatus,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.mechanicLicense,
      this.identity});

  Data.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    image = json['image'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    age = json['age']?.toString();
    car = json['car'];
    drivingLicence = json['drivingLicence'];
    salary = json['salary'];
    status = json['status'];
    state = json['state'];
    bounce = json['bounce'];
    roomID = json['roomID'];
    specialLink = json['specialLink'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    newMessageStatus = json['newMessageStatus'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    mechanicLicense = json['mechanicLicense'];
    identity = json['identity'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['image'] = image;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['age'] = age;
    map['car'] = car;
    map['drivingLicence'] = drivingLicence;
    map['salary'] = salary;
    map['status'] = status;
    map['state'] = state;
    map['bounce'] = bounce;
    map['roomID'] = roomID;
    map['specialLink'] = specialLink;
    map['phone'] = phone;
    map['isOnline'] = isOnline;
    map['newMessageStatus'] = newMessageStatus;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['mechanicLicense'] = mechanicLicense;
    map['identity'] = identity;
    return map;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }
}
