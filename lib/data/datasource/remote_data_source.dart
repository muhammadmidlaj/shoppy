import 'dart:core';
import 'dart:developer';

import 'package:shoppy/core/errors/error.dart';
import 'package:shoppy/core/utils/api_constants.dart';
import 'package:shoppy/data/model/customer_model.dart';
import 'package:shoppy/data/model/product_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<ProductResult> fetchProducts();
  Future<CustomerResult> fetchCustomers();
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
}
