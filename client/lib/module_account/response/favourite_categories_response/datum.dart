class Datum {
  int? id;
  String? storeCategoryName;

  Datum({this.id, this.storeCategoryName});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        storeCategoryName: json['storeCategoryName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeCategoryName': storeCategoryName,
      };
}
