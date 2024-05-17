import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppy/domain/entity/customer_hive_model.dart';
import 'package:shoppy/domain/entity/product_hive_model.dart';
part 'cart_hive_model.g.dart';

@HiveType(typeId: 3)
class CartHiveModel extends HiveObject {
  @HiveField(0)
  final CustomerHiveModel customer;
  @HiveField(1)
  final List<ProductHiveModel> products;
  @HiveField(2)
  final double totalAmount;

  CartHiveModel({required this.customer, required this.products, required this.totalAmount});
}
