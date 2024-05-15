import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/data/datasource/remote_data_source.dart';
import 'package:shoppy/data/repository_impl/repository_impl.dart';
import 'package:shoppy/domain/repositories/repository.dart';
import 'package:shoppy/domain/usecase/create_order_usecase.dart';
import 'package:shoppy/domain/usecase/fetch_customers_usecase.dart';
import 'package:shoppy/domain/usecase/fetch_product_usecase.dart';
import 'package:shoppy/domain/usecase/search_customer_usecase.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:shoppy/presentation/bloc/product_bloc/product_bloc.dart';

final locator = GetIt.instance;

Future init() async {
  locator.registerLazySingleton(() => http.Client());

  locator.registerFactory(() => InternetConnection());
  locator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(locator()));
  _datasource();
  _repository();
  _usecases();
  _blocs();
}

void _blocs() {
  locator.registerFactory(() => ProductBloc(
      fetchProductUseCase: locator(), connectionChecker: locator()));
  locator.registerFactory(() => CartBloc());
  locator.registerFactory(() => CustomerBloc(
      connectionChecker: locator(), fetchCustomersUseCase: locator(),searchCustomerUseCase: locator()));
  locator.registerFactory(() => OrderBloc(
      connectionChecker: locator(), createOrderUsecase: locator()));
}

void _usecases() {
  locator.registerLazySingleton(() => FetchProductUseCase(locator()));
  locator.registerLazySingleton(() => FetchCustomersUseCase(locator()));
  locator.registerLazySingleton(() => CreateOrderUsecase(locator()));
  locator.registerLazySingleton(() => SearchCustomerUseCase(locator()));
}

void _repository() {
  locator.registerLazySingleton<Repository>(() => RepositoryImpl(locator()));
}

void _datasource() {
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(locator()));
}
