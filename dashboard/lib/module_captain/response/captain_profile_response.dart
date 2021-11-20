import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainProfileResponse({this.statusCode, this.msg, this.data});

  CaptainProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Captain Profile', e.toString(), StackTrace.current);
      statusCode = '-1';
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
  int? id;
  String? captainID;
  String? captainName;
  Location? location;
  int? age;
  String? car;
  String? drivingLicence;
  String? drivingLicenceURL;
  dynamic? salary;
  String? status;
  String? rating;
  dynamic? bounce;
  dynamic? roomID;
  String? image;
  String? imageURL;
  String? baseURL;
  String? phone;
  String? isOnline;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  dynamic? vacationStatus;
  String? mechanicLicense;
  String? identity;
  CreateDate? createDate;

  Data(
      {this.id,
      this.captainID,
      this.captainName,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.drivingLicenceURL,
      this.salary,
      this.status,
      this.rating,
      this.bounce,
      this.roomID,
      this.image,
      this.imageURL,
      this.baseURL,
      this.phone,
      this.isOnline,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.vacationStatus,
      this.mechanicLicense,
      this.identity,
      this.createDate});

  Data.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    age = json['age'];
    car = json['car'];
    drivingLicence = json['drivingLicence'];
    drivingLicenceURL = json['drivingLicenceURL'];
    salary = json['salary'];
    status = json['status'];
    rating = json['rating'];
    bounce = json['bounce'];
    roomID = json['roomID'];
    image = json['image'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    vacationStatus = json['vacationStatus'];
    mechanicLicense = json['mechanicLicense'];
    identity = json['identity'];
    createDate = json['createDate'] != null
        ? CreateDate.fromJson(json['createDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['age'] = age;
    map['car'] = car;
    map['drivingLicence'] = drivingLicence;
    map['drivingLicenceURL'] = drivingLicenceURL;
    map['salary'] = salary;
    map['status'] = status;
    map['bounce'] = bounce;
    map['roomID'] = roomID;
    map['image'] = image;
    map['imageURL'] = imageURL;
    map['baseURL'] = baseURL;
    map['phone'] = phone;
    map['isOnline'] = isOnline;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['vacationStatus'] = vacationStatus;
    map['mechanicLicense'] = mechanicLicense;
    map['identity'] = identity;
    return map;
  }
}

class Rating {
  dynamic? rate;

  Rating({this.rate});

  Rating.fromJson(dynamic json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['rate'] = rate;
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

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(dynamic json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ts'] = ts;
    map['time'] = time;
    map['offset'] = offset;
    map['isdst'] = isdst;
    map['abbr'] = abbr;
    return map;
  }
}

class CreateDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreateDate({this.timezone, this.offset, this.timestamp});

  CreateDate.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(dynamic json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = [];
      json['transitions'].forEach((v) {
        transitions?.add(Transitions.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    if (transitions != null) {
      map['transitions'] = transitions?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}
