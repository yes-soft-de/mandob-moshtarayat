class OrdersLogsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  OrdersLogsResponse({this.statusCode, this.msg, this.data});

  OrdersLogsResponse.fromJson(dynamic json) {
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
  int? orderNumber;
  CreatedAt? createdAt;
  String? completionTime;
  String? currentStage;

  Data(
      {this.id,
      this.orderNumber,
      this.createdAt,
      this.completionTime,
      this.currentStage});

  Data.fromJson(dynamic json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    createdAt = json['createdAt'] != null
        ? CreatedAt.fromJson(json['createdAt'])
        : null;
    completionTime = json['completionTime'];
    currentStage = json['currentStage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['orderNumber'] = orderNumber;
    if (createdAt != null) {
      map['createdAt'] = createdAt?.toJson();
    }
    map['completionTime'] = completionTime;
    return map;
  }
}

class CurrentStage {
  int? id;
  String? state;
  CreatedAt? createdAt;

  CurrentStage({this.id, this.state, this.createdAt});

  CurrentStage.fromJson(dynamic json) {
    id = json['id'];
    state = json['state'];
    createdAt = json['createdAt'] != null
        ? CreatedAt.fromJson(json['createdAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['state'] = state;
    if (createdAt != null) {
      map['createdAt'] = createdAt?.toJson();
    }
    return map;
  }
}

class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  CreatedAt.fromJson(dynamic json) {
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

class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(dynamic json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['country_code'] = countryCode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['comments'] = comments;
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
