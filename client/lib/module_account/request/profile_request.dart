class ProfileRequest {
  String? clientName;
  String? image;
  String? location;

  ProfileRequest({
      this.clientName, 
      this.image, 
      this.location});

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
    return map;
  }

}