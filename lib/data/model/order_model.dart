import 'dart:convert';

import 'package:shoppy/core/utils/typedef.dart';

import 'package:shoppy/data/model/product_model.dart';
import 'package:shoppy/domain/entity/order.dart';

OrderResultModel orderModelFromJson(String str) =>
    OrderResultModel.fromJson(json.decode(str));

class OrderResultModel extends OrderResult {
  OrderResultModel(
      {required super.errorCode, required super.data, required super.message});

  factory OrderResultModel.fromJson(Map<String, dynamic> json) =>
      OrderResultModel(
        errorCode: json["error_code"],
        data: Datamodel.fromJson(json["data"]),
        message: json["message"],
      );
}

class Datamodel extends Data {
  Datamodel();

  factory Datamodel.fromJson(Map<String, dynamic> json) => Datamodel();
}

class OrderCreateModel {
  final int  customerId;
  final List<ProductModel> productList;
  final double totalAmount;

  OrderCreateModel(
      {required this.customerId,
      required this.productList,
      required this.totalAmount});

  DataMap toJson() => {
        "customer_id": customerId,
        "total_price": totalAmount,
        "products": List.generate(productList.length, (index) {
          return {
            "product_id": productList[index].id,
            "quantity": productList[index].quantity,
            "price": productList[index].price
          };
        })
      };
}
