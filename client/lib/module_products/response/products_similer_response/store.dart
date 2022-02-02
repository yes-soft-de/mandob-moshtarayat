class Store {
  int? id;
  String? storeOwnerName;

  Store({this.id, this.storeOwnerName});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json['id'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
      };
}
