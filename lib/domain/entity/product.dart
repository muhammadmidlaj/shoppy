// class ProductResult {
//   final int errorCode;
//   final List<Product> data;
//   final String message;

//   ProductResult({
//     required this.errorCode,
//     required this.data,
//     required this.message,
//   });
// }

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final DateTime createdDate;
  final String createdTime;
  final DateTime modifiedDate;
  final String modifiedTime;
  final bool flag;
  int quantity;
  double totalAmount;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdDate,
    required this.createdTime,
    required this.modifiedDate,
    required this.modifiedTime,
    required this.flag,
    this.quantity = 0,
    this.totalAmount = 0.0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        createdDate,
        createdTime,
        modifiedDate,
        modifiedTime,
        flag,
      ];
}
