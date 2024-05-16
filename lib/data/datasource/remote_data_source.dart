import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:shoppy/core/errors/error.dart';
import 'package:shoppy/core/constants/api_constants.dart';
import 'package:shoppy/data/model/customer_model.dart';
import 'package:shoppy/data/model/order_model.dart';
import 'package:shoppy/data/model/product_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<ProductResult> fetchProducts();
  Future<CustomerResult> fetchCustomers();
  Future<CustomerResult> serachCustomers(String searchText);
  Future<OrderResultModel> createOrder(OrderCreateModel order);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;

  RemoteDataSourceImpl(this._client);
  @override
  Future<ProductResult> fetchProducts() async {
    try {
      final Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.products);
      final response = await _client.get(url, headers: ApiConstants.headers());

      if (response.statusCode == 200) {
        return productResultFromJson(response.body);
      } else {
        throw ServerException(
            code: response.statusCode, message: response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        log(e.toString());
        throw NoConnectionException();
      }
    }
  }

  @override
  Future<CustomerResult> fetchCustomers() async {
    try {
      final Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.customers);
      final response = await _client.get(url, headers: ApiConstants.headers());
      if (response.statusCode == 200) {
        return customerResultFromJson(response.body);
      } else {
        throw ServerException(
            code: response.statusCode, message: response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        log(e.toString());
        throw NoConnectionException();
      }
    }
  }

  @override
  Future<OrderResultModel> createOrder(OrderCreateModel order) async {
    try {
      final Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.orders);
      final response = await _client.post(url,
          headers: ApiConstants.headers(), body: jsonEncode(order.toJson()));
      if (response.statusCode == 200) {
        return orderModelFromJson(response.body);
      } else {
        throw ServerException(
            code: response.statusCode, message: response.body);
      }
    } catch (e) {
      log("Order failed $e");
      if (e is HttpException) {
        throw ServerException(code: 404, message: e.message);
      }
      throw NoConnectionException();
    }
  }

  @override
  Future<CustomerResult> serachCustomers(String searchText) async {
    try {
      final Uri url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.searchCustomer(name: searchText));
      final response = await _client.get(url, headers: ApiConstants.headers());
      if (response.statusCode == 200) {
        return customerResultFromJson(response.body);
      } else {
        throw ServerException(
            code: response.statusCode, message: response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        log(e.toString());
        throw NoConnectionException();
      }
    }
  }
}
