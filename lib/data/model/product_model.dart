// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:shoppy/domain/entity/product.dart';

ProductResult productResultFromJson(String str) =>
    ProductResult.fromJson(json.decode(str));

// String productResultToJson(ProductResultModel data) => json.encode(data.toJson());

class ProductResult{
  final int errorCode;
  final List<ProductModel> data;
  final String message;
  factory ProductResult.fromJson(Map<String, dynamic> json) =>
      ProductResult(
        errorCode: json["error_code"],
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
        message: json["message"],
      );

  ProductResult(
      {required this.errorCode, required this.data, required this.message});

  // Map<String, dynamic> toJson() => {
  //       "error_code": errorCode,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //       "message": message,
  //     };
}

class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.price,
      required super.createdDate,
      required super.createdTime,
      required super.modifiedDate,
      required super.modifiedTime,
      required super.flag});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: double.parse(json["price"].toString()),
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };
}
