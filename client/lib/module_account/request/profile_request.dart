class ProfileRequest {
  String? clientName;
  String? image;
  String? location;
  String? nationalAddress;
  String? recordNumber;
  String? taxNumber;

  ProfileRequest({this.clientName, this.image, this.location,this.nationalAddress,this.recordNumber,this.taxNumber});

  ProfileRequest.fromJson(dynamic json) {
    clientName = json['clientName'];
    image = json['image'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['clientName'] = clientName;
    map['image'] = image;
    map['location'] = location;
    map['nationalAddress'] = nationalAddress;
    map['recordNumber'] = recordNumber;
    map['taxNumber'] = taxNumber;
    return map;
  }
}
