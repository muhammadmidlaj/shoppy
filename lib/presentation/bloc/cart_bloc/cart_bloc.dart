import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppy/domain/entity/cart.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartInitialState(cart: Cart(const []), totalAmount: 0.00)) {
    on<AddProductToCartEvent>(_addToCartHandler);
    on<CartProductIncrementEvent>(_incrementProductHandler);
    on<CartProductDecrementEvent>(_decrementProductHandler);
  }

  final Cart _cart = Cart([]);
  Cart get cart => _cart;
  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;

  Future<void> _addToCartHandler(
      AddProductToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState(cart: _cart, totalAmount: _totalAmount));
    event.product.quantity = 1;
    _cart.cartItems.add(event.product);
    _totalAmount = getTotalAmount();
    emit(ProductAddedState(cart: _cart, totalAmount: _totalAmount));
  }

  Future<void> _incrementProductHandler(
      CartProductIncrementEvent event, Emitter<CartState> emit) async {
    Product product =
        _cart.cartItems.firstWhere((element) => event.product.id == element.id);
    product.quantity += 1;
    product.totalAmount = product.price * product.quantity;

    _totalAmount = getTotalAmount();
    emit(CartProductIncrementedState(cart: cart, totalAmount: totalAmount));
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

    emit(CartProductDecrementedState(cart: cart, totalAmount: totalAmount));
  }
}
