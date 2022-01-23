class Datum {
  int? id;
  String? clientName;
  String? roomId;
  String? image;
  String? clientID;
  Datum({this.id, this.clientID ,this.clientName, this.roomId, this.image});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        clientID: json['clientID'] as String?,
        clientName: json['clientName'] as String?,
        roomId: json['roomID'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientName': clientName,
        'roomID': roomId,
        'image': image,
      };
}
