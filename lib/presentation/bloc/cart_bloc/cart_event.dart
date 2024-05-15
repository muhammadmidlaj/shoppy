part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  const AddProductToCartEvent(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveProductFromCartEvent extends CartEvent {
  final Product product;

  const RemoveProductFromCartEvent(this.product);
  @override
  List<Object> get props => [product];
}

class CartProductIncrementEvent extends CartEvent {
  final Product product;

  const CartProductIncrementEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class CartProductDecrementEvent extends CartEvent {
  final Product product;

  const CartProductDecrementEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class CartAddCustomerEvent extends CartEvent {
  final Customer customer;

  const CartAddCustomerEvent({required this.customer});

  @override
  List<Object> get props => [customer];
}

class CartClearEvent extends CartEvent {
  const CartClearEvent();
  @override
  List<Object> get props => [];
}

class CartFetchLocalEvent extends CartEvent {
  const CartFetchLocalEvent();
  @override
  List<Object> get props => [];
}
