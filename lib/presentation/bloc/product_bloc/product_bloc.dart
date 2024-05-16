import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/constants/hive_constants.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/entity/product_hive_model.dart';
import 'package:shoppy/domain/mappers/product_mapper.dart';
import 'package:shoppy/domain/usecase/fetch_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductUseCase _fetchProductUseCase;
  final ConnectionChecker _connectionChecker;
  ProductBloc(
      {required FetchProductUseCase fetchProductUseCase,
      required ConnectionChecker connectionChecker})
      : _fetchProductUseCase = fetchProductUseCase,
        _connectionChecker = connectionChecker,
        super(ProductInitialState()) {
    on<ProductFetchEvent>(_fetchProductsHandler);
  }

  Future<void> _fetchProductsHandler(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoadingState());
    bool isConnected = await _connectionChecker.isConnected;
    if (!isConnected) {
      final List<Product> cachedData = await _getProductsFromHive();
      if (cachedData.isEmpty) {
        emit(const ProductFailureState(
            "Oops! It seems you're offline. Please check your internet connection"));
      } else {
        emit(ProductLoadedState(cachedData));
      }
      return;
    }
    final response = await _fetchProductUseCase.call(NoParams());
    response.fold((failure) {
      emit(ProductFailureState(failure.message));
    }, (products) {
      _insertProductToHive(products);
      emit(ProductLoadedState(products));
    });
  }
}

_insertProductToHive(List<Product> products) async {
  try {
    final productBox = Hive.box<ProductHiveModel>(HiveConstants.productBox);
    await productBox.clear();

    final List<ProductHiveModel> hiveList = ProductMapper.toHiveList(products);
    productBox.addAll(hiveList);
  } catch (e) {
    log("failed to save product to hive $e");
  }
}

Future<List<Product>> _getProductsFromHive() async {
  try {
    final productBox = Hive.box<ProductHiveModel>(HiveConstants.productBox);
    List<ProductHiveModel> hiveList = productBox.values.toList();
    return ProductMapper.toProductList(hiveList);
  } catch (e) {
    log("failed to fetch data from hive $e");
    return [];
  }
}
