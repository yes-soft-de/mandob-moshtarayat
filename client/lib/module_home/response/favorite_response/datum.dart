import 'store.dart';

class Datum {
  int? id;
  String? storeCategoryName;
  List<Store>? stores;

  Datum({this.id, this.storeCategoryName, this.stores});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        storeCategoryName: json['storeCategoryName'] as String?,
        stores: (json['stores'] as List<dynamic>?)
            ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeCategoryName': storeCategoryName,
        'stores': stores?.map((e) => e.toJson()).toList(),
      };
}
