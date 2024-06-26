part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final Cart cart;
  final double totalAmount;
  final Customer selectedCustomer;
  CartState({required this.cart, required this.totalAmount, Customer? customer})
      : selectedCustomer = customer ?? Customer.empty();

  @override
  List<Object> get props => [cart];
}

class CartInitialState extends CartState {
  CartInitialState({required super.totalAmount, required super.cart});
}

class CartLoadingState extends CartState {
  CartLoadingState({required super.cart, required super.totalAmount});
}

class ProductAddedState extends CartState {
  ProductAddedState(
      {required super.cart,
      required super.totalAmount,
      required super.customer});
}

class CartProductDecrementedState extends CartState {
  CartProductDecrementedState(
      {required super.cart,
      required super.totalAmount,
      required super.customer});
  @override
  List<Object> get props => [cart, totalAmount];
}

class CartProductIncrementedState extends CartState {
  CartProductIncrementedState(
      {required super.cart,
      required super.totalAmount,
      required super.customer});

  @override
  List<Object> get props => [cart, totalAmount];
}

class CartCustomerAddedState extends CartState {
  CartCustomerAddedState(
      {required super.cart,
      required super.totalAmount,
      required Customer selectedCustomer})
      : super(customer: selectedCustomer);

  @override
  List<Object> get props => [
        cart,
        totalAmount,
      ];
}

class CartClearedState extends CartState {
  CartClearedState({required super.cart, required super.totalAmount});

  @override
  List<Object> get props => [
        cart,
        totalAmount,
      ];
}
