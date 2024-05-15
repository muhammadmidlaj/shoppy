import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppy/core/utils/hive_constants.dart';
import 'package:shoppy/domain/entity/cart.dart';
import 'package:shoppy/domain/entity/cart_hive_model.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/customer_hive_model.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/entity/product_hive_model.dart';
import 'package:shoppy/domain/mappers/customer_mapper.dart';
import 'package:shoppy/domain/mappers/product_mapper.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartInitialState(cart: Cart(const []), totalAmount: 0.00)) {
    on<AddProductToCartEvent>(_addToCartHandler);
    on<CartProductIncrementEvent>(_incrementProductHandler);
    on<CartProductDecrementEvent>(_decrementProductHandler);
    on<CartAddCustomerEvent>(_addCustomerHandler);
    on<CartClearEvent>(_clearCarthandler);
    on<CartFetchLocalEvent>(_fetchLocalHandler);
  }

  // ignore: prefer_const_literals_to_create_immutables
  Cart _cart = Cart([]);
  Cart get cart => _cart;
  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;

  Customer _selectedCustomer = Customer.empty();

  Future<void> _addToCartHandler(
      AddProductToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState(cart: _cart, totalAmount: _totalAmount));
    event.product.quantity = 1;
    event.product.totalAmount = event.product.price * event.product.quantity;
    _cart.cartItems.add(event.product);
    _totalAmount = getTotalAmount();
    _insertCartDataToHive(_cart.cartItems, _selectedCustomer,
        _totalAmount); // insert data to hive
    emit(ProductAddedState(
        cart: _cart, totalAmount: _totalAmount, customer: _selectedCustomer));
  }

  Future<void> _incrementProductHandler(
      CartProductIncrementEvent event, Emitter<CartState> emit) async {
    Product product =
        _cart.cartItems.firstWhere((element) => event.product.id == element.id);
    product.quantity += 1;
    product.totalAmount = product.price * product.quantity;

    _totalAmount = getTotalAmount();
    _insertCartDataToHive(_cart.cartItems, _selectedCustomer, _totalAmount);
    emit(CartProductIncrementedState(
        cart: cart, totalAmount: totalAmount, customer: _selectedCustomer));
  }

  double getTotalAmount() {
    double total = 0.00;
    for (Product product in _cart.cartItems) {
      total += product.price * product.quantity;
    }

    return total;
  }

  Future<void> _decrementProductHandler(
      CartProductDecrementEvent event, Emitter<CartState> emit) async {
    Product product =
        _cart.cartItems.firstWhere((element) => event.product.id == element.id);
    if (product.quantity <= 1) {
      _cart.cartItems.remove(product);
    } else {
      product.quantity -= 1;
      product.totalAmount = product.quantity * product.price;
    }

    _totalAmount = getTotalAmount();
    _insertCartDataToHive(_cart.cartItems, _selectedCustomer, _totalAmount);
    emit(CartProductDecrementedState(
        cart: cart, totalAmount: totalAmount, customer: _selectedCustomer));
  }

  Future<void> _addCustomerHandler(
      CartAddCustomerEvent event, Emitter<CartState> emit) async {
    _totalAmount = getTotalAmount();
    _selectedCustomer = event.customer;
    _insertCartDataToHive(_cart.cartItems, _selectedCustomer, _totalAmount);
    emit(CartCustomerAddedState(
        cart: cart,
        totalAmount: totalAmount,
        selectedCustomer: event.customer));
  }

  Future<void> _clearCarthandler(
      CartClearEvent event, Emitter<CartState> emit) async {
    _cart.cartItems.clear();
    _selectedCustomer = Customer.empty();
    _totalAmount = 0.00;
    _clearLocalData();
    emit(CartClearedState(cart: _cart, totalAmount: totalAmount));
  }

  Future<void> _fetchLocalHandler(
      CartFetchLocalEvent event, Emitter<CartState> emit) async {
    CartHiveModel? cachedData = _getCartDataFromHive();
    if (cachedData != null) {
      _totalAmount = cachedData.totalAmount;
      _cart = Cart(ProductMapper.toProductList(cachedData.products));
      _selectedCustomer = CustomerMapper.toCustomer(cachedData.customer);
      emit(ProductAddedState(
          cart: _cart, totalAmount: totalAmount, customer: _selectedCustomer));
    }
  }
}

_insertCartDataToHive(
    List<Product> productList, Customer customer, double total) async {
  final List<ProductHiveModel> productHiveList =
      ProductMapper.toHiveList(productList);
  final CustomerHiveModel customerHive = CustomerMapper.toHiveModel(customer);

  final CartHiveModel cartHive = CartHiveModel(
      customer: customerHive, products: productHiveList, totalAmount: total);

  final cartBox = Hive.box<CartHiveModel>(HiveConstants.cartBox);

  await cartBox.clear();
  cartBox.add(cartHive);
  log("cart insert => ${cartBox.length}");
}

CartHiveModel? _getCartDataFromHive() {
  final cartBox = Hive.box<CartHiveModel>(HiveConstants.cartBox);
  if (cartBox.isNotEmpty) {
    final CartHiveModel cart = cartBox.values.first;
    log("cart data from hive ${cart.totalAmount}");
    return cart;
  }
  log("cart local data is empty");
  return null;
}

_clearLocalData() {
  final cartBox = Hive.box<CartHiveModel>(HiveConstants.cartBox);
  cartBox.clear();
}
