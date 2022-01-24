class AcceptDistroRequest {
  String? distroID;
  String? status;
  AcceptDistroRequest({this.distroID,  this.status,  });

  AcceptDistroRequest.fromJson(dynamic json) {
    distroID = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = distroID;
    map['status'] = status;
    return map;
  }
}
