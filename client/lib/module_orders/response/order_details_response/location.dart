class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({
    this.countryCode,
    this.latitude,
    this.longitude,
    this.comments,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        countryCode: json['country_code'] as String?,
        latitude: json['latitude'] as int?,
        longitude: json['longitude'] as int?,
        comments: json['comments'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'latitude': latitude,
        'longitude': longitude,
        'comments': comments,
      };
}
