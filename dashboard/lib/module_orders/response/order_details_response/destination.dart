class Destination {
  double? lat;
  double? long;

  Destination({this.lat, this.long});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        lat: (json['lat'] as num?)?.toDouble(),
        long: (json['long'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'long': long,
      };
}
