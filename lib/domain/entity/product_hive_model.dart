import 'package:hive_flutter/hive_flutter.dart';
 part 'product_hive_model.g.dart';
@HiveType(typeId: 0)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final DateTime createdDate;
  @HiveField(5)
  final String createdTime;
  @HiveField(6)
  final DateTime modifiedDate;
  @HiveField(7)
  final String modifiedTime;
  @HiveField(8)
  final bool flag;
  @HiveField(9)
  final int quantity;
  @HiveField(10)
  final double totalAmount;

  ProductHiveModel(this.quantity, this.totalAmount,
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.createdDate,
      required this.createdTime,
      required this.modifiedDate,
      required this.modifiedTime,
      required this.flag});
}
