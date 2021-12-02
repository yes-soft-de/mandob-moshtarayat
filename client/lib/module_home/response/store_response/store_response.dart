import 'package:json_annotation/json_annotation.dart';

part 'store_response.g.dart';

@JsonSerializable()
class StoreResponse {
  final int? id;
  final String? storeOwnerName;

  const StoreResponse({this.id, this.storeOwnerName});

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return _$StoreResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}
