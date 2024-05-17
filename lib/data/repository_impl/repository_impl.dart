import 'package:dartz/dartz.dart';
import 'package:shoppy/core/errors/error.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/data/datasource/remote_data_source.dart';
import 'package:shoppy/data/model/order_model.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/order.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/mappers/product_mapper.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);
  @override
  Result<List<Product>> fetchProducts() async {
    try {
      final response = await _remoteDataSource.fetchProducts();
      return Right(response.data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoConnectionException catch (e) {
      return Left(InterNetFailure(message: e.message));
    }
  }

  @override
  Result<List<Customer>> fetchCustomers() async {
    try {
      final response = await _remoteDataSource.fetchCustomers();
      return Right(response.data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoConnectionException catch (e) {
      return Left(InterNetFailure(message: e.message));
    }
  }

  @override
  Result<OrderResult> createOrder(
      {required Customer customer,
      required double totalAmount,
      required List<Product> products}) async {
    try {
      OrderCreateModel order = OrderCreateModel(
          customerId: customer.id,
          productList: ProductMapper.toModelList(products),
          totalAmount: totalAmount);
      final response = await _remoteDataSource.createOrder(order);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoConnectionException catch (e) {
      return Left(InterNetFailure(message: e.message));
    }
  }

  @override
  Result<List<Customer>> searchCustomers(String searchText) async {
    try {
      final response = await _remoteDataSource.serachCustomers(searchText);
      return Right(response.data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoConnectionException catch (e) {
      return Left(InterNetFailure(message: e.message));
    }
  }
}
