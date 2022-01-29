class Product {
  int? id;
  String? productName;
  String? productImage;
  double? productPrice;
  int? storeOwnerProfileId;
  int? storeProductCategoryId;
  int? discount;
  String? description;
  String? status;
  int? productQuantity;
  int? commission;
  bool? isCommission;
  int? userQuantity;
  int? maxQuantity;
  String? quantity;
  bool? attention;

  Product({
    this.id,
    this.productName,
    this.productImage,
    this.productPrice,
    this.storeOwnerProfileId,
    this.storeProductCategoryId,
    this.discount,
    this.description,
    this.status,
    this.productQuantity,
    this.commission,
    this.isCommission,
    this.userQuantity,
    this.maxQuantity,
    this.quantity,
    this.attention,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        productName: json['productName'] as String?,
        productImage: json['productImage'] as String?,
        productPrice: (json['productPrice'] as num?)?.toDouble(),
        storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
        storeProductCategoryId: json['storeProductCategoryID'] as int?,
        discount: json['discount'] as int?,
        description: json['description'] as String?,
        status: json['status'] as String?,
        productQuantity: json['productQuantity'] as int?,
        commission: json['commission'] as int?,
        isCommission: json['isCommission'] as bool?,
        userQuantity: json['userQuantity'] as int?,
        maxQuantity: json['maxQuantity'] as int?,
        quantity: json['quantity'] as String?,
        attention: json['attention'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productImage': productImage,
        'productPrice': productPrice,
        'storeOwnerProfileID': storeOwnerProfileId,
        'storeProductCategoryID': storeProductCategoryId,
        'discount': discount,
        'description': description,
        'status': status,
        'productQuantity': productQuantity,
        'commission': commission,
        'isCommission': isCommission,
        'userQuantity': userQuantity,
        'maxQuantity': maxQuantity,
        'quantity': quantity,
        'attention': attention,
      };
}
