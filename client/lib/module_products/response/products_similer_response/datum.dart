import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details_response.dart';

import 'image.dart';
import 'store.dart';

class Datum {
  int? id;
  String? productName;
  int? productPrice;
  dynamic productQuantity;
  int? storeOwnerProfileId;
  int? storeProductCategoryId;
  Image? image;
  int? discount;
  dynamic description;
  dynamic rate;
  dynamic soldCount;
  String? status;
  Store? store;
  int? productPriceWithOutCommission;
  CostDetailsResponse? costDetails;
  dynamic commission;
  dynamic isLevel1;
  dynamic isLevel2;

  Datum({
    this.id,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.storeOwnerProfileId,
    this.storeProductCategoryId,
    this.image,
    this.discount,
    this.description,
    this.rate,
    this.soldCount,
    this.status,
    this.store,
    this.productPriceWithOutCommission,
    this.costDetails,
    this.commission,
    this.isLevel1,
    this.isLevel2,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        productName: json['productName'] as String?,
        productPrice: json['productPrice'] as int?,
        productQuantity: json['productQuantity'] as dynamic,
        storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
        storeProductCategoryId: json['storeProductCategoryID'] as int?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        discount: json['discount'] as int?,
        description: json['description'] as dynamic,
        rate: json['rate'] as dynamic,
        soldCount: json['soldCount'] as dynamic,
        status: json['status'] as String?,
        store: json['store'] == null
            ? null
            : Store.fromJson(json['store'] as Map<String, dynamic>),
        productPriceWithOutCommission:
            json['productPriceWithOutCommission'] as int?,
        costDetails: json['costDetails'] == null
            ? null
            : CostDetailsResponse.fromJson(json['costDetails'] as Map<String, dynamic>),
        commission: json['commission'] as dynamic,
        isLevel1: json['isLevel1'] as dynamic,
        isLevel2: json['isLevel2'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productPrice': productPrice,
        'productQuantity': productQuantity,
        'storeOwnerProfileID': storeOwnerProfileId,
        'storeProductCategoryID': storeProductCategoryId,
        'image': image?.toJson(),
        'discount': discount,
        'description': description,
        'rate': rate,
        'soldCount': soldCount,
        'status': status,
        'store': store?.toJson(),
        'productPriceWithOutCommission': productPriceWithOutCommission,
        'costDetails': costDetails,
        'commission': commission,
        'isLevel1': isLevel1,
        'isLevel2': isLevel2,
      };
}
