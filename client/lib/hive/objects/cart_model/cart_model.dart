import 'package:hive/hive.dart';
part 'cart_model.g.dart';
@HiveType(typeId: 0)
class CartModel extends HiveObject{
  @HiveField(0)
  int id;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  double price;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? image;

  CartModel({required this.id,required this.quantity,required this.price,this.image,this.name});
}